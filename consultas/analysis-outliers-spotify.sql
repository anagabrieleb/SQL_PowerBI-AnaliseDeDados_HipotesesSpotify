-- Consulta: Identificar e exibir somente os outliers na view vw_spotify_info

WITH limites AS (
  SELECT
    APPROX_QUANTILES(in_spotify_playlists, 4)[OFFSET(1)] AS q1_playlists,
    APPROX_QUANTILES(in_spotify_playlists, 4)[OFFSET(3)] AS q3_playlists,
    APPROX_QUANTILES(in_spotify_charts, 4)[OFFSET(1)] AS q1_charts,
    APPROX_QUANTILES(in_spotify_charts, 4)[OFFSET(3)] AS q3_charts,
    APPROX_QUANTILES(streams_int, 4)[OFFSET(1)] AS q1_streams,
    APPROX_QUANTILES(streams_int, 4)[OFFSET(3)] AS q3_streams
  FROM `lab025-p002.views.vw_spotify_info`
),
outliers AS (
  SELECT
    s.track_id,
    s.track_name,
    s.in_spotify_playlists,
    (s.in_spotify_playlists < q1_playlists - 1.5 * (q3_playlists - q1_playlists) OR 
     s.in_spotify_playlists > q3_playlists + 1.5 * (q3_playlists - q1_playlists)) AS playlist_outlier,
     
    s.in_spotify_charts,
    (s.in_spotify_charts < q1_charts - 1.5 * (q3_charts - q1_charts) OR 
     s.in_spotify_charts > q3_charts + 1.5 * (q3_charts - q1_charts)) AS chart_outlier,
     
    s.streams_int,
    (s.streams_int < q1_streams - 1.5 * (q3_streams - q1_streams) OR 
     s.streams_int > q3_streams + 1.5 * (q3_streams - q1_streams)) AS streams_outlier
  FROM `lab025-p002.views.vw_spotify_info` s
  JOIN limites ON TRUE
)
SELECT *
FROM outliers
WHERE playlist_outlier OR chart_outlier OR streams_outlier;

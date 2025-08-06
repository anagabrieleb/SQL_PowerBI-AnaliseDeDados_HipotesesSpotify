CREATE OR REPLACE VIEW `lab025-p002.further_analysis.vw_streamings` AS (
SELECT
  spotify.track_id,
  spotify.track_name,
  spotify.artists_name,
  spotify.released_data,

  spotify.streams_int,
  spotify.in_spotify_playlists,
  spotify.in_spotify_charts,

  competition.in_apple_playlists,
  competition.in_apple_charts,
  competition.in_deezer_playlists,
  competition.in_deezer_charts,
  competition.in_shazam_charts,

  -- 1) Quantidade de dias desde lançamento até 31/12/2023
  DATE_DIFF(DATE('2023-12-31'), spotify.released_data, DAY) AS days_since_release,

  -- 2) Média de streams por dia (tratando caso divisão por zero)
  IF(DATE_DIFF(DATE('2023-12-31'), spotify.released_data, DAY) > 0,
     ROUND(spotify.streams_int / DATE_DIFF(DATE('2023-12-31'), spotify.released_data, DAY), 0),
     0) AS avg_streams_per_day,

  -- 3) Soma das charts (com tratamento de valores nulos)
  (
    COALESCE(spotify.in_spotify_charts, 0) +
    COALESCE(competition.in_apple_charts, 0) +
    COALESCE(competition.in_deezer_charts, 0) +
    COALESCE(competition.in_shazam_charts, 0)
  ) AS total_charts,

  -- 4) Soma das playlists (com tratamento de valores nulos)
  (
    COALESCE(spotify.in_spotify_playlists, 0) +
    COALESCE(competition.in_apple_playlists, 0) +
    COALESCE(competition.in_deezer_playlists, 0)
  ) AS total_playlists

FROM `lab025-p002.views.vw_spotify_info` AS spotify
LEFT JOIN `lab025-p002.views.vw_competition` AS competition
  ON TRIM(spotify.track_id) = TRIM(competition.track_id)
);

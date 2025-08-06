CREATE OR REPLACE VIEW `lab025-p002.views.vw_faixas_explodidas_por_artista` AS

SELECT
  TRIM(track_id) AS track_id,
  TRIM(artist) AS artist,
  artist_count,
  streams_int,
  in_spotify_playlists,
  in_spotify_charts
FROM `lab025-p002.views.vw_spotify_info`,
UNNEST(
  CASE
    WHEN artist_count > 1 THEN SPLIT(artists_name, ',')
    ELSE [artists_name]
  END
) AS artist;

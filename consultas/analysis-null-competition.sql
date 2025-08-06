SELECT
  COUNT(*) AS total_linhas,
  COUNTIF(track_id IS NULL) AS track_id_nulos,
  COUNTIF(in_apple_playlists IS NULL) AS in_apple_playlists_nulos,
  COUNTIF(in_apple_charts IS NULL) AS in_apple_charts_nulos,
  COUNTIF(in_deezer_playlists IS NULL) AS in_deezer_playlists_nulos,
  COUNTIF(in_deezer_charts IS NULL) AS in_deezer_charts_nulos,
  COUNTIF(in_shazam_charts IS NULL) AS in_shazam_charts_nulos
FROM `lab025-p002.dt_spotify2023.track_in_competition`;
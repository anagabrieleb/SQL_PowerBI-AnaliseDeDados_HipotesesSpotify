SELECT 
  COUNT (*) AS linhas_totais,
  COUNTIF(track_id IS NULL) AS track_id_nulos,
  COUNTIF(track_name IS NULL) AS track_name_nulos,
  COUNTIF(artists_name IS NULL) AS artists_names_nulos,
  COUNTIF(artist_count IS NULL) AS artist_count_nulos,
  COUNTIF(released_year IS NULL) AS released_year_nulos,
  COUNTIF(released_month IS NULL) AS released_month_nulos,
  COUNTIF(released_day IS NULL) AS released_day_nulos,
  COUNTIF(in_spotify_playlists IS NULL) AS in_spotify_playlists_nulos,
  COUNTIF(in_spotify_charts IS NULL) AS in_spotify_charts_nulos,
  COUNTIF(streams IS NULL) AS streams_nulos
FROM `lab025-p002.dt_spotify2023.spotify`;
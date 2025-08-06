WITH dados AS (
  SELECT
    `danceability_%` AS danceability_percent,
    `valence_%` AS valence_percent,
    `energy_%` AS energy_percent,
    `acousticness_%` AS acousticness_percent,
    `instrumentalness_%` AS instrumentalness_percent,
    `liveness_%` AS liveness_percent,
    `speechiness_%` AS speechiness_percent,
    track_id, bpm, `key`, mode
  FROM `lab025-p002.dt_spotify2023.technical_info`
)

SELECT 
  COUNT(*) AS total_linhas,
  COUNTIF(track_id IS NULL) AS track_id_nulos,
  COUNTIF(bpm IS NULL) AS bpm_nulos,
  COUNTIF(key IS NULL) AS key_nulos,
  COUNTIF(mode IS NULL) AS mode_nulos,
  COUNTIF(danceability_percent IS NULL) AS danceability_nulos,
  COUNTIF(valence_percent IS NULL) AS valence_nulos,
  COUNTIF(energy_percent IS NULL) AS energy_nulos,
  COUNTIF(acousticness_percent IS NULL) AS acousticness_nulos,
  COUNTIF(instrumentalness_percent IS NULL) AS instrumentalness_nulos,
  COUNTIF(liveness_percent IS NULL) AS liveness_nulos,
  COUNTIF(speechiness_percent IS NULL) AS speechiness_nulos
FROM dados
SELECT 
  *, 
  COUNT(*) AS quant_freq
FROM `lab025-p002.dt_spotify2023.technical_info`
GROUP BY 
  track_id, bpm, `key`, mode, `danceability_%`, `valence_%`, `energy_%`, 
  `acousticness_%`, `instrumentalness_%`, `liveness_%`, `speechiness_%`
HAVING COUNT(*) > 1;
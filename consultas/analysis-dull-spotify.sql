SELECT 
  track_name, artists_name,
  COUNT(*) AS quant_freq
FROM `lab025-p002.dt_spotify2023.spotify`
GROUP BY 
  track_name, artists_name
HAVING COUNT(*) > 1;
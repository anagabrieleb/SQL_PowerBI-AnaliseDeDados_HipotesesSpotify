SELECT 
  *, 
  COUNT(*) AS quant_freq
FROM `lab025-p002.dt_spotify2023.track_in_competition`
GROUP BY 
  track_id, in_apple_playlists, in_apple_charts, in_deezer_playlists, in_deezer_charts, in_shazam_charts
HAVING COUNT(*) > 1;
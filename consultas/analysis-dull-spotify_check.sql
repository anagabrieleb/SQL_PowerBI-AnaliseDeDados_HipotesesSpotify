WITH duplicadas AS (
  SELECT 
    track_name, 
    artists_name,
    COUNT(*) AS quant_freq
  FROM `lab025-p002.dt_spotify2023.spotify`
  GROUP BY track_name, artists_name
  HAVING COUNT(*) > 1
)

SELECT *
FROM `lab025-p002.dt_spotify2023.spotify` AS t
JOIN duplicadas AS d
ON t.track_name = d.track_name AND t.artists_name = d.artists_name;
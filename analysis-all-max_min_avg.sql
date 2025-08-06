-- Relatório completo com IQR para todas as colunas analisadas nas 3 views

WITH estatisticas AS (
  -- vw_technical_info
  SELECT 'bpm' AS coluna, bpm AS valor FROM `lab025-p002.views.vw_technical_info`
  UNION ALL SELECT 'danceability', danceability FROM `lab025-p002.views.vw_technical_info`
  UNION ALL SELECT 'valence', valence FROM `lab025-p002.views.vw_technical_info`
  UNION ALL SELECT 'energy', energy FROM `lab025-p002.views.vw_technical_info`
  UNION ALL SELECT 'acousticness', acousticness FROM `lab025-p002.views.vw_technical_info`
  UNION ALL SELECT 'instrumentalness', instrumentalness FROM `lab025-p002.views.vw_technical_info`
  UNION ALL SELECT 'liveness', liveness FROM `lab025-p002.views.vw_technical_info`
  UNION ALL SELECT 'speechiness', speechiness FROM `lab025-p002.views.vw_technical_info`

  -- vw_spotify_info
  UNION ALL SELECT 'artist_count', artist_count FROM `lab025-p002.views.vw_spotify_info_ok`
  UNION ALL SELECT 'in_spotify_playlists', in_spotify_playlists FROM `lab025-p002.views.vw_spotify_info_ok`
  UNION ALL SELECT 'in_spotify_charts', in_spotify_charts FROM `lab025-p002.views.vw_spotify_info_ok`
  UNION ALL SELECT 'streams_int', streams_int FROM `lab025-p002.views.vw_spotify_info_ok`

  -- vw_competition
  UNION ALL SELECT 'in_apple_playlists', in_apple_playlists FROM `lab025-p002.views.vw_competition`
  UNION ALL SELECT 'in_apple_charts', in_apple_charts FROM `lab025-p002.views.vw_competition`
  UNION ALL SELECT 'in_deezer_playlists', in_deezer_playlists FROM `lab025-p002.views.vw_competition`
  UNION ALL SELECT 'in_deezer_charts', in_deezer_charts FROM `lab025-p002.views.vw_competition`
  UNION ALL SELECT 'in_shazam_charts', CAST(in_shazam_charts AS FLOAT64) FROM `lab025-p002.views.vw_competition`
),

quartis AS (
  SELECT
    coluna,
    MIN(valor) AS min,
    MAX(valor) AS max,
    AVG(valor) AS media,
    APPROX_QUANTILES(valor, 4)[OFFSET(1)] AS q1,
    APPROX_QUANTILES(valor, 4)[OFFSET(3)] AS q3
  FROM estatisticas
  GROUP BY coluna
),

outliers AS (
  SELECT
    e.coluna,
    COUNT(*) AS total_outliers
  FROM estatisticas e
  JOIN quartis q ON e.coluna = q.coluna
  WHERE e.valor < (q.q1 - 1.5 * (q.q3 - q.q1))
     OR e.valor > (q.q3 + 1.5 * (q.q3 - q.q1))
  GROUP BY e.coluna
)

SELECT
  q.coluna,
  ROUND(q.min, 2) AS min,
  ROUND(q.max, 2) AS max,
  ROUND(q.media, 2) AS media,
  ROUND(q.q1, 2) AS q1,
  ROUND(q.q3, 2) AS q3,
  ROUND(q.q3 - q.q1, 2) AS iqr,
  ROUND(q.q1 - 1.5 * (q.q3 - q.q1), 2) AS limite_inferior,
  ROUND(q.q3 + 1.5 * (q.q3 - q.q1), 2) AS limite_superior,
  IFNULL(o.total_outliers, 0) AS total_outliers
FROM quartis q
LEFT JOIN outliers o ON q.coluna = o.coluna
ORDER BY total_outliers DESC;

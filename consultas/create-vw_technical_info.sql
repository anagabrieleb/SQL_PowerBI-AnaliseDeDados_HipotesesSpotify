CREATE OR REPLACE VIEW `lab025-p002.views.vw_technical_info` AS (
SELECT
  CASE 
    WHEN track_id = '0:00' THEN '1001429'
    ELSE track_id
  END AS track_id,

  bpm,

  `danceability_%`/100 AS danceability,
  `valence_%`/100 AS valence,
  `energy_%`/100 AS energy,
  `acousticness_%`/100 AS acousticness,
  `instrumentalness_%`/100 AS instrumentalness,
  `liveness_%`/100 AS liveness,
  `speechiness_%`/100 AS speechiness,

  `key` AS key_note,
  mode

FROM `lab025-p002.dt_spotify2023.technical_info`
WHERE track_id NOT IN ('5080031', '8173823')
);

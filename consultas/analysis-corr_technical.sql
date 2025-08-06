SELECT 'speechiness' AS variavel,
  CORR(speechiness, bpm) AS bpm,
  CORR(speechiness, danceability) AS danceability,
  CORR(speechiness, valence) AS valence,
  CORR(speechiness, energy) AS energy,
  CORR(speechiness, acousticness) AS acousticness,
  CORR(speechiness, instrumentalness) AS instrumentalness,
  CORR(speechiness, liveness) AS liveness,
  CORR(speechiness, speechiness) AS speechiness
FROM `lab025-p002.further_analysis.vw_union`

UNION ALL

SELECT 'liveness' AS variavel,
  CORR(liveness, bpm) AS bpm,
  CORR(liveness, danceability) AS danceability,
  CORR(liveness, valence) AS valence,
  CORR(liveness, energy) AS energy,
  CORR(liveness, acousticness) AS acousticness,
  CORR(liveness, instrumentalness) AS instrumentalness,
  CORR(liveness, liveness) AS liveness,
  CORR(liveness, speechiness) AS speechiness
FROM `lab025-p002.further_analysis.vw_union`

UNION ALL

SELECT 'instrumentalness' AS variavel,
  CORR(instrumentalness, bpm) AS bpm,
  CORR(instrumentalness, danceability) AS danceability,
  CORR(instrumentalness, valence) AS valence,
  CORR(instrumentalness, energy) AS energy,
  CORR(instrumentalness, acousticness) AS acousticness,
  CORR(instrumentalness, instrumentalness) AS instrumentalness,
  CORR(instrumentalness, liveness) AS liveness,
  CORR(instrumentalness, speechiness) AS speechiness
FROM `lab025-p002.further_analysis.vw_union`

UNION ALL

SELECT 'acousticness' AS variavel,
  CORR(acousticness, bpm) AS bpm,
  CORR(acousticness, danceability) AS danceability,
  CORR(acousticness, valence) AS valence,
  CORR(acousticness, energy) AS energy,
  CORR(acousticness, acousticness) AS acousticness,
  CORR(acousticness, instrumentalness) AS instrumentalness,
  CORR(acousticness, liveness) AS liveness,
  CORR(acousticness, speechiness) AS speechiness
FROM `lab025-p002.further_analysis.vw_union`

UNION ALL

SELECT 'energy' AS variavel,
  CORR(energy, bpm) AS bpm,
  CORR(energy, danceability) AS danceability,
  CORR(energy, valence) AS valence,
  CORR(energy, energy) AS energy,
  CORR(energy, acousticness) AS acousticness,
  CORR(energy, instrumentalness) AS instrumentalness,
  CORR(energy, liveness) AS liveness,
  CORR(energy, speechiness) AS speechiness
FROM `lab025-p002.further_analysis.vw_union`

UNION ALL

SELECT 'valence' AS variavel,
  CORR(valence, bpm) AS bpm,
  CORR(valence, danceability) AS danceability,
  CORR(valence, valence) AS valence,
  CORR(valence, energy) AS energy,
  CORR(valence, acousticness) AS acousticness,
  CORR(valence, instrumentalness) AS instrumentalness,
  CORR(valence, liveness) AS liveness,
  CORR(valence, speechiness) AS speechiness
FROM `lab025-p002.further_analysis.vw_union`

UNION ALL

SELECT 'danceability' AS variavel,
  CORR(danceability, bpm) AS bpm,
  CORR(danceability, danceability) AS danceability,
  CORR(danceability, valence) AS valence,
  CORR(danceability, energy) AS energy,
  CORR(danceability, acousticness) AS acousticness,
  CORR(danceability, instrumentalness) AS instrumentalness,
  CORR(danceability, liveness) AS liveness,
  CORR(danceability, speechiness) AS speechiness
FROM `lab025-p002.further_analysis.vw_union`

UNION ALL

SELECT 'bpm' AS variavel,
  CORR(bpm, bpm) AS bpm,
  CORR(bpm, danceability) AS danceability,
  CORR(bpm, valence) AS valence,
  CORR(bpm, energy) AS energy,
  CORR(bpm, acousticness) AS acousticness,
  CORR(bpm, instrumentalness) AS instrumentalness,
  CORR(bpm, liveness) AS liveness,
  CORR(bpm, speechiness) AS speechiness
FROM `lab025-p002.further_analysis.vw_union`
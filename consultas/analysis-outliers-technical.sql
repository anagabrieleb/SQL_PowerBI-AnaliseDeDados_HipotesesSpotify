-- Consulta 1: Identificar e exibir somente os outliers na view vw_technical_info

WITH limites AS (
  SELECT
    APPROX_QUANTILES(bpm, 4)[OFFSET(1)] AS q1_bpm,
    APPROX_QUANTILES(bpm, 4)[OFFSET(3)] AS q3_bpm,
    APPROX_QUANTILES(danceability, 4)[OFFSET(1)] AS q1_danceability,
    APPROX_QUANTILES(danceability, 4)[OFFSET(3)] AS q3_danceability,
    APPROX_QUANTILES(valence, 4)[OFFSET(1)] AS q1_valence,
    APPROX_QUANTILES(valence, 4)[OFFSET(3)] AS q3_valence,
    APPROX_QUANTILES(energy, 4)[OFFSET(1)] AS q1_energy,
    APPROX_QUANTILES(energy, 4)[OFFSET(3)] AS q3_energy,
    APPROX_QUANTILES(acousticness, 4)[OFFSET(1)] AS q1_acousticness,
    APPROX_QUANTILES(acousticness, 4)[OFFSET(3)] AS q3_acousticness,
    APPROX_QUANTILES(instrumentalness, 4)[OFFSET(1)] AS q1_instrumentalness,
    APPROX_QUANTILES(instrumentalness, 4)[OFFSET(3)] AS q3_instrumentalness,
    APPROX_QUANTILES(liveness, 4)[OFFSET(1)] AS q1_liveness,
    APPROX_QUANTILES(liveness, 4)[OFFSET(3)] AS q3_liveness,
    APPROX_QUANTILES(speechiness, 4)[OFFSET(1)] AS q1_speechiness,
    APPROX_QUANTILES(speechiness, 4)[OFFSET(3)] AS q3_speechiness
  FROM `lab025-p002.views.vw_technical_info`
),
outliers AS (
  SELECT
    t.track_id,
    t.bpm,
    (t.bpm < q1_bpm - 1.5 * (q3_bpm - q1_bpm) OR t.bpm > q3_bpm + 1.5 * (q3_bpm - q1_bpm)) AS bpm_outlier,
    t.danceability,
    (t.danceability < q1_danceability - 1.5 * (q3_danceability - q1_danceability) OR t.danceability > q3_danceability + 1.5 * (q3_danceability - q1_danceability)) AS danceability_outlier,
    t.valence,
    (t.valence < q1_valence - 1.5 * (q3_valence - q1_valence) OR t.valence > q3_valence + 1.5 * (q3_valence - q1_valence)) AS valence_outlier,
    t.energy,
    (t.energy < q1_energy - 1.5 * (q3_energy - q1_energy) OR t.energy > q3_energy + 1.5 * (q3_energy - q1_energy)) AS energy_outlier,
    t.acousticness,
    (t.acousticness < q1_acousticness - 1.5 * (q3_acousticness - q1_acousticness) OR t.acousticness > q3_acousticness + 1.5 * (q3_acousticness - q1_acousticness)) AS acousticness_outlier,
    t.instrumentalness,
    (t.instrumentalness < q1_instrumentalness - 1.5 * (q3_instrumentalness - q1_instrumentalness) OR t.instrumentalness > q3_instrumentalness + 1.5 * (q3_instrumentalness - q1_instrumentalness)) AS instrumentalness_outlier,
    t.liveness,
    (t.liveness < q1_liveness - 1.5 * (q3_liveness - q1_liveness) OR t.liveness > q3_liveness + 1.5 * (q3_liveness - q1_liveness)) AS liveness_outlier,
    t.speechiness,
    (t.speechiness < q1_speechiness - 1.5 * (q3_speechiness - q1_speechiness) OR t.speechiness > q3_speechiness + 1.5 * (q3_speechiness - q1_speechiness)) AS speechiness_outlier
  FROM `lab025-p002.views.vw_technical_info` t
  JOIN limites ON TRUE
)
SELECT *
FROM outliers
WHERE bpm_outlier OR danceability_outlier OR valence_outlier OR energy_outlier OR acousticness_outlier OR instrumentalness_outlier OR liveness_outlier OR speechiness_outlier;

CREATE OR REPLACE VIEW `lab025-p002.further_analysis.vw_union` AS (
WITH dados_quartil AS (
  SELECT
    track_id,
    streams_int,
    NTILE(4) OVER(ORDER BY streams_int) AS quartil
  FROM `lab025-p002.views.vw_spotify_info`
)

SELECT
  spotify.track_id,
  spotify.track_name,
  spotify.artists_name,
  spotify.artist_count,

  streaming.released_data,
  streaming.streams_int,
  CASE
    WHEN dados_quartil.quartil = 1 THEN "4. Desconhecidas"
    WHEN dados_quartil.quartil = 2 THEN "3. Conhecidas"
    WHEN dados_quartil.quartil = 3 THEN "2. Populares"
    WHEN dados_quartil.quartil = 4 THEN "1. Top hits"
  END AS class_stream,
  
  streaming.avg_streams_per_day,

  streaming.total_charts,
  streaming.total_playlists,

  streaming.in_spotify_playlists,
  streaming.in_spotify_charts,
  streaming.in_apple_playlists,
  streaming.in_apple_charts,
  streaming.in_deezer_playlists,
  streaming.in_deezer_charts,
  streaming.in_shazam_charts,

  technical.key_note,
  technical.mode,

  technical.bpm,
  CASE
    WHEN technical.bpm > 140 THEN 'A - Muito rápido'
    WHEN technical.bpm BETWEEN 111 AND 140 THEN 'B - Rápido'
    WHEN technical.bpm BETWEEN 81 AND 110 THEN 'C - Médio'
    WHEN technical.bpm BETWEEN 1 AND 80 THEN 'D - Lento'
    WHEN technical.bpm = 0 THEN 'Desconhecido'
    ELSE 'Indefinido'
  END AS categoria_bpm,

  technical.danceability,
  CASE
    WHEN technical.danceability < 0.25 THEN 'D - Muito baixo'
    WHEN technical.danceability < 0.5 THEN 'C - Baixo'
    WHEN technical.danceability < 0.75 THEN 'B - Alto'
    ELSE 'A - Muito alto'
  END AS categoria_danceability,

  technical.valence,
  CASE
    WHEN technical.valence < 0.25 THEN 'D - Muito baixo'
    WHEN technical.valence < 0.5 THEN 'C - Baixo'
    WHEN technical.valence < 0.75 THEN 'B - Alto'
    ELSE 'A - Muito alto'
  END AS categoria_valence,

  technical.energy,
  CASE
    WHEN technical.energy < 0.25 THEN 'D - Muito baixo'
    WHEN technical.energy < 0.5 THEN 'C - Baixo'
    WHEN technical.energy < 0.75 THEN 'B - Alto'
    ELSE 'A - Muito alto'
  END AS categoria_energy,

  technical.acousticness,
  CASE
    WHEN technical.acousticness < 0.25 THEN 'D - Muito baixo'
    WHEN technical.acousticness < 0.5 THEN 'C - Baixo'
    WHEN technical.acousticness < 0.75 THEN 'B - Alto'
    ELSE 'A - Muito alto'
  END AS categoria_acousticness,

  technical.instrumentalness,
  CASE
    WHEN technical.instrumentalness < 0.25 THEN 'D - Muito baixo'
    WHEN technical.instrumentalness < 0.5 THEN 'C - Baixo'
    WHEN technical.instrumentalness < 0.75 THEN 'B - Alto'
    ELSE 'A - Muito alto'
  END AS categoria_instrumentalness,

  technical.liveness,
  CASE
    WHEN technical.liveness < 0.25 THEN 'D - Muito baixo'
    WHEN technical.liveness < 0.5 THEN 'C - Baixo'
    WHEN technical.liveness < 0.75 THEN 'B - Alto'
    ELSE 'A - Muito alto'
  END AS categoria_liveness,

  technical.speechiness,
  CASE
    WHEN technical.speechiness < 0.25 THEN 'D - Muito baixo'
    WHEN technical.speechiness < 0.5 THEN 'C - Baixo'
    WHEN technical.speechiness < 0.75 THEN 'B - Alto'
    ELSE 'A - Muito alto'
  END AS categoria_speechiness

FROM `lab025-p002.views.vw_spotify_info` AS spotify
LEFT JOIN `lab025-p002.further_analysis.vw_streamings` AS streaming
  ON TRIM(spotify.track_id) = TRIM(streaming.track_id)
LEFT JOIN `lab025-p002.views.vw_technical_info` AS technical
  ON TRIM(spotify.track_id) = TRIM(technical.track_id)
LEFT JOIN dados_quartil
  ON TRIM(spotify.track_id) = TRIM(dados_quartil.track_id)
);

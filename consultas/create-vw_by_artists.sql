CREATE OR REPLACE VIEW `lab025-p002.views.vw_spotify_by_artists` AS

WITH classificacao_streams AS (
  SELECT
    TRIM(track_id) AS track_id,
    NTILE(4) OVER (ORDER BY streams_int) AS quartil
  FROM `lab025-p002.views.vw_spotify_info`
),

musicas_explodidas AS (
  SELECT
    TRIM(si.track_id) AS track_id,
    TRIM(artist) AS artist,
    si.in_spotify_playlists,
    si.in_spotify_charts,
    si.streams_int,
    si.artist_count,
    cs.quartil
  FROM `lab025-p002.views.vw_spotify_info` AS si
  LEFT JOIN classificacao_streams AS cs
    ON TRIM(si.track_id) = cs.track_id,
  UNNEST(
    CASE
      WHEN si.artist_count > 1 THEN SPLIT(artists_name, ',')
      ELSE [si.artists_name]
    END
  ) AS artist
)

SELECT
  artist,
  COUNT(DISTINCT track_id) AS track_count,
  STRING_AGG(DISTINCT CAST(track_id AS STRING)) AS track_ids,

  -- Totais
  SUM(in_spotify_playlists) AS total_in_playlists,
  SUM(in_spotify_charts) AS total_in_charts,
  SUM(streams_int) AS total_streams,

  -- Médias por música
  ROUND(SUM(in_spotify_playlists) / COUNT(DISTINCT track_id), 2) AS avg_in_playlists,
  ROUND(SUM(in_spotify_charts) / COUNT(DISTINCT track_id), 2) AS avg_in_charts,
  ROUND(SUM(streams_int) / COUNT(DISTINCT track_id), 2) AS avg_streams,

  -- Contagem por classe de streams
  COUNTIF(quartil = 4) AS top_hits,
  COUNTIF(quartil = 3) AS populares,
  COUNTIF(quartil = 2) AS conhecidas,
  COUNTIF(quartil = 1) AS desconhecidas,

  -- Colaborações por número de artistas na música
  COUNTIF(artist_count = 1) AS solo_tracks,
  COUNTIF(artist_count = 2) AS colab_duplas,
  COUNTIF(artist_count = 3) AS colab_trios,
  COUNTIF(artist_count = 4) AS colab_quartetos,
  COUNTIF(artist_count = 5) AS colab_quintetos,
  COUNTIF(artist_count = 6) AS colab_sextetos,
  COUNTIF(artist_count = 7) AS colab_setetos,
  COUNTIF(artist_count = 8) AS colab_octetos

FROM musicas_explodidas
GROUP BY artist;

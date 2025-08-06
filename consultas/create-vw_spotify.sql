CREATE OR REPLACE VIEW `lab025-p002.views.vw_spotify_info` AS (
SELECT
  CASE 
    WHEN track_id = '00:00' THEN '1001429'
    ELSE track_id
  END AS track_id,

  -- Nome da música corrigido (específicos e limpeza de caracteres)
  CASE
    WHEN track_id = '6720570' THEN 'Idol'
    WHEN track_id = '5865058' THEN 'Help ever hurt never'
    WHEN track_id = '5675634' THEN 'SNAP (TikTok Version)'
    WHEN track_id = '1119309' THEN 'Take My Breath (Fortnite Version)'
    ELSE REGEXP_REPLACE(track_name, r'[�]', '')
  END AS track_name,

  -- Nome dos artistas limpo
  REGEXP_REPLACE(artists_name, r'[�]', '') AS artists_name,

  artist_count,

  DATE(CONCAT(released_year, "-", released_month, "-", released_day)) AS released_data,
  
  in_spotify_playlists,
  in_spotify_charts,

  -- Corrige e converte o campo streams para inteiro
  CAST(
    CASE
      WHEN track_id = '4061483' THEN '310165424'
      ELSE streams
    END AS INT64
  ) AS streams_int

FROM `lab025-p002.dt_spotify2023.spotify`
WHERE track_id NOT IN ('5080031', '8173823')
);

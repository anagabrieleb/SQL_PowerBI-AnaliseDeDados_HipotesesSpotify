-- Consulta: Identificar faixas que estão presentes em todas ou nenhuma das plataformas
SELECT
  track_id,
  in_apple_playlists,
  in_apple_charts,
  in_deezer_playlists,
  in_deezer_charts,
  in_shazam_charts,
  -- Soma total de aparições em plataformas
  (in_apple_playlists + in_apple_charts + in_deezer_playlists + in_deezer_charts + in_shazam_charts) AS total_presence
FROM `lab025-p002.views.vw_competition`
WHERE
  -- Aparece em todas OU em nenhuma
  (in_apple_playlists + in_apple_charts + in_deezer_playlists + in_deezer_charts + in_shazam_charts) IN (0, 5);
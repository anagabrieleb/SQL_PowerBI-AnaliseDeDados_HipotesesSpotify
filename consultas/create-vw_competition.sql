CREATE OR REPLACE VIEW `lab025-p002.views.vw_competition` AS (
  SELECT
    CASE 
      WHEN track_id = '0:00' THEN '1001429'
      ELSE track_id
    END AS track_id,
    
    in_apple_playlists,
    in_apple_charts,
    in_deezer_playlists,
    in_deezer_charts,
    in_shazam_charts
  FROM `lab025-p002.dt_spotify2023.track_in_competition`
  WHERE track_id NOT IN ('5080031', '8173823')
);

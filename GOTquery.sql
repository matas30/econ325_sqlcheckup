-- 1. How many unique viewers did game of thrones and westworld garner in the past 7 days?
-- Identify metrics: 
-- Unique users
-- Day
-- Name of show

-- build SQL query:
SELECT COUNT(DISTINCT view.user.id) AS num_viewers,
  view.date,
  video.series__name
FROM fact_view AS view
  INNER JOIN dim_video AS video
    ON view.video_id = video.video_id
WHERE view.date >= (getdate() - 7)
  AND video.series_name IN ('Westworld', 'Game of Thrones')
GROUP BY video.series_name



-- 2. What is the average completion rate for the first episode of every series?
-- Identify metrics: 
-- name of show 
-- average time watched
-- which episode
-- which season

-- build SQL query:
SELECT video.series_name,
  AVG (view.seconds_watched * 1.0 / nullif(0, video.runtime_seconds)) AS comp_rate
FROM fact_view view
  LEFT JOIN dim_video video
    ON view.video_id = dim.video_id
WHERE video.episode_number = 1
  AND video.season_number = 1
GROUP BY video.series_name

  

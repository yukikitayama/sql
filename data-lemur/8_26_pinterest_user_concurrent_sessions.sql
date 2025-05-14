SELECT
  a.session_id,
  COUNT(*) AS num_concurrent
FROM sessions AS a
JOIN sessions AS b
ON
  a.session_id != b.session_id
  AND b.start_time BETWEEN a.start_time AND b.end_time
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
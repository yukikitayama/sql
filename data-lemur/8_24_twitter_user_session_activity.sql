SELECT
  session_type,
  user_id,
  RANK() OVER(
    PARTITION BY session_type,
    ORDER BY SUM(duration) DESC
  ) AS ranking
FROM
  sessions
WHERE
  start_time BETWEEN '2021-01-01' AND '2021-02-01'
GROUP BY
  1,
  2
ORDER BY
  1,
  3,
  2;
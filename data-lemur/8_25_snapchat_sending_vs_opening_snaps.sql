SELECT
  b.age_bucket,
  ROUND(SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) / SUM(a.time_spent) * 100, 2) AS send_perc,
  ROUND(SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) / SUM(a.time_spent) * 100, 2) AS open_perc
FROM
  activities AS a
LEFT JOIN
  age_breakdown AS b
ON
  a.user_id = b.user_id
WHERE
  a.activity_type IN ('send', 'open')
GROUP BY
  1
ORDER BY
  1;
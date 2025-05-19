SELECT
  COUNT(DISTINCT p.user_id)::DECIMAL / COUNT(DISTINCT s.user_id) * 100 AS last_week_pct
FROM
  signups AS s
LEFT JOIN
  user_purchases AS p
ON
  s.user_id = p.user_id
WHERE
  s.signup_date > NOW() - INTERVAL 7 'DAY'
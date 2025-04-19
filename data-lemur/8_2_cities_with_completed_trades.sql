-- SELECT
--   u.city,
--   SUM(CASE WHEN t.status = 'Completed' THEN 1 ELSE 0 END) AS total_orders
-- FROM
--   trades AS t
-- LEFT JOIN
--   users AS u
-- ON
--   t.user_id = u.user_id
-- GROUP BY
--   1
-- ORDER BY
--   2 DESC
-- LIMIT
--   3

SELECT
  u.city,
  COUNT(*) AS total_orders
FROM trades AS t
INNER JOIN users AS u
ON t.user_id = u.user_id
WHERE t.status = 'Completed'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3
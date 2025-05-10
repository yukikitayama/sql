WITH

last_months AS (
  SELECT
    DISTINCT user_id
  FROM
    user_actions
  WHERE
    EXTRACT(YEAR FROM event_date) = 2022
    AND EXTRACT(MONTH FROM event_date) = 6
)

SELECT
  EXTRACT(MONTH FROM event_date) AS month,
  COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE
  EXTRACT(YEAR FROM event_date) = 2022
  AND EXTRACT(MONTH FROM event_date) = 7
  AND user_id IN (SELECT user_id FROM last_months)
GROUP BY
  1;
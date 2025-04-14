# Write your MySQL query statement below

WITH

rates AS (
    SELECT
        user_id,
        SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(*) AS confirmation_rate
    FROM
        Confirmations
    GROUP BY
        user_id
)

SELECT
    s.user_id,
    CASE
        WHEN r.confirmation_rate IS NULL THEN 0
        ELSE ROUND(r.confirmation_rate, 2)
    END AS confirmation_rate
FROM
    Signups AS s
LEFT JOIN
    rates AS r
ON
    s.user_id = r.user_id;
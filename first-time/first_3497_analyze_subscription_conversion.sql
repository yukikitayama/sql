# Write your MySQL query statement below
WITH

activity_type_counts AS (
    SELECT
        user_id,
        COUNT(distinct activity_type) AS count_activity_type
    FROM
        UserActivity
    WHERE
        activity_type in ('free_trial', 'paid')
    GROUP BY
        1
)

-- SELECT * FROM activity_type_counts

SELECT
    user_id,
    -- NULL can skip AVG()
    ROUND(AVG(CASE WHEN activity_type = 'free_trial' THEN activity_duration ELSE NULL END), 2) AS trial_avg_duration,
    ROUND(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration ELSE NULL END), 2) AS paid_avg_duration
FROM
    UserActivity
WHERE
    user_id IN (
        SELECT user_id FROM activity_type_counts WHERE count_activity_type = 2
    )
GROUP BY
    1
ORDER BY
    1;
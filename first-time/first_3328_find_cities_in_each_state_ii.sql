# Write your MySQL query statement below

WITH

city_stats AS (
    SELECT
        state,
        count(*) as city_count,
        SUM(CASE WHEN LEFT(state, 1) = LEFT(city, 1) THEN 1 ELSE 0 END) AS matching_letter_count,
        GROUP_CONCAT(city ORDER BY city SEPARATOR ', ') AS cities
    FROM
        cities
    GROUP BY
        1
)

SELECT
    state,
    cities,
    matching_letter_count
FROM
    city_stats
WHERE
    city_count >= 3
    AND matching_letter_count > 0
ORDER BY
    matching_letter_count DESC,
    state;
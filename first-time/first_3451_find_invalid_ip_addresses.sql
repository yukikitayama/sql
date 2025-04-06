# Write your MySQL query statement below

WITH

split_ips AS (
    SELECT
        *,
        SUBSTRING_INDEX(ip, '.', 1) AS ip1,
        -- Take left 2 things, and then take right 1 thing
        SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) AS ip2,
        -- Take left 3 things, and then take right 1 thing
        SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) AS ip3,
        SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 4), '.', -1) AS ip4
    FROM
        logs
    WHERE
        LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) = 3
),

valid_ips AS (
    SELECT
        DISTINCT ip
    FROM
        split_ips
    WHERE
        CAST(ip1 AS UNSIGNED) <= 255
        AND CAST(ip2 AS UNSIGNED) <= 255
        AND CAST(ip3 AS UNSIGNED) <= 255
        AND CAST(ip4 AS UNSIGNED) <= 255
        -- Starts with 1 to 9, not 0
        AND ip1 REGEXP '^[1-9]'
        AND ip2 REGEXP '^[1-9]'
        AND ip3 REGEXP '^[1-9]'
        AND ip4 REGEXP '^[1-9]'
)

-- SELECT * FROM split_ips
-- SELECT * FROM valid_ips

SELECT
    ip,
    COUNT(*) AS invalid_count
FROM
    logs
WHERE
    ip NOT IN (SELECT ip FROM valid_ips)
GROUP BY
    1
ORDER BY
    2 desc,
    1 desc
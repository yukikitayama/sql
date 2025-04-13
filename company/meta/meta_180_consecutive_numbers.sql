# Write your MySQL query statement below
/*
row number partition by num order by id
row number order by id
2nd row num - 1st row num as group ID
by num, by group ID, count rows
select distinct num where count is >= 3
*/
WITH

group_ids AS (
    SELECT
        num,
        id - ROW_NUMBER() OVER(PARTITION BY num ORDER BY id) AS group_id
    FROM
        Logs
),

streaks AS (
    SELECT
        num,
        group_id,
        COUNT(*) AS count_streak
    FROM
        group_ids
    GROUP BY
        1,
        2
)

SELECT
    DISTINCT num AS ConsecutiveNums
FROM
    streaks
WHERE
    count_streak >= 3;
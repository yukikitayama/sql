# Write your MySQL query statement below

/*

*/

WITH RECURSIVE

team_passes AS (
    SELECT
        t1.team_name AS team_from,
        p.time_stamp,
        t2.team_name AS team_to,
        ROW_NUMBER() OVER(PARTITION BY t1.team_name ORDER BY p.time_stamp) AS row_num
    FROM
        Passes AS p
    JOIN
        Teams AS t1
    ON
        p.pass_from = t1.player_id
    JOIN
        Teams AS t2
    ON
        p.pass_to = t2.player_id
),

streaks AS (
    SELECT
        team_from,
        team_to,
        row_num,
        CASE WHEN team_from = team_to THEN 1 ELSE 0 END AS streak
    FROM
        team_passes
    WHERE
        row_num = 1
    UNION ALL
    SELECT
        tp.team_from,
        tp.team_to,
        tp.row_num,
        CASE WHEN tp.team_from = tp.team_to THEN s.streak + 1 ELSE 0 END
    FROM
        team_passes AS tp
    JOIN
        streaks AS s
    ON
        tp.row_num = s.row_num + 1
        AND tp.team_from = s.team_from
)

-- SELECT * FROM team_passes ORDER BY time_stamp
-- SELECT * FROM streaks ORDER BY team_from, rnk

SELECT
    team_from AS team_name,
    MAX(streak) AS longest_streak
FROM
    streaks
WHERE
    streak != 0
GROUP BY
    1
ORDER BY
    1;
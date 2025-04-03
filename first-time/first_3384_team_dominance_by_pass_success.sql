# Write your MySQL query statement below

/*
Join teams to passes
assing half id in time_stamp
Group by team name of pass from,
  sum case when same team +1, different team -1
*/

SELECT
    t1.team_name,
    CASE WHEN time_stamp < '45:01' THEN 1 ELSE 2 END AS half_number,
    SUM(CASE WHEN t1.team_name = t2.team_name THEN 1 ELSE -1 END) AS dominance
FROM
    Passes AS p
LEFT JOIN
    Teams AS t1
ON
    p.pass_from = t1.player_id
LEFT JOIN
    Teams AS t2
ON
    p.pass_to = t2.player_id
GROUP BY
    1,
    2
ORDER BY
    1,
    2;
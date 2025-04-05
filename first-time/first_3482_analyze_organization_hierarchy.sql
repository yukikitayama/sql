# Write your MySQL query statement below

/*
level
  recursive cte from ceo to subordinates
team_size, budget
*/

WITH RECURSIVE

levels AS (
    SELECT
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level
    FROM
        Employees
    WHERE
        manager_id IS NULL
    UNION ALL
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        l.level + 1 AS level
    FROM
        Employees AS e
    INNER JOIN
        levels AS l
    ON
        e.manager_id = l.employee_id
),

subordinates AS (
    SELECT
        a.employee_id AS manager_id,
        b.employee_id AS subordinate_id,
        b.salary AS subordinate_salary
    FROM
        Employees AS a
    INNER JOIN
        Employees AS b
    ON
        a.employee_id = b.manager_id

    UNION ALL

    SELECT
        s.manager_id,
        e.employee_id AS subordinate_id,
        e.salary AS subordinate_salary
    FROM
        subordinates AS s
    INNER JOIN
        Employees As e
    ON
        s.subordinate_id = e.manager_id
),

manager_stats AS (
    SELECT
        manager_id,
        COUNT(*) AS team_size,
        SUM(subordinate_salary) AS total_subordinate_salary
    FROM
        subordinates
    GROUP BY
        1
)

-- SELECT * FROM levels
-- SELECT * FROM subordinates ORDER BY 1 desc, 2
-- SELECT * FROM manager_stats ORDER BY 1

SELECT
    l.employee_id,
    l.employee_name,
    l.level,
    COALESCE(m.team_size, 0) AS team_size,
    l.salary + COALESCE(m.total_subordinate_salary, 0) AS budget
FROM
    levels AS l
LEFT JOIN
    manager_stats AS m
ON
    l.employee_id = m.manager_id
ORDER BY
    3,
    5 desc,
    2
;
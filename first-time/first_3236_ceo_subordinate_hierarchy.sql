# Write your MySQL query statement below
WITH RECURSIVE

hierarchy AS (
    SELECT
        employee_id,
        employee_name,
        0 AS hierarchy_level,
        salary
    FROM
        Employees
    WHERE
        manager_id IS NULL
    UNION ALL
    SELECT
        e.employee_id,
        e.employee_name,
        h.hierarchy_level + 1,
        e.salary
    FROM
        Employees AS e
    INNER JOIN
        hierarchy AS h
    ON
        e.manager_id = h.employee_id
)

-- SELECT * FROM hierarchy ORDER BY employee_id

SELECT
    employee_id AS subordinate_id,
    employee_name AS subordinate_name,
    hierarchy_level,
    salary - (SELECT salary FROM employees WHERE manager_id IS NULL) AS salary_difference
FROM
    hierarchy
WHERE
    hierarchy_level > 0
ORDER BY
    3,
    1
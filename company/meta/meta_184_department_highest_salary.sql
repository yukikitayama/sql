# Write your MySQL query statement below

/*
for tie, we have to show all
*/

WITH

ranks AS (
    SELECT
        name,
        salary,
        departmentId,
        RANK() OVER(PARTITION BY departmentId ORDER BY salary desc) AS rnk
    FROM
        Employee
)

SELECT
    d.name AS Department,
    r.name AS Employee,
    r.salary AS Salary
FROM
    ranks AS r
LEFT JOIN
    Department AS d
on
    r.departmentId = d.id
WHERE
    r.rnk = 1;
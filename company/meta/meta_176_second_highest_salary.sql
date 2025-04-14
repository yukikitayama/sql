# Write your MySQL query statement below
WITH

ranks AS (
    SELECT
        id,
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM
        Employee
)

SELECT
    CASE
        WHEN 2 NOT IN (SELECT rnk FROM ranks) THEN NULL
        ELSE (SELECT DISTINCT salary FROM ranks WHERE rnk = 2)
    END AS SecondHighestSalary

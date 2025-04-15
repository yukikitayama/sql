# Write your MySQL query statement below

/*
Products which didn't not have sales at all, what to show?
*/

WITH

first_years AS (
    SELECT
        product_id,
        MIN(year) AS first_year
    FROM
        Sales
    GROUP BY
        1
)

SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM
    Sales
WHERE
    (product_id, year) IN (SELECT product_id, first_year FROM first_years);
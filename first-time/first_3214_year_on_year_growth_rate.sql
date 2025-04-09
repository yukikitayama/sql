# Write your MySQL query statement below

/*
Group by product_id, transaction date year, sum of spend
Self-join by product_id, year equal year + 1
yoy is (curr - prev) / prev * 100
*/

WITH

spends AS (
    SELECT
        YEAR(transaction_date) AS year,
        product_id,
        SUM(spend) AS sum_spend
    FROM
        user_transactions
    GROUP BY
        1,
        2
)

-- SELECT * FROM spends;

SELECT
    a.year,
    a.product_id,
    a.sum_spend AS curr_year_spend,
    b.sum_spend AS prev_year_spend,
    ROUND((a.sum_spend - b.sum_spend) / b.sum_spend * 100, 2) AS yoy_rate
FROM
    spends AS a
LEFT JOIN
    spends AS b
ON
    a.year = b.year + 1
    AND a.product_id = b.product_id
ORDER BY
    2,
    1;
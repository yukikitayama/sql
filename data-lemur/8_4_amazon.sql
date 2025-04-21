SELECT
    trans_date,
    product_id,
    SUM(spend) OVER(PARTITION BY product_id ORDER BY trans_date) AS cumulative_spend
FROM
    total_trans
ORDER BY
    1,
    2;
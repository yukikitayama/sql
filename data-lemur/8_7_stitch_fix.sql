--WITH
--
--metrics AS (
--    SELECT
--        user_id,
--        purchase_time::DATE,
--        COUNT(*) AS num_purchase
--    FROM
--        purchases
--    GROUP BY
--        1,
--        2
--)
--
--SELECT
--    user_id
--FROM
--    metrics
--GROUP BY
--    1
--HAVING
--    COUNT(*) > 1

WITH

purchase_numbers AS (
    SELECT
        user_id,
        DENSE_RANK() OVER(PARTITION BY user_id, product_id ORDER BY purchase_time::DATE) AS rnk
    FROM
        purchases
)

SELECT
    COUNT(DISTINCT user_id)
FROM
    purchase_numbers
WHERE
    rnk = 2;
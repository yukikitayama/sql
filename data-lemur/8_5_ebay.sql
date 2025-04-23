--WITH
--
--metrics AS (
--    SELECT
--        user_id,
--        COUNT(transaction_id) AS count_order,
--        SUM(spend) AS total_spend
--    FROM
--        user_transactions
--    GROUP BY
--        1
--)
--
--SELECT
--    user_id
--FROM
--    metrics
--WHERE
--    total_spend >= 1000
--ORDER BY
--    count_order DESC
--LIMIT
--    10;

SELECT
    user_id,
    COUNT(transaction_id) AS count_order
FROM
    user_transactions
GROUP BY
    user_id
HAVING
    SUM(spend) >= 1000
ORDER BY
    count_order DESC
LIMIT
    10;
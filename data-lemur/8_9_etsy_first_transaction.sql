WITH

transaction_sequences AS (
    SELECT
        user_id,
        spend,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS row_num
    FROM user_transactions
)

SELECT DISTINCT user_id
FROM transaction_sequences
WHERE
    row_num = 1
    AND spend >= 50;
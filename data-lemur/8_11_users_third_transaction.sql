WITH sequences AS (
  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS row_num
  FROM
    transactions
)

SELECT
  user_id,
  spend,
  transaction_date
FROM
  sequences
WHERE
  row_num = 3;
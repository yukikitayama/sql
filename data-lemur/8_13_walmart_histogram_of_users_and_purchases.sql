WITH

transactions AS (
  SELECT
    transaction_date,
    user_id,
    spend,
    RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS rnk
  FROM
    user_transactions
)

-- SELECT * FROM transactions ORDER BY user_id, transaction_date;

SELECT
  transaction_date,
  user_id,
  COUNT(*) AS purchase_count
FROM
  transactions
WHERE
  rnk = 1
GROUP BY
  1,
  2
ORDER BY
  1,
  2
;
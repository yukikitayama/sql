WITH

ranks AS (
  SELECT
    category,
    product,
    SUM(spend) AS total_spend,
    DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS rnk
  FROM
    product_spend
  WHERE
    EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY
    1,
    2
)

-- SELECT * FROM ranks

SELECT
  category,
  product,
  total_spend
FROM
  ranks
WHERE
  rnk <= 2
ORDER BY
  1,
  rnk
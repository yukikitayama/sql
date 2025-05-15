WITH

business_rates AS (
  SELECT
    business_id,
    MIN(review_stars) AS min_star
  FROM
    reviews
  GROUP BY
    1
)

SELECT
  SUM(CASE WHEN min_star >= 4 THEN 1 ELSE 0 END)::DECIMAL / COUNT(*) AS top_rate
FROM
  business_rates
WITH

listing_counts AS (
  SELECT
    company_id,
    title,
    description,
    COUNT(*) AS listing_count
  FROM
    job_listings
  GROUP BY
    1,
    2,
    3
)

-- SELECT * FROM listing_counts;

SELECT
  COUNT(DISTINCT company_id)
FROM
  listing_counts
WHERE
  listing_count > 1;
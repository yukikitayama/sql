WITH

tweet_counts AS (
  SELECT
    user_id,
    COUNT(*) AS num_tweet
  FROM
    tweets
  WHERE
    tweet_date BETWEEN '2022-01-01' AND '2022-12-31'
  GROUP BY
    1
)

SELECT
  num_tweet AS tweet_bucket,
  COUNT(*) AS users_num
FROM
  tweet_counts
GROUP BY
  1;
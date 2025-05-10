/*
Find user IDs who followed top 100 topics
Find user IDs which are not in the above user IDs
*/

/*
WITH

users AS (
  SELECT
    DISTINCT u.user_id
  FROM
    user_topics AS u
  INNER JOIN
    topic_rankings AS r
  ON
    u.topic_if = r.topic_id
  WHERE
    u.follow_date = '2021-01-01'
    AND r.ranking_date = '2021-01-01'
    AND r.ranking <= 100
)

SELECT
  user_id
FROM
  user_topics
WHERE
  user_id NOT IN (
    SELECT user_id FROM users
  )
  AND follow_date = '2021-01-01';
*/

WITH

top_topics AS (
  SELECT
    topic_id
  FROM
    topic_rankings
  WHERE
    ranking_date = '2021-01-01'
    AND rank <= 100
)

-- <= '2021-01-01': existing users as of 2021-01-01
SELECT DISTINCT user_id FROM user_topics WHERE follow_date <= '2021-01-01'
MINUS
SELECT u.user_id FROM user_topics AS u JOIN top_topics AS t ON u.topic_id = t.topic_id
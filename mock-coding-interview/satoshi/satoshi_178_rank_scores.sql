-- Write your PostgreSQL query statement below

select
  score,
  dense_rank() over(
    order by score desc
  ) as rank
from
  scores
order by
  score desc
;

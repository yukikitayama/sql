# Write your MySQL query statement below
with cte as (
  select
    gender,
    day,
    sum(score_points) as score
  from
    scores
  group by
    1,
    2
)

select
  gender,
  day,
  sum(score) over(partition by gender order by day) as total
from
  cte
order by
  1,
  2
;

-- Write your PostgreSQL query statement below
with cte as (
  select
    actor_id,
    director_id,
    count(timestamp) as num_cooperated
  from
    actordirector
  group by
    1,
    2
)

select
  actor_id,
  director_id
from
  cte
where
  num_cooperated >= 3
;

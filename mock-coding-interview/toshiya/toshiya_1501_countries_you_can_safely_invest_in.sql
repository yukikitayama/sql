-- Write your PostgreSQL query statement below
with cte as (
  select
    caller_id as person_id,
    duration
  from
    calls
  union all
  select
    callee_id,
    duration
  from
    calls
),

cte2 as (
  select
    c.name as country,
    avg(a.duration) as local_average
  from
    cte as a
  left join
    person as b
  on
    a.person_id = b.id
  left join
    country as c
  on
    left(b.phone_number, 3) = c.country_code
  group by
    1
)

-- select * from cte2

select
  distinct country
from
  cte2
where
  local_average > (
    select avg(duration) from cte
  )
;
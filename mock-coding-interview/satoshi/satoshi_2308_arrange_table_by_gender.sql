/*
3 f, 1 o, 1 m

f
o
m
f
f
*/

-- Write your PostgreSQL query statement below

with cte as (
  select
    user_id,
    gender,
    row_number() over(partition by gender order by user_id) as row_num,
    case
      when gender = 'female' then 1
      when gender = 'other' then 2
      else 3
    end as custom_order
  from
    genders
)

select
  user_id,
  gender
from
  cte
order by
  row_num,
  custom_order
;
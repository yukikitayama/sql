# Write your MySQL query statement below
with cte as (
  select
    paid_by as user_id,
    -1 * amount as amount
  from
    transactions
  union all
  select
    paid_to as user_id,
    amount as amount
  from
    transactions
),

cte2 as (
  select
    user_id,
    sum(amount) as sum_amount
  from
    cte
  group by
    1
)

-- select * from cte2;

select
  u.user_id,
  u.user_name,
  u.credit + ifnull(c.sum_amount, 0) as credit,
  if(u.credit + ifnull(c.sum_amount, 0) < 0, 'Yes', 'No') as credit_limit_breached
from
  users as u
left join
  cte2 as c
on
  u.user_id = c.user_id
;

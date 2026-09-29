# Write your MySQL query statement below

with

sequence as (
  select
    *,
    row_number() over(partition by user_id order by event_date desc) as row_num
  from subscription_events
),

current as (
  select
    user_id,
    plan_name,
    monthly_amount as current_plan_revenue
  from sequence
  where row_num = 1
    and event_type != 'cancel'
),

history as (
  select
    user_id,
    sum(case when event_type = 'downgrade' then 1 else 0 end) as count_downgrade,
    max(monthly_amount) as historical_max_plan_revenue,
    datediff(max(event_date), min(event_date)) subscription_period
  from subscription_events
  group by user_id
)

-- select * from current
-- select * from history

select
  c.user_id,
  c.plan_name as current_plan,
  c.current_plan_revenue as current_monthly_amount,
  h.historical_max_plan_revenue as max_historical_amount,
  h.subscription_period as days_as_subscriber
from current as c
left join history as h
on c.user_id = h.user_id
where h.count_downgrade >= 1
  and c.current_plan_revenue < 0.5 * h.historical_max_plan_revenue
  and h.subscription_period >= 60
order by 5 desc,
  1
# Write your MySQL query statement below

with cte as (
  select
    team_name,
    wins * 3 + draws as points,
    rank() over(order by wins * 3 + draws desc) as position
  from
    teamstats
)

-- select * from cte

select
  team_name,
  points,
  position,
  case
    when position < (0.33 * (select max(position) from cte) + 1) then 'Tier 1'
    when position < (0.66 * (select max(position) from cte) + 1) then 'Tier 2'
    else 'Tier 3'
  end as tier
from
  cte
order by
  points desc,
  team_name
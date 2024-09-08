-- Write your PostgreSQL query statement below
with cte as (
  select
    host_team as team_id,
    host_goals,
    guest_goals
  from
    matches
  union all
  select
    guest_team as team_id,
    guest_goals as host_goals,
    host_goals as guest_goals
  from
    matches
),

cte2 as (
  select
    team_id,
    sum(
      case
        when host_goals > guest_goals then 3
        when host_goals = guest_goals then 1
        else 0
      end
    ) as num_points
  from
    cte
  group by
    1
)

--select * from cte2

 select
   t.team_id,
   t.team_name,
   coalesce(c.num_points, 0) as num_points
 from
   teams as t
 left join
   cte2 as c
 on
   t.team_id = c.team_id
 order by
   3 desc,
   1
 ;
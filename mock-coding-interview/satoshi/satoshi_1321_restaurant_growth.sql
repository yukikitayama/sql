# Write your MySQL query statement below

with cte as (
  select
    visited_on,
    sum(amount) as amount
  from
    customer
  group by
    1
)

select
  a.visited_on,
  sum(b.amount) as amount,
  round(avg(b.amount), 2) as average_amount
from
  cte as a
cross join
  cte as b
where
  datediff(a.visited_on, b.visited_on) between 0 and 6
group by
  a.visited_on
having
  count(a.visited_on) = 7
;

-- with

-- -- Clean data
-- cte as (
--   select
--     visited_on,
--     sum(amount) as amount
--   from
--     customer
--   group by
--     1
-- ),

-- -- Cumsum
-- cte2 as (
--   select
--     visited_on,
--     sum(amount) over(
--       order by visited_on
--     ) as cumsum
--   from
--     cte
-- ),

-- -- 7 days window sum by self-join
-- cte3 as (
--   select
--     a.visited_on,
--     a.cumsum - b.cumsum as amount,
--     round((a.cumsum - b.cumsum) / 7, 2) as average_amount
--   from
--     cte2 as a
--   left join
--     cte2 as b
--   on
--     -- (old date, early)
--     datediff(a.visited_on, b.visited_on) = 7
-- ),

-- cte4 as (
--   select
--     visited_on,
--     row_number() over(order by visited_on) as row_num
--   from
--     cte
-- ),

-- cte5 as (
--   select
--     visited_on
--   from
--     cte4
--   where
--     row_num >= 7
-- )

-- -- select * from cte3;
-- -- select * from cte5;

-- select
--   a.visited_on,
--   if(b.amount is null, c.cumsum, b.amount) as amount,
--   if(b.average_amount is null, round(c.cumsum / 7, 2), b.average_amount) as average_amount
-- from
--   cte5 as a
-- left join
--   cte3 as b
-- on
--   a.visited_on = b.visited_on
-- left join
--   cte2 as c
-- on
--   a.visited_on = c.visited_on

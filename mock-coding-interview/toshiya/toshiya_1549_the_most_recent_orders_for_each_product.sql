-- Write your PostgreSQL query statement below
with cte as (
  select
    product_id,
    order_id,
    order_date,
    rank() over(partition by product_id order by order_date desc) as r
  from
    orders
)

select
  b.product_name,
  a.product_id,
  a.order_id,
  a.order_date
from
  cte as a
left join
  products as b
on
  a.product_id = b.product_id
where
  a.r = 1
order by
  1,
  2,
  3
;
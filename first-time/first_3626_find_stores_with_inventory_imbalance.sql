# Write your MySQL query statement below
with

expensive_items as (
  select
    store_id,
    product_name,
    quantity,
    price
  from inventory
  where (store_id, price) in (
    select store_id, max(price) from inventory group by 1
  )
),

cheap_items as (
  select
    store_id,
    product_name,
    quantity,
    price
  from inventory
  where (store_id, price) in (
    select store_id, min(price) from inventory group by 1
  )
),

store_ids as (
  select
    store_id
  from inventory
  group by 1
  having count(*) >= 3
)

select
  ei.store_id,
  s.store_name,
  s.location,
  ei.product_name as most_exp_product,
  ci.product_name as cheapest_product,
  round(ci.quantity / ei.quantity, 2) as imbalance_ratio
from expensive_items as ei
join cheap_items as ci
on ei.store_id = ci.store_id
join stores as s
on ei.store_id = s.store_id
where ei.store_id in (select store_id from store_ids)
  and ei.quantity < ci.quantity
order by 6 desc, 2

-- select
--   distinct store_id,
--   first_value(product_name) over(partition by store_id order by price desc) as most_exp_product,
--   first_value(product_name) over(partition by store_id order by price) as cheapest_product,
--   first_value(quantity) over(partition by store_id order by price desc) as most_exp_product_quant,
--   first_value(quantity) over(partition by store_id order by price) as cheapest_product_quant
-- from inventory
# Write your MySQL query statement below
select
  p.product_id,
  p.price - (p.price * ifnull(d.discount, 0) / 100) as final_price,
  p.category
from
  products as p
left join
  discounts as d
on
  p.category = d.category
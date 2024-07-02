-- Write your PostgreSQL query statement below
select
  concat(a.topping_name, ',', b.topping_name, ',', c.topping_name) as pizza,
  round(a.cost + b.cost + c.cost, 2) as total_cost
from
  toppings as a
cross join
  toppings as b
cross join
  toppings as c
where
  a.topping_name < b.topping_name
  and b.topping_name < c.topping_name
order by
  2 desc,
  1
;
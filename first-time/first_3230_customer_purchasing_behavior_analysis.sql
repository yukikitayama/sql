# Write your MySQL query statement below

with

transaction_products as (
  select
    t.customer_id,
    t.product_id,
    t.transaction_date,
    t.amount,
    p.category
  from
    transactions as t
  left join
    products as p
  on
    t.product_id = p.product_id
),

frequents as (
  select
    customer_id,
    category,
    row_number() over(
      partition by customer_id
      order by count(*) desc, max(transaction_date) desc
    ) as row_num
  from
    transaction_products
  group by
    1,
    2
)

-- select * from frequents order by customer_id, row_num
-- select * from frequents where row_num = 1

select
  t.customer_id,
  round(sum(t.amount), 2) as total_amount,
  count(*) as transaction_count,
  count(distinct t.category) as unique_categories,
  round(avg(t.amount), 2) as avg_transaction_amount,
  f.category as top_category,
  round(count(*) * 10 + sum(t.amount) / 100, 2) as loyalty_score
from
  transaction_products as t
left join
  frequents as f
on
  t.customer_id = f.customer_id
where
  f.row_num = 1
group by
  1
order by
  7 desc,
  1
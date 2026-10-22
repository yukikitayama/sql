# Write your MySQL query statement below

with

format_product as (
    select
        user_id,
        category
    from ProductPurchases as p
    inner join ProductInfo as p_i
    on p.product_id = p_i.product_id
)
-- select * from format_product

select
    fp1.category as category1,
    fp2.category as category2,
    count(distinct fp1.user_id) as customer_count
from format_product as fp1
inner join format_product as fp2
on fp1.category < fp2.category
    and fp1.user_id = fp2.user_id
group by fp1.category, fp2.category
having count(distinct fp1.user_id) >= 3
order by 3 desc, 1, 2
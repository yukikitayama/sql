# Write your MySQL query statement below

/*
Group by customer ID,
  count the number of distinct order ID
  Compute peak hour order ratio by case when sum peak hour divided by the number of orders
  Compute average of rating
  Compute rating ratio by case when sum rating count divided by the number of orders
*/

with metrics as (
select
  customer_id,
  count(distinct order_id) as count_order,
  sum(
    case
      when time_format(order_timestamp, '%H:%i') between '11:00' and '14:00' then 1
      when time_format(order_timestamp, '%H:%i') between '18:00' and '21:00' then 1
      else 0
    end
  ) / count(order_id) * 100 as peak_hour_order_ratio,
  avg(order_rating) as avg_rating,
  sum(case when order_rating is not null then 1 else 0 end) / count(order_id) as rating_ratio
from restaurant_orders
group by customer_id
)

select
  customer_id,
  count_order as total_orders,
  round(peak_hour_order_ratio) as peak_hour_percentage,
  round(avg_rating, 2) as average_rating
from metrics
where count_order>= 3
  and peak_hour_order_ratio >= 60
  and avg_rating >= 4
  and rating_ratio >= 0.5
order by 4 desc,
  1 desc


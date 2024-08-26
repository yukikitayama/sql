# Write your MySQL query statement below
with cte as (
  select
    car_id,
    sum(fee_paid) as total_fee_paid,
    sum(fee_paid) / sum(timestampdiff(second, entry_time, exit_time) / 60 / 60) as avg_hourly_fee
  from
    ParkingTransactions
  group by
    car_id
),

cte1 as (
  select
    car_id,
    lot_id,
    sum(timestampdiff(second, entry_time, exit_time)) as total_second
  from
    ParkingTransactions
  group by
    1,
    2
),

cte2 as (
  select
    car_id,
    lot_id,
    rank() over(partition by car_id order by total_second desc) as r
  from
    cte1
)


select
  a.car_id,
  round(a.total_fee_paid, 2) as total_fee_paid,
  round(a.avg_hourly_fee, 2) as avg_hourly_fee,
  b.lot_id as most_time_lot
from
  cte as a
left join
  (select car_id, lot_id from cte2 where r = 1) as b
on
  a.car_id = b.car_id
order by
  1
;
# Write your MySQL query statement below
select
  transaction_date,
  sum(case when amount % 2 != 0 then amount else 0 end) as odd_sum,
  sum(case when amount % 2 = 0 then amount else 0 end) as even_sum
from
  transactions
group by
  1
order by
  1
;
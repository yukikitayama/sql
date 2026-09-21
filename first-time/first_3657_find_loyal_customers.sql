# Write your MySQL query statement below

/*
Active means max transaction date and min difference is >= 30

Group by customer ID,
  count the number of transactions,
  compute the datediff
  Compute count of refund transaction divided by count of transactions

Return the output where
  >= 3 transactions,
  >= 30 datediff
  Refund rate < 0.2
*/

select
  customer_id
from customer_transactions
group by 1
having
  count(distinct transaction_id) >= 3
  and datediff(max(transaction_date), min(transaction_date)) >= 30
  and sum(case when transaction_type = 'refund' then 1 else 0 end) / count(transaction_id) < 0.2
order by 1






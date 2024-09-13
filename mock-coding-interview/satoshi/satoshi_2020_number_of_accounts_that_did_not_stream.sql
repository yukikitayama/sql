-- Write your PostgreSQL query statement below
select
  count(distinct account_id) as accounts_count
from
  subscriptions
where
  extract(year from start_date) <= 2021
  and extract(year from end_date) >= 2021
  and account_id not in (
    select distinct account_id from streams where extract(year from stream_date) = 2021
  )
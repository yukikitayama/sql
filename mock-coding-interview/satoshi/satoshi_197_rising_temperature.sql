-- Write your PostgreSQL query statement below
select
  b.id
from
  weather as a
cross join
  weather as b
where
  date_part('day', b.recordDate::timestamp - a.recordDate::timestamp) = 1
  and b.temperature > a.temperature
;
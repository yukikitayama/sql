# Write your MySQL query statement below

/*
union all
*/

with

all_flights as (
  select
    departure_airport,
    arrival_airport,
    flights_count
  from
    flights
  union all
  select
    arrival_airport,
    departure_airport,
    flights_count
  from
    flights
),

flight_counts as (
  select
    departure_airport,
    rank() over(order by sum(flights_count) desc) as rnk
  from
    all_flights
  group by
    1
)

-- select * from all_flights

select
  departure_airport as airport_id
from
  flight_counts
where
  rnk = 1
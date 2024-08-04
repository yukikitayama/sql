/*
*/


# Write your MySQL query statement below

with cte as (
  select
    a.movie_id,
    a.user_id,
    a.rating,
    a.created_at,
    b.title,
    c.name
  from
    movierating as a
  left join
    movies as b
  on
    a.movie_id = b.movie_id
  left join
    users as c
  on
    a.user_id = c.user_id
),

-- User
cte1 as (
  select
    user_id,
    name,
    count(distinct movie_id) as num_rating
  from
    cte
  group by
    1
),
cte2 as (
  select
    name
  from
    cte1
  order by
    num_rating desc,
    name
  limit
    1
),

-- Avg rating
cte3 as (
  select
    movie_id,
    title,
    avg(rating) as avg_rating
  from
    cte
  where
    year(created_at) = 2020
    and month(created_at) = 2
  group by
    1
),
cte4 as (
  select
    title
  from
    cte3
  order by
    avg_rating desc,
    title
  limit
    1
)

select
  name as results
from
  cte2
union all
select
  title as results
from
  cte4
;
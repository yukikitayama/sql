/*
Pre-compute
group by book_id,
  count number of sessions
  compute max of session_rating
  compute min of session_rating
  use case when to count the number of extreme rating, and divide it by number of sessions

Apply where statement to the above table to filter data
Join with books table to get necessary output columns
*/

# Write your MySQL query statement below

with

metrics as (
  select
    book_id,
    count(distinct session_id) as count_session,
    max(session_rating) as max_rating,
    min(session_rating) as min_rating,
    sum(case when session_rating <= 2 or session_rating >= 4 then 1 else 0 end) / count(distinct session_id) as polarization_score
  from reading_sessions
  group by 1
)

-- select * from metrics order by book_id

select
  m.book_id,
  b.title,
  b.author,
  b.genre,
  b.pages,
  m.max_rating - m.min_rating as rating_spread,
  round(m.polarization_score, 2) as polarization_score
from metrics as m
join books as b
on m.book_id = b.book_id
where
  m.count_session >= 5
  and m.polarization_score >= 0.6
  and m.max_rating >= 4
  and m.min_rating <= 2
order by
  m.polarization_score desc,
  b.title desc





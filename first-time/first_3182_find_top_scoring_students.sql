# Write your MySQL query statement below
/*
Find number of course for each major
Find the number of A for each student
If the numbers are the same, output
*/

with

extended_enrollments as (
  select
    e.student_id,
    s.major,
    sum(case when e.grade = 'A' then 1 else 0 end) as num_a
  from
    enrollments as e
  left join
    students as s
  on
    e.student_id = s.student_id
  left join
    courses as c
  on
    e.course_id = c.course_id
  where
    s.major = c.major
  group by
    1,
    2
),

num_courses as (
  select
    major,
    count(*) as num_course
  from
    courses
  group by
    1
)

-- select * from extended_enrollments;
-- select * from num_courses;
-- select * from num_as;

select
  e.student_id
from
  extended_enrollments as e
left join
  num_courses as c
on
  e.major = c.major
where
  e.num_a = c.num_course
order by
  1;
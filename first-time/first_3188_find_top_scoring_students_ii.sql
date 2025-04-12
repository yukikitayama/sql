# Write your MySQL query statement below

/*
By major, count the number of madatory courses, from courses
Join enrollments and courses and students, and CTE
  count number of courses of student major and course major equal and mandatory
    count the number of As
    check whether this is equal to CTE mandatory count
  count number of courses of student major not equal to course major and not mandatory
    count the number of A or Bs
  take average of GPA
Filter from the above table

Questions
  Can they retake the same course in a different semester?
  Can they take different major courses?
  What grades are available?
*/

WITH

mandatory_courses AS (
    SELECT
        course_id,
        major
    FROM
        courses
    WHERE
        mandatory = 'yes'
),

mandatory_counts AS (
    SELECT
        major,
        COUNT(DISTINCT course_id) AS count_course
    FROM
        mandatory_courses
    GROUP BY
        1
),

elective_courses AS (
    SELECT
        course_id,
        major
    FROM
        courses
    WHERE
        mandatory = 'no'
),

student_mandatory AS (
    SELECT
        e.student_id,
        s.major,
        COUNT(DISTINCT e.course_id) AS count_course
    FROM
        enrollments AS e
    JOIN
        mandatory_courses AS m
    ON
        e.course_id = m.course_id
    JOIN
        students AS s
    ON
        e.student_id = s.student_id
        AND m.major = s.major
    WHERE
        e.grade = 'A'
    GROUP BY
        e.student_id,
        s.major
),

taken_all_student_mandatory AS (
    SELECT
        sm.student_id,
        sm.major
    FROM
        student_mandatory AS sm
    JOIN
        mandatory_counts AS mc
    ON
        sm.major = mc.major
    WHERE
        sm.count_course = mc.count_course
),

student_elective AS (
    SELECT
        e.student_id,
        s.major,
        COUNT(DISTINCT e.course_id) AS count_course
    FROM
        enrollments AS e
    JOIN
        elective_courses AS ec
    ON
        e.course_id = ec.course_id
    JOIN
        students AS s
    ON
        e.student_id = s.student_id
        AND ec.major = s.major
    WHERE
        e.grade IN ('A', 'B')
    GROUP BY
        e.student_id,
        s.major
),

average_gpa AS (
    SELECT
        student_id,
        AVG(gpa) AS avg_gpa
    FROM
        enrollments
    GROUP BY
        student_id
)

SELECT
    DISTINCT sm.student_id
FROM
    taken_all_student_mandatory AS sm
JOIN
    student_elective AS se
ON
    sm.student_id = se.student_id
JOIN
    average_gpa AS g
ON
    sm.student_id = g.student_id
WHERE
    se.count_course >= 2
    AND g.avg_gpa >= 2.5
ORDER BY
    1
# Write your MySQL query statement below
SELECT
    s.school_id,
    COALESCE(MIN(e.score), -1) AS score
FROM
    Schools AS s
LEFT JOIN
    Exam AS e
ON
    e.student_count <= s.capacity
GROUP BY
    1
;
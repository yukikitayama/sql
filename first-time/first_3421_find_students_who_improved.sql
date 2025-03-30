# Write your MySQL query statement below

/*
Get latest score by student_id, subject
  row number
Join the first score to the above
  get row where exam_date is min
    subquery, IN (id, sub, min(exam_date))
Output if latest score is higher than first score
*/

WITH

row_num_scores AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) AS row_num
    FROM
        Scores
),

latest_scores AS (
    SELECT
        student_id,
        subject,
        score,
        exam_date
    FROM
        row_num_scores
    WHERE
        row_num = 1
),

first_scores AS (
    SELECT
        student_id,
        subject,
        score
    FROM
        Scores
    WHERE
        (student_id, subject, exam_date) IN (
            SELECT student_id, subject, MIN(exam_date) FROM Scores GROUP BY 1, 2
        )
)

-- SELECT * FROM first_scores;

SELECT
    ls.student_id,
    ls.subject,
    fs.score AS first_score,
    ls.score AS latest_score
FROM
    latest_scores AS ls
INNER JOIN
    first_scores AS fs
ON
    ls.student_id = fs.student_id
    AND ls.subject = fs.subject
WHERE
    ls.score > fs.score
ORDER BY
    1,
    2;
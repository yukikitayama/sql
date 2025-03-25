# Write your MySQL query statement below
WITH

scores AS (
    SELECT
        p.project_id,
        c.candidate_id,
        SUM(
            CASE
                WHEN c.proficiency > p.importance THEN 10
                WHEN c.proficiency < p.importance THEN -5
                ELSE 0
            END
        ) + 100 AS score,
        COUNT(*) AS skill_count
    FROM
        Projects AS p
    LEFT JOIN
        Candidates AS c
    ON
        p.skill = c.skill
    GROUP BY
        1,
        2
),

skill_counts AS (
    SELECT
        project_id,
        count(*) AS skill_count
    FROM
        Projects
    GROUP BY
        1
),

rankings AS (
    SELECT
        project_id,
        candidate_id,
        score,
        ROW_NUMBER() OVER(PARTITION BY project_id ORDER BY score DESC, candidate_id) AS row_num
    FROM
        scores
    WHERE
        (project_id, skill_count) IN (SELECT project_id, skill_count FROM skill_counts)
)

SELECT
    project_id,
    candidate_id,
    score
FROM
    rankings
WHERE
    row_num = 1
ORDER BY
    1;
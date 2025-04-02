# Write your MySQL query statement below
SELECT
    a.employee_id,
    COUNT(*) AS overlapping_shifts
FROM
    EmployeeShifts AS a
INNER JOIN
    EmployeeShifts AS b
ON
    a.employee_id = b.employee_id
WHERE
    -- Remove duplicate
    a.start_time < b.start_time
    -- Check overlap
    AND a.end_time > b.start_time
GROUP BY
    1
ORDER BY
    1
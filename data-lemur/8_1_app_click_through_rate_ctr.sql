SELECT
    app_id,
    ROUND(SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END)::DECIMAL / SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END) * 100, 2) AS ctr
FROM events
WHERE
    timestamp >= '2022-01-01'
    AND timestamp < '2023-01-01'
GROUP BY app_id
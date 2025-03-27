# Write your MySQL query statement below

WITH

trip_vehicle_drivers AS (
    SELECT
        v.fuel_type,
        v.driver_id,
        AVG(t.rating) AS rating,
        SUM(t.distance) AS distance,
        MIN(d.accidents) AS min_accidents,
        ROW_NUMBER() OVER(
            PARTITION BY v.fuel_type
            ORDER BY AVG(t.rating) desc, SUM(t.distance) desc, MIN(d.accidents)
        ) AS row_num
    FROM
        Trips AS t
    LEFT JOIN
        Vehicles AS v
    ON
        t.vehicle_id = v.vehicle_id
    LEFT JOIN
        Drivers AS d
    ON
        v.driver_id = d.driver_id
    GROUP BY
        1,
        2
)

SELECT
    fuel_type,
    driver_id,
    ROUND(rating, 2) AS rating,
    distance
FROM
    trip_vehicle_drivers
WHERE
    row_num = 1;
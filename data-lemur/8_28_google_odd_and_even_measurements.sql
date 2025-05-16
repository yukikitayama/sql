WITH

row_numbers AS (
  SELECT
    measurement_time,
    measurement_value,
    ROW_NUMBER() OVER(
      PARTITION BY measurement_time::DATE
      ORDER BY measurement_time
    ) AS row_num
  FROM
    measurements
)

SELECT
  measurement_time::DATE AS measurement_day,
  SUM(CASE WHEN row_num % 2 != 0 THEN measurement_value ELSE 0 END) AS odd_sum,
  SUM(CASE WHEN row_num % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM
  row_numbers
GROUP BY
  1
ORDER BY
  1;

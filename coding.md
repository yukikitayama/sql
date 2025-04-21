# Coding

## Moving average for 7 days rolling

```
avg(price) over(
  partition by ticker 
  order by date
  rows between 6 preceding and current row
)
```
- https://stackoverflow.com/questions/25922379/sql-query-for-7-day-rolling-average-in-sql-server

## Top 5% scores

```
percent_rank() over(
  order by score desc
)
```
- Highest score gets 0.
- Lowest score gets 1.
- Null score gets 0
- Duplicated scores get the same percent rank
- https://www.sqlshack.com/calculate-sql-percentile-using-the-sql-server-percent_rank-function/

## 75 percentile salary

```
percentile_cont(0.75) within group (order by salary) over(partition by department)
```
- PERCENTILE_CONT will interpolate
- PERCENTILE_DISC returns a value in the range (lowest value if tie)
- https://stackoverflow.com/questions/23585667/percentile-disc-vs-percentile-cont
- https://stackoverflow.com/questions/33765734/how-to-calculate-90th-percentile-sd-mean-for-data-in-sql

## BIT_AND(), BIT_OR()
- Aggregation function.
- BIT_AND(column) converts numbers in column to binary representation, and do bitwise AND over all the numbers
- BIT_OR(column) converts numbers in column to binary representation, and do bitwise OR over all the numbers
- https://leetcode.com/problems/bitwise-user-permissions-analysis/description/

## Concatenate vertical multiple rows to horizontal one row

- `GROUP_CONCAT(col ORDER BY col SEPARATOR ', ')` converts `[[2], [1], [3]]` into `[[1, 2, 3]]`
- [3328. Find Cities in Each State II](https://leetcode.com/problems/find-cities-in-each-state-ii/description/)

## Count a particular character or word in text column

- `length(column) - length(replace(column, character, ''))`
- [3451. Find Invalid IP Addresses](https://leetcode.com/problems/find-invalid-ip-addresses/)
  - Hard
- https://stackoverflow.com/questions/12344795/count-the-number-of-occurrences-of-a-string-in-a-varchar-field

## Split a column by a delimiter

- `SUBSTRING_INDEX('1.12.123.234', '.', 1)` returns `1`
- `SUBSTRING_INDEX('1.12.123.234', '.', -1)` returns `234`
- `SUBSTRING_INDEX('1.12.123.234', '.', 2)` returns `1.12`
- `SUBSTRING_INDEX('1.12.123.234', '.', -2)` returns `123.234`
- https://www.w3schools.com/sql/func_mysql_substring_index.asp
- [3451. Find Invalid IP Addresses](https://leetcode.com/problems/find-invalid-ip-addresses/)
  - Hard

## Cumulative sum

- Note that `GROUP BY` doesn't appear in the code below

```
SELECT
    product_id,
    date,
    SUM(amount) OVER(PARTITION BY product_ID ORDER BY date) AS cumulative_sum
FROM
    Orders
ORDER BY
    product_id,
    date
```

# Regular expression

## Concept

- https://www.geeksforgeeks.org/mysql-regular-expressions-regexp/
- `^x`, here `^` is the start with expression, begin with `x`
- `[^0-9]`, here `^` is negation, other than 0 to 9.

## Technique

- `name REGEXP '^[^0-9]*[0-9]{3}[^0-9]*$'`
  - Exactly 3 digits appear in the middle of the name column

## LeetCode
- 
- [3415. Find Products with Three Consecutive Digits](https://leetcode.com/problems/find-products-with-three-consecutive-digits/description/)
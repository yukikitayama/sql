# Regular expression

## Concept

- https://www.geeksforgeeks.org/mysql-regular-expressions-regexp/
- `^x`, here `^` is the start with expression, begin with `x`
- `[^0-9]`, here `^` is negation, other than 0 to 9.
- `condition1|condition2`, here `|` is OR.
- `REGEXP` and `RLIKE` are synonyms for `REGEXP_LIKE()`
  - `col REGEXP 'expression'` is equal to `REGEXP_LIKE(col, 'expression')` 
  - https://dev.mysql.com/doc/refman/8.4/en/regexp.html#operator_regexp
- `+` is one or more instances of preceding element

## Technique

- `name REGEXP '^[^0-9]*[0-9]{3}[^0-9]*$'`
  - Exactly 3 digits appear in the middle of the name column
- `REGEXP_LIKE(email, '^[a-zA-Z0-9_]+@{1}[a-zA-Z]+\.com$')`
  - One `@`, ends with `.com`, part before `@` is alphanumeric and underscore, part after `@` and before `.com` is letters only
  - Use `\` backslash to use `.` itself, not as any single character
- **Word boundary**?
  - https://www.regular-expressions.info/wordboundaries.html

## LeetCode

- [3415. Find Products with Three Consecutive Digits](https://leetcode.com/problems/find-products-with-three-consecutive-digits/description/)
- [3475. DNA Pattern Recognition](https://leetcode.com/problems/dna-pattern-recognition/description/)
- [3436. Find Valid Emails](https://leetcode.com/problems/find-valid-emails/description/)
- [3451. Find Invalid IP Addresses](https://leetcode.com/problems/find-invalid-ip-addresses/)
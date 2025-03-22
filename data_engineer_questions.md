# Data engineer questions

## What SQL optimization exists?
Create indexes on frequently used columns in where clauses, join conditions, and order by clauses. But don’t create too many.
An index prevents you from having to scan the entire table.
Use where instead of having, because where filters are recorded before groups are created but having filters are recorded after creating groups.
Avoid running query inside loop. and use bulk update.
Correct use of join. Avoid outer join unless necessary because it produces duplicates. Inner join can reduce the number of rows returned. But in practice, left join is safe approach.
Use common table expression (CTE) instead of subqueries to optimize readability and debugging.
Use limit to reduce the number of rows returned.
Use stored procedures. It optimizes logic. Cloud databases can cache and improve speed.
Select only necessary columns and avoid asterisk.
Use denormalization to have redundant data in a table to avoid join
Use partition table in BigQuery to avoid entire scan. It improves performance because, rather than searching the entire table, it’s only searching a small part of it.
Sharding can increase processing speeds because splitting one big database into smaller databases, and the load is split across different servers.
Use exist instead of in. Exist is faster than in because it avoid scanning and comparing every value.
If you don’t care about duplicates when vertically joining multiple tables, use union instead of union all, because it save processing time.
Normalize database tables.
First Normal Form (1NF) makes each row have a key
Second Normal Form (2NF) allows a field with multiple values to be broken into their own rows.
Third Normal Form (3NF) is after breaking into multiple rows by 2NF, create separate tables. 
Not yet read
https://medium.com/womenintechnology/optimizing-sql-query-performance-a-comprehensive-guide-6cb72b9f52ef
https://cloud.google.com/bigquery/docs/search-index#best_practices
Finish reading
https://www.thoughtspot.com/data-trends/data-modeling/optimizing-sql-queries
https://www.geeksforgeeks.org/best-practices-for-sql-query-optimizations/

## What is checksum?
Checksum is a value calculated from the contents of the data.
It acts as a unique identifier.
Can be used to check any change or corruption during transmission or storage.

## What’s the difference between DROP, DELETE, and TRUNCATE in SQL?
DELETE statement is to delete the specific rows
DROP statement is to delete the entire table or database
TRUNCATE statement is to delete all the rows but retain the table structure.
https://www.geeksforgeeks.org/difference-between-delete-drop-and-truncate/

## How to load CSV to Pandas Dataframe and upload it to Postgres database?
xxx

## How to connect and check database structure in Postgres?
xxx

## Compute moving average in MySQL/Postgres
xxx

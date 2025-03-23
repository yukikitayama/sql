# Concept

- Transaction
  - A transaction is like a package of database operations that belong together. Think of it as a to-do list where either everything gets done, or nothing does. 
  - For example, when you buy something online, the transaction might include: checking your balance, deducting money from your account, and updating the store's inventory. These steps must all succeed together for the purchase to be valid.
- Commit
  - A commit is like pressing the "Save" button on your changes. 
  - When you commit a transaction, you're telling the database "I'm sure about all these changes - make them permanent." 
  - It's similar to signing a contract - once you commit, the changes are officially recorded and can't be easily undone.
- Rollback
  - A rollback is like an "undo" button for your transaction. 
  - If anything goes wrong during your transaction (like a network error or insufficient funds), a rollback returns everything to how it was before the transaction started. 
  - It's similar to erasing everything you wrote on a page and starting fresh.
  - If you do `ROLLBACK TO savepoint_name;`, you can rollback to the savepoint
- Savepoint
  - A SAVEPOINT is like placing multiple bookmarks while writing an important document. 
  - If you make a mistake, instead of erasing everything and starting over, you can go back to the last bookmark and continue from there.

```
-- Create a sample table if it does not exist
CREATE TABLE IF NOT EXISTS Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Start a transaction
BEGIN TRANSACTION;

-- Insert a new employee
INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'John Doe', 50000);

-- Create a savepoint
SAVEPOINT sp1;

-- Insert another employee
INSERT INTO Employees (EmpID, Name, Salary) VALUES (2, 'Jane Smith', 60000);

-- Create another savepoint
SAVEPOINT sp2;

-- Insert another employee
INSERT INTO Employees (EmpID, Name, Salary) VALUES (3, 'Jordan', 70000);

-- Create another savepoint
SAVEPOINT sp3;

-- Insert another employee
-- Assume that this record was repeatedly entred by mistake (as this already exists)
INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'John Doe', 50000);

SELECT * FROM Employees;

-- Since the last INSERT was a mistake, rollback to the last savepoint (sp3)
ROLLBACK TO sp3;

.print "After rollback the transaction is removed"

-- Now commit the transaction
COMMIT;

-- Verify the data
SELECT * FROM Employees;
```

## ACID

- Atomicity
  - All or nothing
  - Either the entire operation completes successfully or none of it does.
- Consistency
  - Your data always follows the rules
  - Consistency ensures that data always follows business rules and constraints.
  - e.g., If a discount is applied, the system must enforce the rule that the total price cannot be negative, ensuring that the database remains in a valid state.
- Isolation
  - Transactions don't interfere with each other
- Durability
  - Once saved, data stays saved.
- Why do we need ACID?
  - Data is used in critical systems like medical records, banking transactions, flight bookings
  - Multiple users use applications simultaneously and must not conflict
  - System failure like power outages, network issues can happen but it should not corrupt or lose our data.

## Locking

- Maintain data consistency and integrity in multi-user database environments
- Prevents concurrent transactions
- Row-level locks
  - Restricts access to individual rows within a table
  - High concurrency: multiple transactions can operate on different rows of the same table
  - Reduced contention: less blocking and waiting time for transactions
  - Improved performance: faster transaction processing due to increased concurrency
  - Increased overhead: managing a large number of row-level locks can consume significant system resources
  - Potential for deadlocks: deadlocks can occur if two or more transactions are waiting for each other to release locks on rows.
- Table-leve locks
  - When a transaction acquires a table-level lock, it locks the entire table, preventing other transactions from accessing or modifying any row in that table.
  - Simpler management: fewer locks to manage compared to row-level locks
  - Lower overhead: less system resources are required to manage table-level locks
  - Reduced concurrency: only one transaction can access the table at a time
  - Increased contention: transactions may have to wait longer for the table to become available
  - Poorer performance: slower transaction processing due to reduced concurrency

## Deadlock

- A deadlock occurs when two or more transactions are blocked indefinitely, waiting for each other to release the resources (locks) that they need.
- 4 necessary conditions must hold for a deadlock to occur
  - Mutual exclusion: a resource can only be held by one transaction at a time
  - Hold and wait: a transaction holding a resource can request additional resources
  - No preemption: resources cannot be forcibly taken away from a transaction
    - They must be released voluntarily
  - Circular waitL a set of transactions exists such that each transaction is waiting for a resource held by another transaction in the set.
- Handling deadlocks
  - Deadlock detection: the database periodically checks for circular wait conditions
  - Deadlock prevention: strategies that prevent the four necessary conditions from occurring
  - Deadlock avoidance: carefully allocating resources to prevent the possibility of deadlocks
  - Deadlock resolution (victim selection): choosing one or more victim transactions to be rolled back, releasing their locks and allowing other transactions to proceed.

## Isolation levels

- Higher isolation levels provide greater consistency but can reduce concurrency
- Lower isolation levels increase concurrency but may lead to various concurrency anomalies
- Appropriate isolation level depends on the application's requirements.
- Common isolation levels
  - Read uncommitted (dirty read): the lowest level. Transactions can read uncommited changes made by other transactions
    - Highest concurrency but prone to inconsistencies
  - Read committed: transactions can only read committed changes made by other transactions
    - Dirty reads are prevented
    - Non-repeatable reads and phantom reads can still occur.
  - Repeatable read: transactions are guaranteed to see the same data throughout their execution
    - Non-repeatable reads are prevented
    - Phantom reads can still occur.
  - Serializable: the highest level. Transactions appear to execute as if they were running one at a time.
    - Highest consistency but can reduce concurrency
- Concurrency anomalies
  - **Dirty read**: reading uncommitted data
  - **Non-repeatable read**: reading the same row twice within a transaction, and the row's value is changed by another transaction in between.
  - **Phantom read**: a transaction reads a set of rows based on a condition.
    - Another transaction inserts or deletes rows that match the condition, causing the first transaction to see a different set of rows if it repeats the read.

## Aggregate function 

- `SUM()` returns the summation of all **non-NULL values**.
- `COUNT()` counts all **non-NULL values**.
- `AVG()` returns the average of all **non-NULL values**.
- Nesting of aggregate functions
  - Nesting of aggregate functions means using one aggregate function inside another 
  - i.e. output of one aggregate function is used as input for another aggregate function.
  - **It's possible to have any number of levels**.
  - Example : SELECT AVG(SUM(column_name)) AS avg_sum_value FROM table_name;
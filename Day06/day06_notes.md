CTE = Common Table Expression
CTE creates a temporary result set using WITH
CTE behaves like a temporary table inside a query
CTE exists only during query execution
Basic syntax:
WITH cte_name AS (
    query
)
SELECT *
FROM cte_name;
Main purpose of CTE:
break large queries into steps
improve readability
reuse query results
simplify nested subqueries
CTE execution flow:
Step 1 → execute CTE query
Step 2 → temporarily store result
Step 3 → main query uses it like a table
Difference between subquery and CTE:
subquery is nested directly inside query
CTE separates logic into readable steps
HAVING vs CTE:
HAVING is enough for simple aggregate filtering
CTE is useful when aggregate results need to be reused or processed further
Example where HAVING is enough:
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
Multiple CTEs:
one CTE can use a previous CTE
execution happens top to bottom
later CTEs can reference earlier CTEs
Multiple CTE syntax:
WITH first_cte AS (...),
second_cte AS (...)
SELECT *
FROM second_cte;
Common analytics pattern:
CTE 1 → aggregate data
CTE 2 → aggregate the aggregate
Final query → compare/filter
Aggregate functions cannot be nested directly:
AVG(SUM(amount))
PostgreSQL error:
aggregate function calls cannot be nested
Solution:
perform first aggregation in one CTE
perform second aggregation in another query/CTE
Example:
WITH customer_totals AS (
    SELECT customer_id, SUM(amount) AS total
    FROM payment
    GROUP BY customer_id
)
SELECT AVG(total)
FROM customer_totals;
CROSS JOIN usage with single-row aggregate CTE:
attaches one aggregate value to every row
useful for comparisons
Example:
FROM customer_totals
CROSS JOIN average_total
Recursive CTE uses:
WITH RECURSIVE
Recursive CTE can reference itself repeatedly
Recursive CTE behaves like a loop
Recursive CTE has 3 parts:
starting point (base case)
repeating logic (recursive part)
stopping condition
Recursive CTE structure:
WITH RECURSIVE name AS (

    base_case

    UNION ALL

    recursive_case
)
Recursive CTE example:
WITH RECURSIVE numbers AS (

    SELECT 1 AS num

    UNION ALL

    SELECT num + 1
    FROM numbers
    WHERE num < 5
)

SELECT *
FROM numbers;
Important recursive concept:
FROM numbers

inside recursive section means the CTE is reading its own previous output

Recursive CTE common use cases:
employee-manager hierarchies
folder structures
category trees
graph traversal
organizational charts
Better practice:
use dvdrental only for querying/practice
create separate database for experimentation
Suggested practice database:
CREATE DATABASE sql_lab;
Suggested hierarchy practice table:
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);
1. PostgreSQL Database vs Connection

In PostgreSQL, a connection is tied to ONE database.

Unlike MySQL, PostgreSQL does NOT support:

USE database_name;

So in DBeaver:

each SQL editor tab is connected to a specific database
opening a query under postgres cannot access tables from dvdrental

To check current database:

SELECT current_database();
2. Schemas in PostgreSQL

Tables are usually inside schemas.

Default schema:

public

Example:

SELECT * FROM public.film;

If schema/search path is wrong:

tables may appear as “does not exist”

Check current schema:

SELECT current_schema();
3. LIKE Operator

LIKE is used for pattern matching.

Wildcards
Symbol	Meaning
%	any number of characters
_	exactly one character
Examples
Starts with
LIKE 'Ann%'

Matches:

Ann
Anna
Annabelle
Ends with
LIKE '%Ann'

Matches:

JoAnn
MaryAnn
Contains anywhere
LIKE '%Ann%'

Matches:

Ann
Annabelle
Joanna
4. Selecting Multiple Columns

Wrong:

SELECT first_name AND last_name

Correct:

SELECT first_name, last_name

AND is NOT used to combine columns.

5. String Concatenation in PostgreSQL

Use ||

Example:

SELECT first_name || ' ' || last_name AS full_name
FROM actor;
6. AND Operator

AND is a boolean/logical operator.

Example:

WHERE age > 18
AND country = 'India'

Meaning:
both conditions must be true.

7. BETWEEN

Syntax:

value BETWEEN lower AND upper

Equivalent to:

value >= lower
AND value <= upper
IMPORTANT

Lower value must come first.

Wrong:

BETWEEN '2007-12-31' AND '2006-02-01'

Correct:

BETWEEN '2006-02-01' AND '2007-12-31'
8. LIMIT

Used to restrict number of rows.

SELECT *
FROM customer
LIMIT 5;

Returns only 5 rows.

9. OFFSET

Used to skip rows.

SELECT *
FROM customer
OFFSET 2;

Skips first 2 rows.

10. LIMIT + OFFSET

Example:

SELECT *
FROM customer
ORDER BY customer_id
LIMIT 5
OFFSET 2;

Execution:

ORDER rows
SKIP first 2
RETURN next 5
11. ORDER BY Importance

Without ORDER BY, PostgreSQL does NOT guarantee row order.

Always use:

ORDER BY column_name

with:

LIMIT
OFFSET
FETCH
12. Correct SQL Clause Order

General order:

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
OFFSET
13. FETCH Clause

FETCH is SQL-standard alternative to LIMIT.

Equivalent:

LIMIT 5
FETCH FIRST 5 ROWS ONLY
14. DATE Datatype

PostgreSQL supports:

DATE

Format:

YYYY-MM-DD

Example:

SELECT CURRENT_DATE;
15. Type Casting

PostgreSQL shorthand:

value::datatype

Example:

payment_date::DATE

Converts timestamp → date.

Equivalent to:

CAST(payment_date AS DATE)
16. Date Comparisons

Dates must be written as strings.

Wrong:

2006-02-15

interpreted as math:

2006 - 2 - 15

Correct:

'2006-02-15'
17. IN Operator with Dates

Correct:

SELECT *
FROM payment
WHERE payment_date::DATE
IN ('2006-02-15', '2006-02-13');

DBeaver Display Formatting

Sometimes DBeaver displays numbers like:

2,006

even though actual stored value is:

2006

This is UI formatting, not actual stored commas.
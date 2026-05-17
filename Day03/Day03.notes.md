SQL Joins Notes
INNER JOIN
Keeps only matching rows from both tables
Rows disappear if no match exists
NULL values themselves are not removed automatically
If join column contains NULL, it usually fails to match because:
NULL = NULL
is not TRUE in SQL

Syntax:
SELECT ...
FROM table1
INNER JOIN table2
ON table1.id = table2.id;

Mistake made:
Put WHERE before ON
Wrong:
FROM customer INNER JOIN address
WHERE ...
ON ...

Correct order:
FROM customer
INNER JOIN address
ON ...
WHERE ...

Another mistake:
Joined wrong columns:
address.address_id = customer.customer_id

Correct:

address.address_id = customer.address_id
Ambiguous Columns

If same column exists in multiple tables:

SELECT address_id

causes ambiguity.

Need:

SELECT customer.address_id

Best practice:
Use aliases.

Example:

FROM customer c
JOIN address a
ON c.address_id = a.address_id
LEFT JOIN

Keeps ALL rows from left table.
Matching rows from right table are added.
If no match:

right side becomes NULL

Mental model:

LEFT table preserved
RIGHT table optional

Important:
LEFT JOIN does NOT guarantee NULLs.
NULLs appear only if unmatched rows exist in dataset.

Big mistake beginners make:

LEFT JOIN ...
WHERE right_table.column IS NOT NULL

This destroys LEFT JOIN behavior and effectively becomes INNER JOIN.

LEFT ANTI JOIN

Used to find rows in left table with NO match.

Pattern:

LEFT JOIN ...
WHERE right_table.id IS NULL

Important:
Usually check right table PK column for NULL.

Example:

WHERE inventory.inventory_id IS NULL
RIGHT JOIN

Mirror of LEFT JOIN.

A RIGHT JOIN B

means:

preserve ALL rows from B

Equivalent idea:

payment RIGHT JOIN customer

same as:

customer LEFT JOIN payment

RIGHT JOIN rarely used professionally because LEFT JOIN is easier mentally.

RIGHT ANTI JOIN

Find rows from RIGHT table with no match.

Pattern:

RIGHT JOIN ...
WHERE left_table.id IS NULL

Mistake made:
Query intention and preserved table got mixed up.

Wanted:

staffs with no rentals

But wrote:

staff RIGHT JOIN rental

which actually means:

preserve rentals

Correct query should preserve staff:

staff LEFT JOIN rental
FULL OUTER JOIN

Keeps:

all left table rows
all right table rows
matched rows merged

Unmatched rows get NULLs.

Syntax:

FULL OUTER JOIN

Mistake:
Forgot ON clause.

Correct:

FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
ORDER BY NULLS FIRST/LAST

These only affect NULL placement.
They do NOT control ascending/descending order.

Examples:

ORDER BY amount DESC NULLS FIRST
ORDER BY amount ASC NULLS LAST

PostgreSQL defaults:

ASC → NULLS LAST
DESC → NULLS FIRST

Confusion happened because dataset had no NULL values in ordering column.

Aliases

If alias is assigned:

payment AS p

then original table name should no longer be used.

Wrong:

payment.amount

Correct:

p.amount

Important realization:

aliasing one table does not force aliasing another table
aliases are optional per table

Professional style:

FROM customer c
JOIN payment p

instead of long names.

also this dataset is super nice, it has good foreign key referential integrity and hence very few null values. practice joins on a more, unclean? dataset.


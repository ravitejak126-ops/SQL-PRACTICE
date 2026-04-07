# SQL Mastery Guide with Sakila Examples

Beginner-friendly SQL study material built around the **Sakila** sample database.

## Topics
1. [Cardinality](./01-cardinality.md)
2. [Joins](./02-joins.md)
3. [Common Table Expressions (CTEs)](./03-ctes.md)
4. [Recursive CTEs](./04-recursive-ctes.md)
5. [Views and Abstraction](./05-views.md)
6. [Stored Procedures](./06-stored-procedures.md)

## Why Sakila?
Sakila is a realistic sample database with tables like:
- `customer`
- `film`
- `rental`
- `payment`
- `inventory`
- `actor`
- `film_actor`
- `category`
- `film_category`
- `staff`
- `store`

That makes it ideal for interview prep and practical SQL learning.

## Recommended Learning Order
1. Start with joins
2. Then learn cardinality
3. Practice CTEs
4. Move into recursive CTEs
5. Learn views
6. Finish with stored procedures

## Notes
- Some stored procedure syntax varies by database engine.
- Most examples here are written for **MySQL-style Sakila**.

## Repo Structure
- Markdown topic files for theory + examples
- `examples/sakila-practice.sql` for runnable practice queries

# Joins

## Simple Definition
A join combines rows from two or more tables using related columns.

## Intuition
A join lets you answer questions like:
> Which customer made this payment?
> Which actor appears in this film?
> Which store owns this inventory item?

## Basic Syntax

```sql
SELECT columns
FROM table1
JOIN table2
    ON table1.key = table2.key;
```

## Sakila Join Examples

### 1. INNER JOIN
Show payments with customer names.

```sql
SELECT p.payment_id, p.amount, p.payment_date,
       c.first_name, c.last_name
FROM payment p
INNER JOIN customer c
    ON p.customer_id = c.customer_id
ORDER BY p.payment_date DESC;
```

### 2. LEFT JOIN
Show all films and any matching inventory copies.
Films with no inventory still appear.

```sql
SELECT f.film_id, f.title, i.inventory_id, i.store_id
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
ORDER BY f.title;
```

### 3. Multi-Table Join
Show each rental with customer name and film title.

```sql
SELECT r.rental_id,
       r.rental_date,
       c.first_name,
       c.last_name,
       f.title
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
ORDER BY r.rental_date DESC;
```

### 4. Join Through a Junction Table
List actors for each film.

```sql
SELECT f.title, a.first_name, a.last_name
FROM film f
JOIN film_actor fa
    ON f.film_id = fa.film_id
JOIN actor a
    ON fa.actor_id = a.actor_id
ORDER BY f.title, a.last_name;
```

### 5. Aggregation After Join
Find total revenue by customer.

```sql
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;
```

## When to Use
- Combining related data
- Building reports
- Answering business questions across tables

## Common Mistakes
- Missing the `ON` clause
- Joining on the wrong column
- Using `LEFT JOIN` and then filtering away null rows in `WHERE`
- Forgetting that one-to-many joins can increase row count

## Interview Tips
- Know the difference between:
  - `INNER JOIN`
  - `LEFT JOIN`
- Be ready to explain the path:
  - `rental -> inventory -> film`
- In Sakila, many questions require multiple joins, not just one

## Advanced Patterns

### LEFT JOIN trap
This query behaves like an inner join because of the `WHERE` filter:

```sql
SELECT f.title, i.inventory_id
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
WHERE i.store_id = 1;
```

To preserve unmatched films, move the condition into the join:

```sql
SELECT f.title, i.inventory_id
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
   AND i.store_id = 1;
```

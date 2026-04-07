# Cardinality

## Simple Definition
Cardinality describes how rows in one table relate to rows in another table.

## Intuition
Ask:
> How many rows from table A can be connected to table B?

In Sakila:
- One **customer** can have many **rentals**
- One **film** can appear in many **inventory** rows
- Many **actors** can appear in many **films**

## Basic Types
- **One-to-One**
- **One-to-Many**
- **Many-to-Many**

## How Cardinality Appears in SQL
Cardinality is usually enforced with:
- Primary keys
- Foreign keys
- Junction tables

## Sakila Examples

### 1. One-to-Many: customer -> rental
One customer can rent many times.

```sql
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c
JOIN rental r
    ON c.customer_id = r.customer_id
ORDER BY c.customer_id, r.rental_date;
```

### 2. One-to-Many: film -> inventory
One film can have many physical copies in inventory.

```sql
SELECT f.film_id, f.title, i.inventory_id, i.store_id
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
ORDER BY f.film_id, i.inventory_id;
```

### 3. Many-to-Many: film <-> actor
A film can have many actors, and an actor can appear in many films.
This is handled by the junction table `film_actor`.

```sql
SELECT f.title, a.first_name, a.last_name
FROM film f
JOIN film_actor fa
    ON f.film_id = fa.film_id
JOIN actor a
    ON fa.actor_id = a.actor_id
ORDER BY f.title, a.last_name;
```

## When to Use
- Designing schemas
- Understanding why joins return many rows
- Preventing duplicate-looking results that are actually valid

## Common Mistakes
- Thinking a duplicate row always means bad data
- Forgetting that many-to-many relationships need a junction table
- Joining tables without understanding relationship size

## Interview Tips
- Use Sakila examples:
  - `customer -> rental` = one-to-many
  - `film -> actor` through `film_actor` = many-to-many
- If a join returns more rows than expected, explain the cardinality first

## Advanced Note
Cardinality affects result size, performance, and aggregation.
For example, counting films after joining `film_actor` without care can overcount results.

```sql
SELECT COUNT(*) AS joined_rows
FROM film f
JOIN film_actor fa
    ON f.film_id = fa.film_id;
```

If you want unique films instead:

```sql
SELECT COUNT(DISTINCT f.film_id) AS unique_films
FROM film f
JOIN film_actor fa
    ON f.film_id = fa.film_id;
```

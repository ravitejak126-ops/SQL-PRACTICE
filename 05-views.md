# Views and Abstraction

## Simple Definition
A view is a virtual table created from a query.

## Intuition
A view lets you save a useful query and treat it like a table.

## Syntax

```sql
CREATE VIEW view_name AS
SELECT ...
FROM ...;
```

## Sakila Examples

### 1. Simple View
Create a view for customer full names and email.

```sql
CREATE VIEW customer_contact_info AS
SELECT customer_id,
       CONCAT(first_name, ' ', last_name) AS full_name,
       email
FROM customer;
```

Use it like this:

```sql
SELECT *
FROM customer_contact_info
ORDER BY full_name;
```

### 2. Reporting View
Create a view of rental facts.

```sql
CREATE VIEW rental_details AS
SELECT r.rental_id,
       r.rental_date,
       c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       f.film_id,
       f.title
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id;
```

Then query it:

```sql
SELECT *
FROM rental_details
WHERE customer_id = 1
ORDER BY rental_date DESC;
```

## When to Use
- Simplifying repeated joins
- Hiding complexity
- Restricting column access
- Making analyst queries easier

## Common Mistakes
- Thinking a regular view stores data physically
- Building overly complex nested views
- Assuming views always improve performance

## Interview Tips
- A view improves abstraction and maintainability
- A materialized view stores results physically, but a normal view does not
- Views are especially helpful for repeated business queries

## Advanced Example
Create a revenue summary view by category.

```sql
CREATE VIEW category_revenue AS
SELECT cat.category_id,
       cat.name AS category_name,
       SUM(p.amount) AS total_revenue
FROM category cat
JOIN film_category fc
    ON cat.category_id = fc.category_id
JOIN inventory i
    ON fc.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY cat.category_id, cat.name;
```

Query it:

```sql
SELECT *
FROM category_revenue
ORDER BY total_revenue DESC;
```

# Common Table Expressions (CTEs)

## Simple Definition
A CTE is a temporary named result set used inside a single query.

## Intuition
A CTE is like giving a subquery a name so the full query becomes easier to read.

## Syntax

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT *
FROM cte_name;
```

## Sakila Examples

### 1. Basic CTE
Find customers with total payments.

```sql
WITH customer_totals AS (
    SELECT customer_id, SUM(amount) AS total_paid
    FROM payment
    GROUP BY customer_id
)
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       ct.total_paid
FROM customer c
JOIN customer_totals ct
    ON c.customer_id = ct.customer_id
ORDER BY ct.total_paid DESC;
```

### 2. CTE for Readability
Find films longer than the average film length.

```sql
WITH avg_length AS (
    SELECT AVG(length) AS avg_film_length
    FROM film
)
SELECT f.film_id, f.title, f.length
FROM film f
CROSS JOIN avg_length a
WHERE f.length > a.avg_film_length
ORDER BY f.length DESC;
```

### 3. Multiple CTEs
Compare store revenue.

```sql
WITH store_payments AS (
    SELECT s.store_id, SUM(p.amount) AS revenue
    FROM store s
    JOIN customer c
        ON s.store_id = c.store_id
    JOIN payment p
        ON c.customer_id = p.customer_id
    GROUP BY s.store_id
),
ranked_store_revenue AS (
    SELECT store_id,
           revenue,
           DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
    FROM store_payments
)
SELECT *
FROM ranked_store_revenue;
```

## When to Use
- Breaking complex logic into steps
- Making interview answers easier to explain
- Reusing a result set in the final query

## Common Mistakes
- Thinking a CTE is stored permanently
- Writing a CTE when a simple query is enough
- Forgetting that CTE scope is only one statement

## Interview Tips
- Describe a CTE as a readability tool first
- Then mention it can also help structure layered logic
- Be ready to compare CTEs with subqueries and temp tables

## Advanced Example
Find top 5 customers by spending, then show their rental counts.

```sql
WITH customer_spend AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
),
top_customers AS (
    SELECT customer_id, total_spent
    FROM customer_spend
    ORDER BY total_spent DESC
    LIMIT 5
)
SELECT tc.customer_id,
       c.first_name,
       c.last_name,
       tc.total_spent,
       COUNT(r.rental_id) AS rental_count
FROM top_customers tc
JOIN customer c
    ON tc.customer_id = c.customer_id
LEFT JOIN rental r
    ON tc.customer_id = r.customer_id
GROUP BY tc.customer_id, c.first_name, c.last_name, tc.total_spent
ORDER BY tc.total_spent DESC;
```

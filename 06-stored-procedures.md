# Stored Procedures

## Simple Definition
A stored procedure is reusable SQL logic saved in the database.

## Intuition
Instead of rewriting the same query again and again, you can store it once and call it with parameters.

## Syntax (MySQL Style)

```sql
DELIMITER $$

CREATE PROCEDURE procedure_name (IN param_name data_type)
BEGIN
    SELECT ...;
END $$

DELIMITER ;
```

## Sakila Examples

### 1. Get all rentals for a customer

```sql
DELIMITER $$

CREATE PROCEDURE GetCustomerRentals (IN p_customer_id INT)
BEGIN
    SELECT r.rental_id,
           r.rental_date,
           f.title
    FROM rental r
    JOIN inventory i
        ON r.inventory_id = i.inventory_id
    JOIN film f
        ON i.film_id = f.film_id
    WHERE r.customer_id = p_customer_id
    ORDER BY r.rental_date DESC;
END $$

DELIMITER ;
```

Call it:

```sql
CALL GetCustomerRentals(1);
```

### 2. Get total payments for a customer

```sql
DELIMITER $$

CREATE PROCEDURE GetCustomerPaymentTotal (IN p_customer_id INT)
BEGIN
    SELECT c.customer_id,
           c.first_name,
           c.last_name,
           SUM(p.amount) AS total_paid
    FROM customer c
    JOIN payment p
        ON c.customer_id = p.customer_id
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name;
END $$

DELIMITER ;
```

Call it:

```sql
CALL GetCustomerPaymentTotal(1);
```

## When to Use
- Reusable business logic
- Standardized reporting
- Reducing repeated SQL in applications

## Common Mistakes
- Hardcoding values instead of parameters
- Putting too much application logic in the database
- Forgetting engine-specific syntax differences

## Interview Tips
- A procedure can accept parameters and run multiple statements
- Be ready to compare:
  - procedure vs function
  - procedure vs application-layer logic

## Advanced Example
Procedure with conditional logic.

```sql
DELIMITER $$

CREATE PROCEDURE GetFilmsByLengthCategory (IN p_category VARCHAR(20))
BEGIN
    IF p_category = 'SHORT' THEN
        SELECT film_id, title, length
        FROM film
        WHERE length < 60;
    ELSEIF p_category = 'MEDIUM' THEN
        SELECT film_id, title, length
        FROM film
        WHERE length BETWEEN 60 AND 120;
    ELSE
        SELECT film_id, title, length
        FROM film
        WHERE length > 120;
    END IF;
END $$

DELIMITER ;
```

Call it:

```sql
CALL GetFilmsByLengthCategory('MEDIUM');
```

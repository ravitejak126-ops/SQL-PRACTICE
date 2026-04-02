-- Topic: DBMS vs RDBMS
-- MySQL is an RDBMS (Relational DB)

-- Show all tables
SHOW TABLES;

-- View all films
SELECT *
FROM film;

-- View film id and title
SELECT film_id, title
FROM film;

-- Challenge:
-- Show all columns from customer table
-- Task 1
SELECT actor_id, first_name
FROM actor;

-- Task 2
SELECT *
FROM film;

-- Task 3
SELECT title, release_year
FROM film;
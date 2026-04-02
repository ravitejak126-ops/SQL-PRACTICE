-- Task 1
SHOW DATABASES;

-- Task 2
USE sakila;

-- Task 3
SHOW TABLES;

-- Topic: Schemas and Databases

-- Show all databases
SHOW DATABASES;

-- Use sakila database
USE sakila;

-- Show tables
SHOW TABLES;

-- Challenge:
-- Switch to sakila and show all data from actor table
Use Sakila;
SELECT * 
FROM actor;
-- Topic: SQL Syntax Rules

-- Task 1
SELECT *
FROM customer;

-- Task 2
SELECT title
FROM film;

-- Task 3
SELECT first_name, last_name
FROM actor;

-- Challenge:
-- Select all columns from film table (proper formatting)
SELECT * 
FROM film
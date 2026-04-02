USE test_db;

-- Task 1
CREATE TABLE employees (
    id INT,
    name VARCHAR(50)
);

-- Task 2
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100)
);

-- Task 3
CREATE TABLE orders (
    order_id INT,
    order_date DATE
);
-- Challenge:
-- Create students table with student_id, student_name, age
CREATE TABLE student(student_id INT, student_name VARCHAR(50),age INT);
-- Challenge Solution:
CREATE TABLE students (
    student_id INT,
    student_name VARCHAR(100),
    age INT
);
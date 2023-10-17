-- Syntax: SELECT columns FROM table
SELECT * -- * means ALL COLUMNS
FROM actor;

-- Can be one line, the semicolon is what ends a command
SELECT *
FROM film;

-- Query for specific columns -- SELECT col_1, col_2, col_3, etc. FROM table_name
SELECT title, description, lengh
FROM film;

-- *Columns will come ack in the order specified
SELECT last_name, first_name
FROM actor;

-- Filter Rows - use WHERE clause - always come after the FROM
SELECT *
FROM actor 
WHERE first_name = 'Dan'; -- can ONLY use single QUOTE FOR strings!!!! double quotes FOR COLUMNS!!!

SELECT first_name, last_name, store_id
FROM customer
WHERE store_id = 2;

-- use wildcards with the LIKE clause - % acts as a multi-character wildcard
-- can be any number of characters (0 -> intinity) - zero or many - r'[\w\s]*'
SELECT *
FROM actor 
WHERE first_name LIKE 'M%'; -- ALL FIRST names starting WITH "M"

SELECT *
FROM actor
WHERE last_name LIKE '%r%'; -- IF there IS "r" somewhere IN the LAST name -- ILIKE will turn 'h' CASE INSENSITIVE!!!!

-- Underscore (_) with LIKE clause -- represents 1 and only 1 character
SELECT *
FROM actor
WHERE first_name LIKE '_i_'; -- FIRST name has letter i letter

SELECT *
FROM actor
WHERE first_name LIKE '_i%'; -- FIRST name has letter i whatever AFTER

-- useing AND and OR in the WHERE clause
-- OR - only one needs to be true
SELECT *
FROM actor
WHERE first_name LIKE 'N%' OR last_name LIKE 'W%';

-- AND -- all conditions need to be true
SELECT *
FROM actor
WHERE first_name LIKE 'N%' AND last_name LIKE 'W%';


-- Comparison Operators in SQL:
-- Greater than > 	
-- Less than <
-- >=	<=
-- Equal =
-- Not Equal <> or !=

SELECT *
FROM payment;

-- Query all of the payments of more than $7.00
SELECT customer_id, amount
FROM payment
WHERE amount > 7.00;

SELECT customer_id, amount
FROM payment
WHERE amount > '7'; -- either way works!! 7.00 OR '7'

-- Not Equals
SELECT *
FROM customer
WHERE store_id <> 1; -- ALL ids that does NOT equal 1

SELECT *
FROM customer
WHERE store_id != 2; -- ALL ids that does NOT equal 2 -- same AS above diferent sign

SELECT *
FROM actor
WHERE first_name NOT LIKE 'P%'; -- ALL LAST names that does NOT START WITH "P"

-- Get all payments between $3 and $8 (inclusive)
SELECT *
FROM payment
WHERE amount >= 3 AND amount <= 8;

-- BETWEEN/AND Clause
SELECT *
FROM payment
WHERE amount BETWEEN 3 AND 8;

SELECT *
FROM film
WHERE film_id BETWEEN 10 AND 20;

-- Order the rows of data - ORDER BY
-- default is Ascending order (add DESC for descending)

SELECT *
FROM film
ORDER BY length;

SELECT *
FROM film
ORDER BY title DESC;

-- ORDER BY comes after the WHERE (if WHERE is present)

SELECT *
FROM payment
WHERE customer_id = 345
ORDER BY amount;


-- Exercise 1 - Write a query that will return all of the films that have an 'h' in the title and order it 
-- by rental_duration (ASC)

SELECT *
FROM film
WHERE title LIKE '%h%' -- ILIKE makes SEARCH CASE insensitive
ORDER BY rental_duration;


-- SQL Aggregations => SUM(), AVG(), COUNT(), MIN(), MAX()
-- take in a column_name as an argument and return a single value

SELECT sum(amount)
FROM payment;

SELECT sum(amount)
FROM payment
WHERE amount > 5;

-- AVG() - finds the average of a column
SELECT avg(amount)
FROM payment;

-- MIN/MAX - finds the smallest/largest value in a column
-- also alias the column name - col_name AS alias_name
SELECT min(amount) AS lowest_amount_paid, max(amount) AS highest_amount_paid
FROM payment;

-- MIN() and MAX() can work on strings al well
SELECT MIN(first_name), max(last_name)
FROM actor;


-- COUNT() - Takes in either the column name OR * for all columns
-- If column_name, will count how many NON-NULL rows, if * will count all rows
SELECT *
FROM staff;

SELECT count(*)
FROM staff; -- RETURNS 2 because there ARE 2 ROWS

SELECT count(picture)
FROM staff; -- RETURNS 1 because ONLY one ROW has a picture, the other IS NULL!

-- To count unique values in a column, use the DISTINCT keyword
-- count(distinct col_name)
SELECT count(first_name)
FROM actor; -- 200

SELECT count(DISTINCT first_name)
FROM actor; -- 128


-- Calculate a new column based on other columns
SELECT payment_id, rental_id, payment_id - rental_id AS difference -- you name the NEW result COLUMN "difference"
FROM payment;

-- CONCAT - will concatenate multiple strings together
SELECT concat(first_name, ' ', last_name) AS full_name
FROM actor;


-- GROUP BY Clause
-- Used with aggregations

SELECT count(*)
FROM payment
WHERE amount = 1.99; -- 500

SELECT count(*)
FROM payment
WHERE amount = 2.99; -- 3,233

-- instead of doing one by one, can use group by
SELECT *
FROM payment
ORDER BY amount; -- gives ALL payments

SELECT amount, count(*)
FROM payment
GROUP BY amount; -- creates a COLUMN WITH the amount AND a COLUMN WITH the number OF that amount (amount 1.99, count 580)

SELECT amount, count(*), sum(amount), avg(amount)
FROM payment
GROUP BY amount 
ORDER BY amount;

-- column selected from the table must also be in the group by
SELECT amount, customer_id, count(*)
FROM payment
GROUP BY amount; -- COLUMN "payment.customer_id" must appear IN the GROUP BY clause OR be used IN an AGGREGATE FUNCTION

SELECT amount, customer_id, count(*)
FROM payment
GROUP BY amount, customer_id 
ORDER BY customer_id;

-- Use Aggregation results in the ORDER BY clause
-- QUERY the payment table to display the customer (by id) who have spent the most (in order)
SELECT customer_id, sum(amount)
FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC; -- FROM spent the most TO LEAST

-- Alias the aggregated column and use in the order by
SELECT customer_id, sum(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC;

-- HAVING Clause -> HAVING is to group by/aggregations as where is to select
SELECT customer_id, sum(amount) AS total_spent
FROM payment
GROUP BY customer_id 
HAVING sum(amount) > 150
ORDER BY total_spent DESC;

SELECT customer_id, count(*)
FROM payment
GROUP BY customer_id 
HAVING count(*) >= 20 AND count(*) <= 30;


-- LIMIT and OFFSET clauses
-- LIMIT - limit the number of rows that are returned

SELECT *
FROM film
LIMIT 20;

-- OFFSET - start your rows after a certain number of rows using offset
SELECT *
FROM actor
OFFSET 10; -- SKIP the FIRST 10 ROWS

-- CAn be used together
SELECT *
FROM actor
OFFSET 10
LIMIT 5;

-- Putting al of the clauses together
-- Of all customer who have made less than 20 payments and  have a customer_id > 350, display 
-- those who have spent 11-20th most
SELECT customer_id, count(*), sum(amount) AS total_spent
FROM payment
WHERE customer_id > 350
GROUP BY customer_id
HAVING count(*) < 20
ORDER BY total_spent DESC
OFFSET 10
LIMIT 10;


-- SYNTAX ORDER: (SELECT and FROM are the only mandatory)

-- SELECT (column from table)
-- FROM (table_name)
-- WHERE (row filter)
-- GROUP BY (aggregation)
-- HAVING (filter aggregation)
-- ORDER BY (column value ASC OR DESC)
-- OFFSET (number of rows to skip)
-- LIMIT (max number of rows to display



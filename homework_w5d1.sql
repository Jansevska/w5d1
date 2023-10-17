-- Question 1
SELECT *
FROM actor
WHERE last_name = 'Wahlberg';
-- Answer: 2 (Nick and Daryl Wahlberg)


-- Question 2
SELECT count(amount) -- OR count(*) gives same result
FROM payment
WHERE amount BETWEEN 3.99 AND 5.99;
--Answer: 5,607


--Question 3
SELECT *
FROM inventory
WHERE inventory.film_id  = '7';
-- 32 - 36
SELECT *
FROM film
WHERE film_id BETWEEN 32 AND 36;
-- Answer:
-- id:	title: 
-- 32	Apocalypse Flamingos
-- 33	Apollo Teen
-- 34	Arabia Dogma
-- 35	Arachnophobia Rollercoaster
-- 36	Argonauts Town


-- Question 4
SELECT count(*)
FROM customer
WHERE first_name = 'Willie';
-- Answer: 2


-- Question 5
SELECT staff_id, sum(rental_id)
FROM rental
GROUP BY staff_id 
ORDER BY sum(rental_id) DESC;
-- Answer:
-- 1	64,772,289
-- 2	63,986,771


-- Question 6
SELECT count(DISTINCT district)
FROM address;
-- Answer: 378


-- Question 7
SELECT max(film_id) 
FROM film_actor;
-- Answer: 1,000


-- Question 8
SELECT count(*) 
FROM customer
WHERE last_name LIKE '%es' AND store_id = 1;
-- Answer: 13


-- Question 9
SELECT amount , count(*) 
FROM payment
WHERE customer_id BETWEEN 380 AND 430
GROUP BY amount 
HAVING count(*) > 250; 
-- answer:
--2.99	290
--4.99	281
--0.99	269




-- Question 10
SELECT count(DISTINCT rating) 
FROM film;
-- answer: 5

SELECT max(DISTINCT rating) 
FROM film;
-- answer: NC-17




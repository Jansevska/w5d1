-- Question 1
SELECT * -- could ALSO use count(*) TO give the count OF how many OF them.
FROM actor
WHERE last_name = 'Wahlberg';
-- Answer: 2 (Nick and Daryl Wahlberg)


-- Question 2
SELECT count(amount) -- OR count(*) gives same result
FROM payment
WHERE amount BETWEEN 3.99 AND 5.99; -- amount >= 3.99 AND amount <= 5.99 - same
--Answer: 5,607


--Question 3
SELECT film_id, count(*)
FROM inventory
GROUP BY film_id 
HAVING count(*) = 7; 
--Answer: see table


-- Question 4
SELECT count(*)
FROM customer
WHERE first_name = 'Willie';
-- Answer: 2


-- Question 5
SELECT staff_id, count(rental_id) 
FROM rental
GROUP BY staff_id 
ORDER BY count(rental_id)  DESC;
-- Answer: 1
-- 1	8040



-- Question 6
SELECT count(DISTINCT district)
FROM address;
-- Answer: 378


-- Question 7
SELECT film_id, count(*)  
FROM film_actor
GROUP BY film_id
ORDER BY count(actor_id) DESC;
-- Answer: Film ID 508


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
-- answer: 3 payments - 2.99, 4.99 and 0.99
--2.99	290
--4.99	281
--0.99	269




-- Question 10
SELECT rating, count(*)
FROM film
GROUP BY rating 
ORDER BY count(*) DESC;
-- Answer: 5 categories, PG-13 with the most


--SELECT count(DISTINCT rating) 
--FROM film;
-- answer: 5

--SELECT max(DISTINCT rating) -> wrong answer!
--FROM film;
-- answer: NC-17




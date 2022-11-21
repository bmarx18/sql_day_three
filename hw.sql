-- 1. List all customers who live in Texas.
SELECT customer.first_name, customer.last_name, address, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2.  Get all payments above $6.99 with the customer's full name.
SELECT customer.first_name, customer.last_name, payment.amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 5.99;

-- 3. Show all customers names who have made payments over $175.
SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id, first_name, last_name;

-- 4. List all customers that live in Nepal.
SELECT customer.first_name, customer.last_name, address, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
WHERE city = 'Nepal';

-- 5. Which staff member had the most transactions?
SELECT staff_id, COUNT(payment_id)
FROM payment
GROUP BY staff_id;

-- 6. How many movies of each rating are there?
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating;

-- 7. Show all customers who have made a single payment above $6.99.
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(customer_id) = 1
);

-- 8.  How many free rentals did our stores give away?
SELECT amount, COUNT(payment_id)
FROM payment
WHERE amount = 0.00
GROUP BY amount;
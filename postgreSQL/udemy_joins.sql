-- JOINS
-- Full outer join
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id=payment.customer_id
WHERE customer.customer_id IS NULL
OR payment.payment_id IS NULL

-- emails of customers who live in california
SELECT 
	district, email
FROM
	address
INNER JOIN customer
ON address.address_id=customer.address_id
WHERE address.district='California';


-- Get list of all movies 'Nick Wahlberg' is in
SELECT 
	film.title, actor.first_name, actor.last_name 
from 
	film_actor
INNER JOIN actor
ON film_actor.actor_id=actor.actor_id
INNER JOIN film
ON film.film_id=film_actor.film_id
WHERE
	actor.first_name='Nick' AND actor.last_name='Wahlberg'
	;
SELECT * FROM film;

-- films that have rental rate higher than average rental rate

SELECT
	title, rental_rate
FROM film
WHERE 
	rental_rate > (
					SELECT AVG(rental_rate)
					FROM film
				   );


select * from rental;
select * from film;
 
-- film titles that have been returned between surtain dates may 29 of 2005 to may 30 2005
SELECT film_id, title
FROM film
WHERE film_id IN
	(SELECT film_id FROM rental
	 JOIN inventory ON
	 rental.inventory_id=inventory.inventory_id
	 WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')
ORDER BY
	film_id
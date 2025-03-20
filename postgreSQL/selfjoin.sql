-- SELF JOIN
--Find all the pairs of films that have the same length

SELECT f1.title, f2.title, f1.length
FROM film f1
JOIN film f2 ON
	f1.length=f2.length AND
	f1.film_id!=f2.film_id;

-- exists
-- find customers  who have atleast one payment whose amount is > 11

SELECT first_name, last_name 
FROM customer c
WHERE EXISTS
	(
		SELECT * FROM payment P
		WHERE p.customer_id=c.customer_id AND
			  amount>11
	)

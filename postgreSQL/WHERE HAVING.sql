SELECT 
	first_name, last_name, email
FROM
	customer;


-- select different ratings

SELECT DISTINCT rating FROM film;

SELECT COUNT(DISTINCT rating) FROM film;

SELECT COUNT(*) FROM payment;

SELECT
	email
FROM customer
WHERE
	first_name='Nancy' AND
	last_name = 'Thomas';

SELECT
	description
FROM film
WHERE
	title = 'Outlaw Hanky';


SELECT 
	phone
FROM address
WHERE
	address='259 Ipoh Drive';

SELECT customer_id FROM payment
ORDER BY payment_date asc
LIMIT 10;

SELECT 
	COUNT(title)
FROM 
	film
WHERE
	length<=50; 

-- How many payment transactions greater than 5
SELECT 
	COUNT(*) 
FROM 
	payment
WHERE 
	amount>5;
-- How many actors have a first name that starts with letter P
SELECT
	COUNT(*) 
FROM actor
WHERE
	first_name LIKE 'J%';

-- How mant unique districts are out customers from ?
SELECT 
	DISTINCT district
FROM 
	address;

-- How many films have a rating of R and a replacement cost between $5 and $15?
SELECT
	COUNT(*)
FROM
	film
WHERE
	rating='R' AND
	replacement_cost BETWEEN 5 AND 15;

-- How many films have the word Truman somewhere in the title
SELECT
	COUNT(*)
FROM 
	film
WHERE
 title LIKE '%Truman%';


--Assignments
SELECT
	staff_id, COUNT(amount) AS Total_transactions
FROM payment
GROUP BY
	staff_id;

-----
SELECT
	rating, ROUND(AVG(replacement_cost),2)
FROM
	film
GROUP BY 
	rating;
--------------

SELECT 
	customer_id, SUM(amount) AS Total_spend
FROM 
	payment
GROUP BY
	customer_id
ORDER BY
	SUM(amount) DESC
LIMIT 5;


-- Having
select * from payment;
SELECT
	customer_id, COUNT(payment_date) AS Total_transactions
FROM
	payment
GROUP BY
	customer_id
HAVING 
	COUNT(payment_date)>=40
ORDER BY
	COUNT(payment_date);
	

---------------------------
SELECT 
	customer_id, SUM(amount) AS Payment
FROM 
	payment
WHERE
	staff_id=2
GROUP BY
	customer_id
HAVING SUM(amount)>100;


-----------------------------
--1. Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.
SELECT 
	customer_id, SUM(amount) AS Payment
FROM 
	payment
WHERE
	staff_id=2
GROUP BY
	customer_id
HAVING SUM(amount)>=110;

--2. How many films begin with the letter J?

SELECT
	Count(*)
FROM
	film
WHERE
	title LIKE 'J%';

--3. What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?
SELECT
	first_name || last_name AS Name
FROM
	customer
WHERE
	first_name LIKE 'E%' AND
	address_id<500
ORDER BY
	customer_id DESC
LIMIT
	1;

--------------------













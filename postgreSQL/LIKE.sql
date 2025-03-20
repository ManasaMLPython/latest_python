-- LIKE ILIKE
-- % for any number of characters including zero
-- _ single character match

--1. Get all actor names where first character starting with 'A'
SELECT
	*
FROM actors
WHERE first_name LIKE 'A%';

--2. Get all actors name where last name ending with 'a'
SELECT
	*
FROM 
	actors
WHERE 
	last_name LIKE '%a'
ORDER BY
	last_name;

--3. Get all actor names where first name with 5 characters only
SELECT
	*
FROM
	actors
WHERE
	first_name LIKE '_____'
ORDER BY
	first_name;

--4. Get all actor names where first name contains l on the second place
SELECT
	*
FROM
	actors
WHERE
	first_name LIKE '_l%'
ORDER BY
	first_name;
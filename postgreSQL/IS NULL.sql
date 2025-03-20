--IS NULL and IS NOT NULL
-- to check if a value is null or not null

--1. Find list of actors with missing birth date

SELECT 
	*
FROM 
	actors
WHERE
	date_of_birth IS NULL;

--2. --1. Find list of actors with missing birth date or missing first name
SELECT 
	*
FROM 
	actors
WHERE
	date_of_birth IS NULL OR 
	first_name IS NULL
ORDER BY
	first_name;

--3. Get list of movies where domestic revenue is null
SELECT
	*
FROM movies_revenues
WHERE
	revenues_domestic IS NULL;

--4. Get list of movies where domestic revenue OR international revenue is null
SELECT
	*
FROM movies_revenues
WHERE
	revenues_domestic IS NULL ORx
	revenues_international IS NULL
ORDER BY
	revenue_id;

--5. Get list of movies where domestic revenue is not null
SELECT
	*
FROM movies_revenues
WHERE
	revenues_domestic IS NOT NULL;


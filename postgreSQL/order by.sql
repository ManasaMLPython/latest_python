-- Using order by to sort records

-- Sort based on single column
--sort all movies records by their release date in ascending order

SELECT 
	* 
FROM movies
ORDER BY 
	release_date ASC;-- By default order by is ASC

--sort all movies records by their release date in descenfding order

SELECT
	*
FROM movies
ORDER BY
	release_date DESC;

-- Sort based on mutiple columns
-- Movie records with release date in desc and movie_name asc
SELECT
	*
FROM movies
ORDER BY
	release_date DESC,
	movie_name ASC;

-- postgreSQL order-- FROM, SELECT, ORDERBY

-- using order by with alias column name
-- get first_name last_name from actors table
SELECT 
	first_name, last_name
FROM actors;

-- make alias for last_name as surname
SELECT 
	first_name, last_name AS "Surname"
FROM actors

-- sort rows by last_name
SELECT 
	first_name, last_name AS Surname
FROM actors
ORDER BY Surname DESC;

--Use Order by to sort rows by expression
--1. all records of actors
SELECT * FROM actors;

--2. length of actor name with LENGTH function
SELECT 
	first_name, LENGTH(first_name)
FROM actors
ORDER BY
	LENGTH(first_name) DESC;

-- Using column name or column number in order by clause
--1. view all records of actors
SELECT * FROM actors;

--2. sort all records with first_name asc, date_of_birth desc

SELECT
	*
FROM actors
ORDER BY 
	first_name ASC,
	date_of_birth DESC;

-- 3. USE column number instead of name
SELECT
	first_name,
	last_name,
	date_of_birth
FROM actors
ORDER BY 
	1 ASC,
	3 DESC;
-- Use order by with NULL values : [NULL FIRST | NULL LAST]

SELECT 
	first_name, LENGTH(first_name)
FROM actors
ORDER BY
	LENGTH(first_name) NULLS LAST;

SELECT 
	first_name, LENGTH(first_name)
FROM actors
ORDER BY
	LENGTH(first_name) DESC NULLS FIRST;
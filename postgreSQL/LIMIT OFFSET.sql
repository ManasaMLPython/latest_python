-- LIMIT to limit output records

SELECT
	*
FROM movies
LIMIT 5;

--1. Get the top 5 biggest movies by movie length

SELECT
	*
FROM movies
ORDER BY
	movie_length DESC
LIMIT 5;

--
SELECT * FROM directors;
--2. Get the top 5 oldest american directors
SELECT
	*
FROM directors
WHERE
	nationality='American'
ORDER BY
	date_of_birth ASC
LIMIT 5;

--3. Get the top 10 youngest female actors
SELECT * FROM actors;

SELECT
	*
FROM actors
WHERE
	gender='F'
ORDER BY
	date_of_birth DESC
LIMIT 
	10;
-- 4. Get the top 10 most domestic profitable movies
SELECT * FROM movies_revenues;
SELECT
	*
FROM movies_revenues
ORDER BY 
	revenues_domestic DESC NULLS LAST
LIMIT 10

-- 5. Get the top 10 LEAST domestic profitable movies
SELECT * FROM movies_revenues;
SELECT
	*
FROM movies_revenues
ORDER BY 
	revenues_domestic ASC
LIMIT 10

-- OFFSET
-- 6. List 5 films starting from 4th one ordered by movie_id

SELECT * FROM movies;
SELECT
	*
FROM movies
LIMIT 5 OFFSET 4;

--7. List all top 5 movies after the top 5 highest domestic profits movies

SELECT
	*
FROM movies_revenues
ORDER BY
	revenues_domestic DESC NULLS LAST
LIMIT 5 OFFSET 6;

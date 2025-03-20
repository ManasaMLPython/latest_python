-- DISTINCT

--1. all records from movies
SELECT * FROM movies;

--2. Get movie_lang
SELECT
	movie_lang
FROM movies

--3. Get unique movie lang
SELECT 
	DISTINCT movie_lang
FROM movies
ORDER BY 
	1 ASC;

--4. Get unique director id
SELECT
	DISTINCT director_id
FROM movies
ORDER BY
	1;

--5. Multiple distinct values. unique movie_lang, director_id. Will return unique combinations of the given columns
SELECT
	DISTINCT movie_lang, director_id
FROM movies;

-- Get all unique records from movies table
SELECT 
	DISTINCT * 
FROM movies
ORDER BY
	movie_id ;

	
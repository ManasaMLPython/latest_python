-- OPERATORS
-- 1. Comparision Operators =, >, >=, <, <=, <>
-- 2. Logical : AND, OR, LIKE, IN, BETWEEN
-- 3. Arithmetic : +, -, *, /, %
-- Use where clause with operators to build complex queries

-- 1. Single condition
-- Get all english language movies
SELECT * FROM movies;
SELECT 
	* 
FROM movies
WHERE 
	movie_lang='English';

-- japanese lang movies
SELECT 
	* 
FROM movies
WHERE 
	movie_lang='Japanese';

-- Multiple conditions
-- English lang and age cert 18
SELECT
	*
FROM movies
WHERE 
	movie_lang='English' 
	AND age_certificate='18'
	;
-- English lang OR Chinese movies
SELECT
	*
FROM movies
WHERE
	movie_lang='English'
	OR movie_lang='Chinese'
ORDER BY
	movie_lang
	;
-- ALL English lang movies and directory id=8
SELECT
	*
FROM movies
WHERE
	movie_lang='English'
	And director_id=8;
-- Combining AND OR
-- Get all English OR Chinese movies AND age certi=12
SELECT
	*
FROM movies
WHERE
	(movie_lang='English'
	OR movie_lang='Chinese')
	AND age_certificate='12'
ORDER BY
	movie_lang
	;
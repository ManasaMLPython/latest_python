-- LOGICAL OPERATORS

SELECT * FROM movies;

-- 1. Get all movies where length>100
SELECT 
	* 
FROM movies
WHERE 
	movie_length>100
ORDER BY
	movie_length;

-- 2. Get all movies where length>=100
SELECT 
	* 
FROM movies
WHERE 
	movie_length>=100
ORDER BY
	movie_length;

-- 3. Get all movies where length<=100
SELECT 
	* 
FROM movies
WHERE 
	movie_length<=100
ORDER BY
	movie_length;

-- 4. Get all movies lang>english
SELECT 
	* 
FROM movies
WHERE 
	movie_lang>'English'
ORDER BY
	movie_lang;
-- 5. Get all movies lang<>english
SELECT 
	* 
FROM movies
WHERE 
	movie_lang<>'English'
ORDER BY
	movie_lang;

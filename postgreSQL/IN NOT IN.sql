--Using IN and NOT IN

--1. Get all movies for English, Chinese and Japanese languages
SELECT 
	*
FROM movies
WHERE
	movie_lang IN ('English', 'Chinese', 'Japanese')
ORDER BY
	movie_lang;

-- 2. Get all movies where age_certificate is 12 and PG type

SELECT 
	*
FROM movies
WHERE
	age_certificate IN ('12', 'PG')
ORDER BY
	movie_lang;

-- 3. Get all movies where director_id is not 13 or 10

SELECT 
	*
FROM movies
WHERE
	director_id NOT IN (13, 10)
ORDER BY
	director_id;
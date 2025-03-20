-- FETCH CLAUSE-same as LIMIT
/*
OFFSET start {ROW | ROWS} ONLY
FETCH {FIRST | NEXT}[row_count]{ROW | ROWS} ONLY
*/

-- 1. Get first row of movies table
SELECT 
	*
FROM movies
FETCH FIRST 5 ROWS ONLY;

-- 2. Get the top 5 biggest movies by movie length
SELECT
	*
FROM movies
ORDER BY
	movie_length DESC
FETCH FIRST 5 ROWS ONLY;

--3. Get the top 5 oldest american directors
SELECT
	*
FROM directors
ORDER BY
	date_of_birth
FETCH FIRST 5 ROWS ONLY;

--4. Get first 5 movies from the 5th record onwards  long movie length
SELECT 
	*
FROM movies
ORDER BY
	movie_length DESC
FETCH FIRST 5 ROWS ONLY
OFFSET 5;

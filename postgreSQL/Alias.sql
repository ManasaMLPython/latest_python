-- Adding alis to column name
SELECT * FROM movies;

-- movie_name as "Movie Name"
SELECT movie_name AS "Movie Name" FROM movies;

-- multiple alias

SELECT
	movie_name "Movie Name",
	movie_lang "Language"
FROM movies;

-- Assigning column alias to an expression
-- creating Full Name from first_name, last_name
SELECT * FROM actors;

SELECT 
	first_name||' '||last_name AS "Full Name"
FROM actors;

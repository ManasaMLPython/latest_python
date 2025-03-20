-- SELECT RECORDS FROM TABLE
-- Get all records from movies table

SELECT * FROM movies;

--actors table
SELECT * FROM actors;

-- select female actors
SELECT * FROM actors
WHERE gender='F';
---- select female actors and dob>1978-05-12

SELECT * FROM actors
WHERE gender='F' AND date_of_birth>'1978-05-12';

--Retrieve all ACTORS and sort them by DOB in ascending order and then by name in ascending order.
SELECT * FROM actors
ORDER BY date_of_birth ASC , first_name ASC

--Retrieve all actors and sort them by age in descending order.

SELECT * FROM actors
ORDER BY date_of_birth DESC;

-- first_name from actors table

SELECT first_name FROM actors;

-- first_name, last_name from actors table
SELECT first_name, last_name FROM actors;

--movie_name , movie_lang from movies
SELECT movie_name, movie_lang FROM movies;
-- Cncatenationt techniques
-- To concatenate 2 strings ||
--To combine columns CONCAT(c1,c2) AS new_string
-- with particular seperator-CONCAT_WS
-- CONCAT('|',c1,c2) AS new_string

-- combine 'Hello', 'World'
SELECT 'HELLO'||'WORLD' AS S;
SELECT CONCAT('HELLO'||'WORLD') AS S;
SELECT CONCAT_WS(' * ','HELLO','WORLD') AS S;

--1. Combine actor's first name and last name as Actor Name
SELECT
	CONCAT(first_name,last_name) AS "Actor Name"
FROM actors;

--2. Add seperator
SELECT
	CONCAT_WS(' ',first_name,last_name) AS "Actor Name"
FROM actors;
--3. Print first, last and dob of actors seperated by comma
SELECT
	CONCAT_WS(', ',first_name,last_name,date_of_birth) AS "Actor Details"
FROM actors;

-- when using || to concatenate strings it returns NULL fir null values where as concat function ignores null and returns
-- remaining

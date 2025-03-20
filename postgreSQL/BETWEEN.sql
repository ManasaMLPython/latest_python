-- Using BETWEEN and NOT BETWEEN
-- value BETWEEN low AND high

-- 1. Get all actors where birth_date is BETWEEN 1991 and 1995

SELECT
	*
FROM actors
WHERE
	date_of_birth BETWEEN '1991-01-01' AND '1995-01-01'
ORDER BY
	date_of_birth;

-- 2. Get all movies  released  BETWEEN 1998 and 2002

SELECT
	*
FROM movies
WHERE
	release_date BETWEEN '1998-01-01' AND '2002-01-01'
ORDER BY
	release_date;


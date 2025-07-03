-- show_id	type	title	director	cast	country	date_added	release_year	rating	duration	listed_in	description
DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix
(
show_id varchar(5),
type varchar(10),
title varchar(250),
director varchar(500),
casts varchar(1000),
country varchar(150),
date_added date,
release_year INT,
rating varchar(30),
duration INT,
listed_in varchar(150),
description varchar(550)
);
SELECT DISTINCT rating FROM netflix;

-- 1. Count the Number of Movies vs TV Shows
SELECT type, COUNT(*) AS total_count
FROM netflix
GROUP BY type;
--2. Find the Most Common Rating for Movies and TV Shows
WITH cte AS (
		SELECT type, rating, 
			   COUNT(*) AS total,
			   DENSE_RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS rnk
		FROM netflix
		GROUP BY 1,2
)
SELECT type,rating FROM cte
WHERE rnk=1;

--3. List All Movies Released in a Specific Year (e.g., 2020)
SELECT * FROM netflix
WHERE release_year = 2020;

--4. Find the Top 5 Countries with the Most Content on Netflix
WITH country_counts AS (
    SELECT country, COUNT(*) AS total_content
    FROM netflix
    WHERE country <> 'unknown'
    GROUP BY country
)
SELECT *
FROM country_counts
ORDER BY total_content DESC
LIMIT 5;

--5. Identify the Longest Movie
WITH longest_movies AS(
		SELECT *,
			   DENSE_RANK() OVER(ORDER BY duration DESC) AS rnk
		FROM netflix
		WHERE type='Movie'
)
SELECT show_id,type,title,director,casts,country,date_added,release_year,rating,duration,listed_in,description 
FROM longest_movies
WHERE rnk=1;

--6. Find Content Added in the Last 5 Years
SELECT * FROM netflix
WHERE date_added>= CURRENT_DATE - INTERVAL '5 YEARS';

--7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'
SELECT * FROM netflix
WHERE director iLIKE '%Rajiv Chilaka%';

-- List All TV Shows with More Than 5 Seasons
SELECT * FROM netflix
WHERE type = 'TV Show' and duration>5;

--9. Count the Number of Content Items in Each Genre

WITH genres AS (
  SELECT unnest(string_to_array(listed_in, ', ')) AS genre
  FROM netflix
)
SELECT genre, COUNT(*) 
FROM genres
GROUP BY genre
ORDER BY COUNT(*) DESC;

--10. Find Each Year and the Average Number of Content Releases in India on Netflix
WITH countries AS (
	SELECT unnest(string_to_array(country, ', ')) AS country,
	EXTRACT(YEAR FROM date_added) AS year
	FROM netflix
),
avg_content AS (
	SELECT country,year, COUNT(*) AS content_per_year
	FROM countries
	GROUP BY 1,2
)
SELECT country, ROUND(AVG(content_per_year)) AS avg_content_per_year
FROM avg_content
WHERE country iLIKE '%India%'
GROUP BY country
ORDER BY 2;

-- 11. List All Movies that are Documentaries
SELECT * FROM netflix
WHERE listed_in iLIKE '%Documentaries%' AND type = 'Movie';

--12. Find All Content Without a Director
SELECT * FROM netflix
WHERE director is null;

--13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
SELECT * 
FROM netflix
WHERE type='Movie' 
	AND release_year >= (EXTRACT(YEAR FROM CURRENT_DATE) - 10)
	AND casts iLIKE '%Salman Khan%';
--14. Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India
WITH countries AS (
	SELECT show_id,unnest(string_to_array(country, ', ')) AS country
	FROM netflix
	WHERE type = 'Movie'
),
actors AS(
	SELECT show_id,TRIM(unnest(string_to_array(casts, ', '))) AS actor
	FROM netflix
	WHERE type = 'Movie'
),
counts AS(
	SELECT actor, COUNT(*) AS num_of_movies
	FROM countries
	JOIN actors
	USING(show_id)
	WHERE country = 'India'
	GROUP BY actor
),
ranks AS(
	SELECT *,
		   DENSE_RANK() OVER(ORDER BY num_of_movies DESC) AS rnk
	FROM counts
)
SELECT actor, num_of_movies
FROM ranks
WHERE rnk<=10;

--15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords
SELECT *,
		CASE 
			WHEN description SIMILAR TO '%(kill|violence)%' THEN 'CRIME'
			ELSE 'OTHERS'
		END AS category
FROM netflix
ORDER BY category;
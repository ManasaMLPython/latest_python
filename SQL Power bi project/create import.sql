-- Delete the hr table if it already exists
DROP TABLE IF EXISTS hr;

-- Create the hr table with relevant employee details
CREATE TABLE hr (
    id varchar PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    birthdate DATE,
    gender TEXT,
    race TEXT,
    department TEXT,
    jobtitle TEXT,
    location TEXT,
    hire_date DATE,
    termdate DATE,
    location_city TEXT,
    location_state TEXT
);

SELECT * FROM hr;
-- Select all rows where termdate is set to '1900-01-01'
SELECT * FROM hr
WHERE termdate = '1900-01-01';

-- Rename column 'id' to 'emp_id' for clarity
ALTER TABLE HR
RENAME id TO emp_id;

-- View metadata about the hr table columns
SELECT 
    column_name, 
    data_type, 
    is_nullable, 
    column_default
FROM information_schema.columns
WHERE table_name = 'hr'
ORDER BY ordinal_position;

SELECT birthdate FROM hr;

-- Replace NULL values in termdate with '1900-01-01'
-- to indicate currently employed staff
UPDATE HR
SET termdate = '1900-01-01'
WHERE termdate IS NULL;

-- Adding age column
ALTER TABLE hr
ADD COLUMN age INTEGER;

-- Update values
UPDATE hr
SET age = EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate));

SELECT * FROM hr
WHERE age<18;
select count(*) from hr;
-- Questions
-- 1. What is the gender breakdown of employees in the company?

SELECT gender, COUNT(*), (COUNT(*)*100)/(select count(*) from hr) || '%' AS PERCENTAGE
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY gender
;

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT race, COUNT(*), (COUNT(*)*100)/(SELECT COUNT(*) FROM hr WHERE age >= 18 AND termdate = '1900-01-01') || '%' AS PERCENTAGE
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY race
ORDER BY COUNT(*) DESC
;

-- What is the age distribution of employees in the company?

WITH CTE AS
	(
		SELECT *, 
			CASE
				WHEN age>=18 ANd age<=24 THEN '18-24'
				WHEN age>=25 ANd age<=34 THEN '25-34'
				WHEN age>=35 ANd age<=44 THEN '35-44'
				WHEN age>=44 ANd age<=54 THEN '45-54'
				WHEN age>=55 ANd age<=64 THEN '55-64'
				ELSE '65+'
			END AS age_group
			FROM hr
			WHERE age>=18 AND termdate = '1900-01-01'
)
SELECT age_group, count(*) as total_emps, (count(*)*100)/(select count(*) from CTE) || '%' AS percentage 
FROM CTE
GROUP BY age_group
;

-- age group distributed among gender
WITH CTE AS
	(
		SELECT *, 
			CASE
				WHEN age>=18 ANd age<=24 THEN '18-24'
				WHEN age>=25 ANd age<=34 THEN '25-34'
				WHEN age>=35 ANd age<=44 THEN '35-44'
				WHEN age>=44 ANd age<=54 THEN '45-54'
				WHEN age>=55 ANd age<=64 THEN '55-64'
				ELSE '65+'
			END AS age_group
			FROM hr
			WHERE age>=18 AND termdate = '1900-01-01'
)
SELECT age_group,gender, count(*) as total_emps, (count(*)*100)/(select count(*) from CTE) || '%' AS percentage 
FROM CTE
GROUP BY age_group,gender
order by age_group,gender
;


-- 4. How many employees work at headquarters vs remote locations?

SELECT location, COUNT(*), (COUNT(*)*100)/(SELECT COUNT(*) FROM hr WHERE age >= 18 AND termdate = '1900-01-01') || '%' AS PERCENTAGE
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY location
;

-- 5. What is the average length of employment for employees who have been terminated?

select round(avg(extract(year from age(termdate ,hire_date)))) as exp from hr where termdate <> '1900-01-01' and termdate<=current_date

-- 6. How does the gender distribution vary across department and job titles?
-- Department
SELECT department, gender, ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY department), 2) || '%' AS PERCENTAGE
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY department, gender
ORDER BY department, gender
;

-- jobtitle
SELECT jobtitle, gender, ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY jobtitle), 2) || '%' AS PERCENTAGE
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY jobtitle, gender
ORDER BY jobtitle, gender
;

-- 7. What is the distribution of job title across the company?

SELECT jobtitle, COUNT(*),  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr WHERE age >= 18 AND termdate = '1900-01-01'), 2) AS PERCENTAGE
FROM hr
WHERE age>=18 AND termdate = '1900-01-01'
GROUP BY jobtitle
ORDER BY jobtitle desc;

-- 8. Which department has highest turnover rate
--Turnover rate is a metric that shows how frequently employees leave a particular group—such as a department—within a certain time frame
-- Turnover Rate = (Number of employees who left) ÷ (Total employees) × 100%
WITH CTE AS (
		SELECT department,
			   COUNT(*) AS total_emp,
			   SUM(
					CASE
						WHEN termdate<CURRENT_DATE AND termdate <> '1900-01-01' THEN 1
						ELSE 0
					END
			   ) AS total_left
		FROM hr
		WHERE age>=18
		GROUP BY department
)
SELECT department, total_emp, total_left,
	   ROUND(total_left::NUMERIC/total_emp,2) AS turnover_rate
FROM CTE
ORDER BY department;

-- 9. What is the distribution of employees accross locations by city and state?

-- Location state
select location_state, count(*) as total_count 
from hr
where age>=18 and termdate = '1900-01-01'
group by location_state
order by total_count desc;

--location city

select location_city, count(*) as total_count 
from hr
where age>=18 and termdate = '1900-01-01'
group by location_city
order by total_count desc;

-- 10 How has the company's employee count has changed over time based on hiredate and termdates?
WITH hire AS (
		SELECT EXTRACT(YEAR FROM hire_date) AS hire_year,count(*) AS total_hires
		FROM hr
		WHERE age>=18 
		GROUP BY EXTRACT(YEAR FROM hire_date)
		ORDER BY EXTRACT(YEAR FROM hire_date)
		),
term AS (
		SELECT EXTRACT(YEAR FROM termdate) AS term_year,count(*) AS total_term
		FROM hr
		WHERE age>=18  and termdate is not null and termdate<>'1900-01-01' and termdate<=CURRENT_DATE
		GROUP BY EXTRACT(YEAR FROM termdate)
		ORDER BY EXTRACT(YEAR FROM termdate)
)
SELECT 
    COALESCE(h.hire_year, t.term_year) AS year,
    COALESCE(total_hires, 0) AS hires,
    COALESCE(total_term, 0) AS terminations,
	COALESCE(total_hires, 0)-COALESCE(total_term, 0) as change,
	ROUND(((COALESCE(total_hires, 0) - COALESCE(total_term, 0))::numeric / COALESCE(total_hires, 1)) * 100, 2) AS percent
FROM hire h
FULL OUTER JOIN term t ON h.hire_year = t.term_year
ORDER BY year;

-- 11. What is the tenure distribution in each department

SELECT department, ROUND(AVG(EXTRACT(YEAR FROM AGE(termdate, hire_date)))::numeric, 2) AS avg_years
FROM hr
WHERE age>=18 and termdate<=current_date and termdate<>'1900-01-01'::DATE
GROUP BY department;
-- RECURSIVE CTE
WITH RECURSIVE Series(num) AS (
--anchor query
	 SELECT 1 
	 UNION ALL
--recursive query
	 SELECT num+1
	 FROM Series
-- stopping condition
	 WHERE num<20
)
SELECT * FROM Series;

WITH RECURSIVE Series(num,square) AS (
--anchor query
	 SELECT 1, 1*1
	 UNION ALL
--recursive query
	 SELECT num+1, (num+1)*(num+1)
	 FROM Series
-- stopping condition
	 WHERE num<20
)
SELECT * FROM Series;

-- generate dates
WITH RECURSIVE DATES(dt) AS(
	SELECT CURRENT_DATE, TO_CHAR(CURRENT_DATE, 'day')
	UNION ALL
	SELECT (dt + INTERVAL '1 DAY')::DATE, TO_CHAR(((dt + INTERVAL '1 DAY')::DATE), 'day')
	FROM DATES
	WHERE dt < CURRENT_DATE + INTERVAL '1 MONTH'
	)
SELECT * FROM DATES;

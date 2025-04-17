DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name TEXT,
    manager_id INT
);

INSERT INTO employees (emp_id, name, manager_id) VALUES
(1, 'CEO', NULL),
(2, 'CTO', 1),
(3, 'CFO', 1),
(4, 'Dev Manager', 2),
(5, 'Finance Manager', 3),
(6, 'Developer A', 4),
(7, 'Developer B', 4),
(8, 'Accountant', 5);

SELECT * FROM employees;
--  Basic Recursive CTE: Org Chart (Under CEO)

WITH RECURSIVE cte_org(emp_id,name, manager_id, LEVEL) AS (
	SELECT emp_id,name, manager_id, 1 AS LEVEL
	FROM employees
	WHERE manager_id IS NULL
	UNION ALL
	SELECT e.emp_id,e.name, e.manager_id, c.LEVEL+1
	FROM employees e
	JOIN cte_org c 
	ON c.emp_id=e.manager_id
)
SELECT * FROM cte_org;

-- Exercise 2: Subordinates of emp_id = 2 (CTO)
WITH RECURSIVE cte_org(emp_id,name, manager_id) AS (
	SELECT emp_id,name, manager_id
	FROM employees
	WHERE emp_id=2
	UNION ALL
	SELECT e.emp_id,e.name, e.manager_id
	FROM employees e
	JOIN cte_org c 
	ON c.emp_id=e.manager_id
)
SELECT * FROM cte_org;

--Exercise 3: Path from CEO to All Employees
WITH RECURSIVE cte_org(emp_id,name, manager_id, path) AS (
	SELECT emp_id,name, manager_id, name AS path
	FROM employees
	WHERE manager_id IS NULL
	UNION ALL
	SELECT e.emp_id,e.name, e.manager_id, c.path || '->' || e.name
	FROM employees e
	JOIN cte_org c 
	ON c.emp_id=e.manager_id
)
SELECT * FROM cte_org;

-- Exercise 4: Max Depth of the Hierarchy
WITH RECURSIVE cte_org(emp_id,name, manager_id, LEVEL) AS (
	SELECT emp_id,name, manager_id, 1 AS LEVEL
	FROM employees
	WHERE manager_id IS NULL
	UNION ALL
	SELECT e.emp_id,e.name, e.manager_id, c.LEVEL+1
	FROM employees e
	JOIN cte_org c 
	ON c.emp_id=e.manager_id
)
SELECT MAX(level) AS max_hierarchy_depth FROM cte_org;

-- Exercise 5: Number of Employees at Each Level
WITH RECURSIVE cte_org(emp_id,level) AS (
	SELECT emp_id, 1 AS level
	FROM employees
	WHERE manager_id IS NULL
	UNION ALL
	SELECT e.emp_id, c.level+1
	FROM employees e
	JOIN cte_org c
	ON c.emp_id=e.manager_id
)
SELECT level, COUNT(level) 
FROM cte_org
GROUP BY level
ORDER BY level;

--Exercise 6: Count Total Reports Under Each Manager
WITH RECURSIVE emp_tree AS (
    SELECT manager_id AS root_mgr, emp_id, manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
    UNION ALL
    SELECT et.root_mgr, e.emp_id, e.manager_id
    FROM employees e
    JOIN emp_tree et ON e.manager_id = et.emp_id
)
SELECT root_mgr AS manager_id, COUNT(*) AS total_reports
FROM emp_tree
GROUP BY root_mgr
ORDER BY total_reports DESC;

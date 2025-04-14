DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    manager_id INT
);

INSERT INTO employees (emp_id, name, department, salary, hire_date, manager_id) VALUES
(101, 'Alice',   'HR',      60000, '2018-03-15', 105),
(102, 'Bob',     'IT',      75000, '2019-07-21', 103),
(103, 'Charlie', 'IT',      90000, '2020-09-10', 107),
(104, 'David',   'Finance', 85000, '2017-05-18', 106),
(105, 'Eve',     'HR',      70000, '2016-11-30', 101),
(106, 'Frank',   'Finance', 72000, '2018-12-22', 104),
(107, 'Grace',   'IT',      95000, '2021-06-01', 103),
(108, 'Henry',   'HR',      62000, '2019-04-17', 105),
(109, 'Ivy',     'Finance', 68000, '2022-02-14', 106),
(110, 'Jack',    'IT',      78000, '2020-08-05', 103),
(111, 'Rack',    'IT',      88000, '2020-08-05', 103),
(112, 'MRack',    'IT',      85000, '2020-08-05', 103),
(113, 'Mankh',    'HR',      68000, '2020-08-05', 111),
(114, 'Crach',    'HR',      88000, '2020-08-05', 112),
(115, 'Drack',    'HR',      98000, '2020-08-05', 114),
(116, 'Mack',    'HR',      78000, '2020-08-05', 115),
(117, 'Hulk',    'IT',      98000, '2020-08-05', 105),
(118, 'Jackson',    'IT',      98000, '2020-08-05', 103);

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    emp_id INT,
    dept_name VARCHAR(50)
);

INSERT INTO departments (emp_id, dept_name) VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'IT'),
(104, 'Finance'),
(105, 'HR'),
(106, 'Finance'),
(107, 'IT'),
(108, 'HR');

-- Employees earning more than their department's average
SELECT name, salary, department
FROM employees e1
WHERE salary > (
				SELECT AVG(salary) FROM employees e2
				WHERE e1.department = e2.department
);
--  Find the second highest salary without LIMIT or TOP
SELECT name, salary
FROM employees
WHERE salary = (
				SELECT MAX(salary)
				FROM employees
				WHERE salary<(
							  SELECT MAX(salary) FROM employees
				)
);
-- Employees not assigned to any department
SELECT name
FROM employees
WHERE emp_id NOT IN (
				SELECT EMP_ID FROM departments
				);
-- Employees who earn more than their manager
SELECT e1.name, e1.salary
FROM employees e1
WHERE e1.salary > (
    SELECT e2.salary
    FROM employees e2
    WHERE e2.emp_id = e1.manager_id
);
-- Departments where more than 2 employees earn above department average
SELECT department
FROM employees e1
WHERE salary > (
				SELECT AVG(salary) FROM employees e2
				WHERE e1.department = e2.department
)
GROUP BY department
HAVING COUNT(*)>2;
-- Department with the highest average salary
SELECT department
FROM employees
GROUP BY department
HAVING AVG(salary)=(
			SELECT MAX(avg_salary)
			FROM (
				SELECT department, AVG(salary) AS avg_salary
				FROM employees
				GROUP BY department
			)AS avgs
);
--  Employees earning the most under each manager
SELECT name, manager_id, salary
FROM employees
WHERE (manager_id,salary) IN (
		SELECT manager_id,MAX(salary)
		FROM employees
		GROUP BY manager_id
		ORDER BY manager_iD
		)
ORDER BY manager_iD;


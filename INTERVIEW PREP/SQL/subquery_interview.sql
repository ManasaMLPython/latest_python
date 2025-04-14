DROP TABLE IF EXISTS employees;
-- Create the employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    manager_id INT
);

-- Insert sample data
INSERT INTO employees (emp_id, name, department, salary, hire_date, manager_id) VALUES
(101, 'Alice', 'HR', 60000, '2018-03-15', 201),
(102, 'Bob', 'IT', 75000, '2019-07-21', 202),
(103, 'Charlie', 'IT', 90000, '2020-09-10', 202),
(104, 'David', 'Finance', 85000, '2017-05-18', 203),
(105, 'Eve', 'HR', 70000, '2016-11-30', 201),
(106, 'Frank', 'Finance', 72000, '2018-12-22', 203),
(107, 'Grace', 'IT', 95000, '2021-06-01', 202),
(108, 'Henry', 'HR', 62000, '2019-04-17', 201),
(109, 'Ivy', 'Finance', 68000, '2022-02-14', 203),
(110, 'Jack', 'IT', 78000, '2020-08-05', 202);

--  Correlated Subquery: Top Earners Per Department
SELECT name, salary, department
FROM employees e1
WHERE salary > (
			SELECT AVG(salary)
			FROM employees e2
			WHERE e2.department = e1.department		
);
--  Second Highest Salary (Without LIMIT or RANK)
SELECT name,salary
FROM employees
WHERE salary=(SELECT MAX(salary) FROM employees
			  WHERE salary<(
							SELECT MAX(salary) FROM employees
			  )
			  );
--Retrieve the names of employees who earn more than the average salary
SELECT name
FROM employees
WHERE salary > (
			SELECT AVG(salary) FROM employees
);

-- Find employees who were hired before the oldest IT employee.
SELECT name
FROM employees
WHERE hire_date<(
			SELECT MIN(hire_date) FROM employees
			WHERE department='IT'
);

-- Get the highest-paid employee in each department.
SELECT name, department, salary
FROM employees
WHERE salary IN (
			SELECT MAX(salary) FROM employees
			GROUP BY department
); 

-- List employees whose salary is greater than any HR employee.
SELECT name, salary
FROM employees
WHERE salary > ANY(
			SELECT salary FROM employees
			WHERE department='HR'
);

-- Find the employees who have the same manager as 'Bob'.
SELECT name 
FROM employees
WHERE manager_id = (
			SELECT manager_id FROM employees
			WHERE name='Bob'
);

-- Get departments where the average salary is above 75,000.
SELECT department
FROM employees
WHERE salary > (
			SELECT AVG(salary) FROM employees
);

-- Write a query to get employees who earn more than the average salary in their own department.

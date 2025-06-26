-- Drop tables if they exist
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Departments table
CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Employees table
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    salary NUMERIC,
    hire_date DATE,
    dept_id INTEGER REFERENCES departments(dept_id),
    manager_id INTEGER
);

-- Insert departments
INSERT INTO departments (dept_name) VALUES
('Engineering'),
('HR'),
('Sales'),
('Marketing');

-- Insert employees
INSERT INTO employees (name, salary, hire_date, dept_id, manager_id) VALUES
('Alice', 90000, '2021-03-15', 1, NULL),         -- Manager of Engineering
('Bob', 75000, '2022-06-01', 1, 1),
('Charlie', 70000, '2023-01-10', 1, 1),
('Diana', 60000, '2023-05-20', 2, NULL),         -- Manager of HR
('Eva', 50000, '2024-02-17', 2, 4),
('Frank', 80000, '2023-03-30', 3, NULL),         -- Manager of Sales
('Grace', 55000, '2024-05-10', 3, 6),
('Helen', 85000, '2024-06-15', 4, NULL),         -- Manager of Marketing
('Ivy', 62000, '2025-01-05', 4, 8);

-- Query 1: Average Salary by Department
SELECT *FROM departments;
SELECT * FROM employees ORDER BY salary DESC;

SELECT d.dept_name, ROUND(AVG(e.salary),2)
FROM employees e
JOIN departments d
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

--Query 2: Employee’s Name with Their Manager’s Name
SELECT e1.name AS emp, COALESCE(e2.name,'--') AS manager
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id=e2.emp_id;

--Query 3: Most Recent Hire in Each Department

SELECT DISTINCT ON (d.dept_name)
    d.dept_name,
    e.name AS employee_name,
    e.hire_date
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_name, e.hire_date DESC;

--Query 4: Nth Highest Salary (e.g., 3rd highest)
WITH cte AS(
		SELECT name, salary,
		DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
		FROM employees
		)
SELECT name, salary FROM cte
WHERE rnk=3;

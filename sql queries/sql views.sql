CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

INSERT INTO employees (emp_id, name, department, salary, hire_date) VALUES
(1, 'Alice', 'HR', 60000, '2020-01-15'),
(2, 'Bob', 'IT', 75000, '2019-03-22'),
(3, 'Carol', 'Finance', 82000, '2021-06-30'),
(4, 'Dave', 'IT', 78000, '2018-11-12'),
(5, 'Eva', 'HR', 62000, '2022-05-05');

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    department VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments (dept_id, department, location) VALUES
(1, 'HR', 'New York'),
(2, 'IT', 'San Diego'),
(3, 'Finance', 'Chicago');

select * from departments;

select * from employees;

-- Create a view that shows only employees in the IT department.
CREATE VIEW emp_it AS(
	SELECT * FROM employees
	WHERE department='IT'
);

SELECT * FROM emp_it;
-- Create a view showing employee name, department, and department location.
CREATE VIEW emp_details AS(
	SELECT e.name, e.department, d.location
	FROM employees e
	JOIN departments d
	ON e.department=d.department
	);
SELECT * FROM emp_details;

--Drop a view safely if it exists.
DROP VIEW IF EXISTS emp_it;

--Create a view that only shows HR employees hired after Jan 1, 2021.
CREATE VIEW emp_hr AS(
	SELECT * FROM employees
	WHERE department='HR' AND hire_date>'2021-01-01'
);
SELECT * FROM emp_hr;

--How do you check all views in your database (PostgreSQL)?
SELECT table_name
FROM information_schema.views
WHERE table_schema = 'public';

--Create a view that shows the total salary paid per department.
create view department_salary_summary as (
	SELECT department, sum(salary) as total_salary
	from employees
	group by department
);
select * from department_salary_summary;
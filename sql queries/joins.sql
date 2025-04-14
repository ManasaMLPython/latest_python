-- Creating the Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Inserting sample data into Departments
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

-- Creating the Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2)
);

-- Inserting sample data into Employees
INSERT INTO Employees (employee_id, employee_name, department_id, salary) VALUES
(101, 'Alice', 1, 60000),
(102, 'Bob', 2, 75000),
(103, 'Charlie', 3, 50000),
(104, 'David', NULL, 65000),
(105, 'Eve', 2, 70000);


SELECT * FROM departments

SELECT * FROM employees

-- Inner join
SELECT *
FROM employees e
INNER JOIN departments d
ON e.department_id=d.department_id

-- Left join

SELECT *
FROM employees e
LEFT JOIN departments d
ON e.department_id=d.department_id

-- Right join

SELECT *
FROM employees e
RIGHT JOIN departments d
ON e.department_id=d.department_id

-- Left join excluding
SELECT *
FROM employees e
LEFT JOIN departments d
ON e.department_id=d.department_id
WHERE d.department_id IS NULL

-- Right join excluding
SELECT *
FROM employees e
RIGHT JOIN departments d
ON e.department_id=d.department_id
WHERE d.department_id IS NULL

-- Cross join
SELECT *
FROM Employees e
CROSS JOIN Departments d;

-- Self join
SELECT *
FROM Employees e1
JOIN Employees e2
ON e1.employee_id=e2.employee_id

-- STRING_AGG() combines string column values as a string with given delimeter

SELECT STRING_AGG(employee_name,' * ')
FROM Employees

SELECT * FROM Employees

SELECT * FROM Employees
ORDER BY
	CASE
		WHEN department_id=2 THEN salary
		ELSE NULL
	END DESC

-- CONCAT
SELECT CONCAT_WS(' ',employee_id) as c from employees

-- POSITION
SELECT POSITION('i' IN employee_name) as ind from employees

--TRIM
SELECT TRIM(' ' FROM employee_name) as t FROM Employees

-- LOWER UPPER
SELECT LOWER(employee_name), UPPER(employee_name) FROM Employees

-- LEFT
SELECT LEFT(employee_name,3) FROM Employees

-- RIGHT
SELECT RIGHT(employee_name,3) FROM Employees

-- REVERSE
SELECT REVERSE(employee_name) FROM Employees

-- ASCII
SELECT ASCII(employee_name) FROM Employees

-- REGEXP_REPLACE
SELECT REGEXP_REPLACE(employee_name, '[aeiou]','*') FROM Employees


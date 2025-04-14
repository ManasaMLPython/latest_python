CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    HireDate DATE
);


INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Alice', 'HR', 50000, '2020-05-10'),
(2, 'Bob', 'IT', 62000, '2018-03-15'),
(3, 'Charlie', 'IT', 60000, '2019-06-20'),
(4, 'David', 'HR', 52000, '2021-07-30'),
(5, 'Eve', 'IT', 55000, '2022-01-10'),
(6, 'Frank', 'Sales', 48000, '2017-09-25'),
(7, 'Grace', 'Sales', 53000, '2018-11-05'),
(8, 'Hank', 'HR', 51000, '2019-02-14'),
(9, 'Ivy', 'IT', 59000, '2020-10-18'),
(10, 'Jack', 'Sales', 52000, '2021-12-01')
;

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(11, 'Helsi', 'HR', 51000,'2021-12-02');


SELECT Name, Department, Salary,
	   ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RowNum,
	   RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Rank,
	   DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DenseRank
FROM Employees;


-- RUNNING TOTAL
SELECT name, department, salary,
	SUM(salary) OVER (PARTITION BY department ORDER BY salary) AS sal_sum
FROM Employees;

-- RUNNING AVERAGE
SELECT name, department, salary,
	ROUND(AVG(salary) OVER (PARTITION BY department ORDER BY salary),2) AS sal_sum
FROM Employees;

SELECT name, department, salary,
	ROUND(AVG(salary) OVER (PARTITION BY department ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS sal_sum
FROM Employees;

-- COUNT
SELECT name, department, salary,
	COUNT(salary) OVER (PARTITION BY department ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS COUNTS
FROM Employees;

-- MIN 
-- This gives minimum in the partition
SELECT name, department, salary,
	MIN(salary) OVER (PARTITION BY department) AS minimum
FROM Employees;

-- MAX
SELECT name, department, salary,
	MAX(salary) OVER (PARTITION BY department ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS MAXI
FROM Employees;

-- LAG
SELECT name, department, salary,
	LAG(salary) OVER (PARTITION BY department ORDER BY salary) AS lag_salary
FROM Employees;

-- LEAD
SELECT name, department, salary,
LEAD(salary) OVER (PARTITION BY department ORDER BY salary) AS lead_salary
FROM Employees;

-- FIRST_VALUE()
SELECT name, department, salary,
	FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS first_value
FROM Employees;

-- LAST_VALUE()
SELECT name, department, salary,
	LAST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_value
FROM Employees;
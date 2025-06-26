DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary NUMERIC
);

INSERT INTO employees (emp_id, emp_name, salary) VALUES
(1, 'Alice', 90000),
(2, 'Bob', 60000),
(3, 'Charlie', 120000),
(4, 'Diana', 90000),
(5, 'Eve', 75000);

-- Find the nth highest salary from an employee table, where n is a parameter passed dynamically to the query.
PREPARE nth_salary(INT) AS
WITH cte AS(
		SELECT emp_id, emp_name, salary,
			   DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
		FROM employees
)
SELECT DISTINCT salary AS 
FROM cte
WHERE rnk=$1;

EXECUTE nth_salary(2);

DEALLOCATE nth_salary;
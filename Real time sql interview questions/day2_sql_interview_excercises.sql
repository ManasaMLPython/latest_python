DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT,
    emp_name TEXT,
    department TEXT,
    salary INT
);

INSERT INTO employees VALUES
(1, 'Alice',   'Engineering', 90000),
(2, 'Bob',     'Engineering', 95000),
(3, 'Charlie', 'Engineering', 95000),
(4, 'David',   'HR',          60000),
(5, 'Eva',     'HR',          58000),
(6, 'Frank',   'Marketing',   72000),
(7, 'Grace',   'Marketing',   75000),
(8, 'Helen',   'Marketing',   75000);

--  1. Identify Employees with Highest Salary in Each Department
-- with sub query
select emp_name, department, salary
from employees e1
where salary = (
				select max(salary) from employees e2
				where e1.department = e2.department
)

-- 2. with dense_rank
with cte as(
			select *,
			dense_rank() over(partition by department order by salary desc) as rank
			from employees
)
select emp_name, department, salary
from cte
where rank =1;
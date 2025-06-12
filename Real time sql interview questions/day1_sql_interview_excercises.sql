drop table if exists employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    manager_id INT
);
INSERT INTO employees (emp_id, emp_name, department, salary, hire_date, manager_id) VALUES
(101, 'Alice', 'Sales', 60000, '2015-03-01', 201),
(102, 'Bob', 'Sales', 58000, '2016-07-23', 201),
(103, 'Charlie', 'IT', 97000, '2017-01-15', 202),
(104, 'David', 'HR', 50000, '2018-10-30', 203),
(105, 'Eva', 'IT', 88000, '2016-04-25', 202),
(106, 'Frank', 'Sales', 62000, '2019-06-20', 201),
(201, 'Grace', 'Sales', 95000, '2010-01-01', NULL),
(202, 'Hannah', 'IT', 99000, '2009-05-14', NULL),
(203, 'Ian', 'HR', 88000, '2011-11-11', NULL);

select * from employees
order by department, salary desc;
;
-- Find the average salary of employees in each department, but only include departments where the average salary is greater than 60,000. 
-- Sort by average salary descending."
SELECT department, round(avg(salary)) from employees
group by department
having avg(salary)>60000
order by avg(salary) desc;

-- 2. Find the names of employees who earn more than their department's average salary.

with bb as(
		SELECT department, avg(salary) as avg_salary from employees
		group by department
)
select emp_name,employees.department, salary, avg_salary from employees
join bb 
on employees.department=bb.department
where salary>avg_salary;

-- 3. For each employee, show their name, department, salary, and the average salary of their department (in the same row), using a window function.
select emp_name, department, salary,
	   round(avg(salary) over(partition by department)) as avg_sala
from employees;

-- 4. "Write a query to find the top 2 highest-paid employees in each department."
with cte as(
		select emp_name, department, salary,
			   dense_rank() over(partition by department order by salary desc) as rank
		from employees
)
select emp_name, department, salary
from cte
where rank<=2;

-- 5. Find the names of employees who earn more than the average salary of all employees hired before them. Ignore employees who were hired first."

-- Update Eva's salary from 75000 → 88000
UPDATE employees
SET salary = 88000
WHERE emp_name = 'Eva';

-- Update Charlie's salary from 72000 → 97000
UPDATE employees
SET salary = 97000
WHERE emp_name = 'Charlie';


select emp_name, salary from employees e1
where salary >
			(
				select avg(salary) from employees e2
				where e1.hire_date>e2.hire_date
			);


-- 6. Find all departments where the second highest salary is greater than 70,000."

select department, salary
from employees 
where salary>70000 
group by department, salary Order by salary Desc ;

with cte as(
		select emp_name, department, salary,
			   rank() over(partition by department order by salary desc) as rank
		from employees
)
select department from cte where rank=2 and salary>70000;






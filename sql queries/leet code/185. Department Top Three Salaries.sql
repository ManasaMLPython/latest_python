CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO Department (id, name) VALUES
(1, 'IT'),
(2, 'Sales');

CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department(id)
);

INSERT INTO Employee (id, name, salary, departmentId) VALUES
(1, 'Joe', 85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam', 60000, 2),
(4, 'Max', 90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will', 70000, 1);

SELECT * FROM Department;
SELECT * FROM Employee;

WITH cte AS (
		SELECT d.name AS Department , e.name AS Employee , e.salary,
		DENSE_RANK() OVER(PARTITION BY d.name ORDER BY e.salary DESC) AS rank
		FROM Employee e
		JOIN Department d
		ON d.id=e.departmentid
	)
SELECT * FROM cte
WHERE rank<=3
ORDER BY department;
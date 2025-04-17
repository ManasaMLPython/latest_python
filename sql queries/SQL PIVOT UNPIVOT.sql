DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales (
    product_id INT,
    product_name VARCHAR(50),
    month VARCHAR(10),
    revenue INT
);

INSERT INTO Sales VALUES
(1, 'Laptop', 'Jan', 1500),
(1, 'Laptop', 'Feb', 1800),
(2, 'Phone', 'Jan', 800),
(2, 'Phone', 'Feb', 900),
(3, 'Tablet', 'Jan', 600),
(3, 'Tablet', 'Feb', 650);
DROP TABLE IF EXISTS MonthlySales;
CREATE TABLE MonthlySales (
    salesperson VARCHAR(50),
    Jan INT,
    Feb INT,
    Mar INT
);

INSERT INTO MonthlySales VALUES
('Alice', 1500, 1800, 1700),
('Bob', 1200, 1300, 1400);

SELECT * FROM Sales;
--Write a query to pivot the Sales table so that each product's revenue is displayed in columns for each month (Jan, Feb, etc.)
SELECT product_name,
	   SUM(revenue) FILTER(WHERE month='Jan') AS Jan_revenue,
	   SUM(revenue) FILTER(WHERE month='Feb') AS Feb_revenue
FROM Sales
GROUP BY 1
ORDER BY 1;

SELECT * FROM MonthlySales;
-- 2. Unpivot: Write a query to unpivot the MonthlySales table so that you return salesperson, month, and revenue.
SELECT salesperson,'jan' AS Month, jan AS Amount FROM MonthlySales
UNION ALL
SELECT salesperson,'feb' AS Month, feb AS Amount FROM MonthlySales
UNION ALL
SELECT salesperson,'mar' AS Month, mar AS Amount FROM MonthlySales
ORDER BY 1
;

DROP TABLE IF EXISTS EmployeePerformance;
CREATE TABLE EmployeePerformance (
    employee_id INT,
    employee_name VARCHAR(50),
    quarter VARCHAR(10),
    performance_score INT
);

INSERT INTO EmployeePerformance VALUES
(1, 'Alice', 'Q1', 80),
(1, 'Alice', 'Q2', 85),
(2, 'Bob', 'Q1', 75),
(2, 'Bob', 'Q2', 90),
(3, 'Charlie', 'Q1', 95),
(3, 'Charlie', 'Q2', 92);

SELECT * FROM EmployeePerformance;
--Write a query to pivot the EmployeePerformance table and show each employee's performance score by quarter (Q1, Q2, etc.)
SELECT employee_name,
	   SUM(performance_score) FILTER(WHERE quarter='Q1') AS Q1,
	   SUM(performance_score) FILTER(WHERE quarter='Q2') AS Q2
FROM EmployeePerformance
GROUP BY 1;

DROP TABLE IF EXISTS CustomerPurchases;
CREATE TABLE CustomerPurchases (
    customer_id INT,
    customer_name VARCHAR(50),
    Jan INT,
    Feb INT,
    Mar INT
);

INSERT INTO CustomerPurchases VALUES
(1, 'Alice', 200, 250, 300),
(2, 'Bob', 150, 180, 210);

SELECT * FROM CustomerPurchases;

--Write a query to unpivot the CustomerPurchases table so that you return customer_id, customer_name, month, and purchase_amount.
SELECT customer_id,customer_name,'jan' AS month, jan AS purchase_amount FROM CustomerPurchases
UNION ALL
SELECT customer_id,customer_name,'feb' AS month, feb AS purchase_amount FROM CustomerPurchases
UNION ALL
SELECT customer_id,customer_name,'mar' AS month, mar AS purchase_amount FROM CustomerPurchases
ORDER BY 1;

	   
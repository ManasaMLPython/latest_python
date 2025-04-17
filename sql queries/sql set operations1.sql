
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    customer_id INT,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Los Angeles'),
(3, 'Charlie', 'Chicago'),
(4, 'David', 'Houston'),
(5, 'Eve', 'Seattle');

DROP TABLE IF EXISTS Suppliers;
CREATE TABLE Suppliers (
    supplier_id INT,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO Suppliers VALUES
(101, 'Global Inc', 'Chicago'),
(102, 'TechMart', 'Houston'),
(103, 'RetailPro', 'Phoenix'),
(104, 'Alice', 'New York'),
(105, 'FreshCart', 'Austin');

--Q1. Find all unique cities from both Customers and Suppliers.
SELECT city FROM Customers
UNION
SELECT city FROM Suppliers;
--Q2. Find all cities from both tables (including duplicates).
SELECT city FROM Customers
UNION ALL
SELECT city FROM Suppliers;
--Q3. Find cities that are common to both Customers and Suppliers.
SELECT city FROM Customers
INTERSECT
SELECT city FROM Suppliers;
--Q4. List cities that appear in Customers but not in Suppliers.
SELECT city FROM Customers
EXCEPT
SELECT city FROM Suppliers;
--Q5 Which customer and supplier have the same name?
SELECT name FROM Customers
INTERSECT
SELECT name FROM Suppliers;
--Q6. Find all distinct names that exist in either table but not both.
(SELECT name FROM Customers
EXCEPT
SELECT name FROM Suppliers)
UNION
(SELECT name FROM Suppliers
EXCEPT
SELECT name FROM Customers )
ORDER BY name;
--Q7 Get the city names that appear more than once across both tables.
WITH CTE AS (
	SELECT city FROM Customers
	UNION ALL
	SELECT city FROM Suppliers
	)
SELECT city FROM CTE
GROUP BY city
HAVING COUNT(*)>1;


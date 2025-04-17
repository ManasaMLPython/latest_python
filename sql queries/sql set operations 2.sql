DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    customer_id INT,
    name VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');
DROP TABLE IF EXISTS Suppliers;
CREATE TABLE Suppliers (
    supplier_id INT,
    name VARCHAR(50)
);

INSERT INTO Suppliers VALUES
(101, 'TechMart'),
(102, 'FreshFoods'),
(103, 'Global Inc'),
(2, 'Bob');  -- Bob is both customer and supplier

DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    product_id INT,
    name VARCHAR(50),
    price INT
);

INSERT INTO Products VALUES
(1, 'Laptop', 1200),
(2, 'Phone', 800),
(3, 'Tablet', 500),
(4, 'Monitor', 300);
INSERT INTO Products VALUES
(5, 'Smartwatch', 400);  -- Not ordered

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO Orders VALUES
(1001, 1, 1, 1),
(1002, 1, 2, 2),
(1003, 2, 3, 1),
(1004, 4, 4, 1);
--Q1. List names that appear in both Customers and Suppliers.
SELECT name FROM Customers
INTERSECT
SELECT name FROM Suppliers;
--Q2. Get names that are in either Customers or Suppliers, but not both.
(SELECT name FROM Customers
EXCEPT
SELECT name FROM Suppliers)
UNION
(SELECT name FROM Suppliers
EXCEPT
SELECT name FROM Customers )
ORDER BY name;
--Q3 Get all products that were never ordered.
WITH not_ordered AS (
	SELECT product_id FROM Products
	EXCEPT
	SELECT product_id FROM Orders
	)
SELECT name FROM Products
WHERE product_id IN (SELECT * FROM not_ordered)
;
-- Q4  Get customers who have not placed any order.
WITH not_ordered AS (
	SELECT customer_id FROM Customers
	EXCEPT
	SELECT customer_id FROM Orders
	)
SELECT name FROM Customers
WHERE customer_id IN (SELECT * FROM not_ordered)
;


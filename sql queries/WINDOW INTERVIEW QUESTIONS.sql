DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    SaleDate DATE NOT NULL,
    Product VARCHAR(50) NOT NULL,
    Category VARCHAR(50),
    Amount INT NOT NULL
);

INSERT INTO Sales (SaleDate, Product, Category, Amount) VALUES
-- January Sales
('2024-01-02', 'Laptop', 'Electronics', 1500),
('2024-01-05', 'Phone', 'Electronics', 800),
('2024-01-07', 'TV', 'Electronics', 1200),
('2024-01-12', 'Headphones', 'Accessories', 200),
('2024-01-15', 'Tablet', 'Electronics', 900),
('2024-01-20', 'Phone', 'Electronics', 850),
('2024-01-25', 'TV', 'Electronics', 1300),
-- February Sales
('2024-02-03', 'Laptop', 'Electronics', 1400),
('2024-02-06', 'Phone', 'Electronics', 950),
('2024-02-10', 'TV', 'Electronics', 1100),
('2024-02-15', 'Headphones', 'Accessories', 220),
('2024-02-18', 'Tablet', 'Electronics', 870),
('2024-02-25', 'Phone', 'Electronics', 920),
('2024-02-28', 'TV', 'Electronics', 1250),
-- March Sales
('2024-03-05', 'Laptop', 'Electronics', 1600),
('2024-03-08', 'Phone', 'Electronics', 970),
('2024-03-12', 'TV', 'Electronics', 1400),
('2024-03-18', 'Headphones', 'Accessories', 250),
('2024-03-22', 'Tablet', 'Electronics', 990),
('2024-03-25', 'Phone', 'Electronics', 930),
('2024-03-30', 'TV', 'Electronics', 1350),
-- April Sales
('2024-04-02', 'Laptop', 'Electronics', 1700),
('2024-04-06', 'Phone', 'Electronics', 990),
('2024-04-10', 'TV', 'Electronics', 1450),
('2024-04-15', 'Headphones', 'Accessories', 270),
('2024-04-20', 'Tablet', 'Electronics', 1010),
('2024-04-22', 'Phone', 'Electronics', 940),
('2024-04-28', 'TV', 'Electronics', 1380);


SELECT * FROM SALES;

-- 1️⃣ Find Total Revenue Per Month with Running Total
SELECT TO_CHAR(saledate, 'YYYY-MM') AS Month, 
	   SUM(Amount) AS Total_revenue,
	   SUM(SUM(Amount)) OVER (ORDER BY TO_CHAR(saledate, 'YYYY-MM')) AS running
FROM Sales
GROUP BY TO_CHAR(saledate, 'YYYY-MM');

-- 2️⃣ Find the Top-Selling Product Each Month

WITH TOPS AS(
	   SELECT TO_CHAR(saledate, 'YYYY-MM') AS Month, product,
	   SUM(Amount) AS Total_sales,
	   RANK() OVER (PARTITION BY TO_CHAR(saledate, 'YYYY-MM')ORDER BY SUM(amount) DESC) AS rank
	   FROM Sales
	   GROUP BY month, product
	   )
SELECT Month, product, Total_sales
FROM TOPS
WHERE rank=1;

-- 3️⃣ Compare Each Product’s Current Month Sales with the Previous Month
WITH totalProductSalesMonthly AS
	(
	   SELECT TO_CHAR(saledate, 'YYYY-MM') AS Month, product,
	   SUM(Amount) AS Total_sales
	   FROM Sales
	   Group by Month, product
	)
SELECT month, product, total_sales,
	   lag(total_sales) OVER(PARTITION BY product ORDER BY month) AS previous_month_sales,
	   (total_sales-lag(total_sales) OVER(PARTITION BY product ORDER BY month)) AS sales_difference
FROM totalProductSalesMonthly
ORDER BY month;

-- 4️⃣ Identify the Top 2 Months with the Highest Revenue
WITH totalRevenues AS (
		SELECT TO_CHAR(SaleDate, 'YYYY-MM') AS month,
			   SUM(amount) AS revenue,
			   RANK() OVER(ORDER BY SUM(amount) DESC) AS rank
 		FROM Sales
		GROUP BY month
)
SELECT month, revenue
FROM totalRevenues
WHERE rank in (1,2);

-- 5.  Find the Top 3 Best-Selling Products Each Month


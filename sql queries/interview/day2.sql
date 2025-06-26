DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    category VARCHAR(50),
    sale_date DATE,
    revenue DECIMAL(10,2)
);

INSERT INTO sales (sale_id, product_id, category, sale_date, revenue) VALUES
(1, 101, 'Electronics', '2024-01-05', 100.00),
(2, 102, 'Electronics', '2024-01-20', 200.00),
(3, 103, 'Furniture',   '2024-01-25', 150.00),
(4, 104, 'Electronics', '2024-02-10', 300.00),
(5, 105, 'Furniture',   '2024-02-15', 100.00),
(6, 106, 'Furniture',   '2024-03-01', 200.00),
(7, 107, 'Clothing',    '2024-03-10', 180.00),
(8, 108, 'Clothing',    '2024-03-20', 120.00),
(9, 109, 'Electronics', '2024-03-25', 400.00),
(10, 110, 'Furniture',  '2024-04-01', 250.00);

-- Write a query to find the cumulative revenue by month for each product category in a sales table.
SELECT category, DATE_TRUNC('MONTH',sale_date)::DATE AS sale_month,SUM(revenue) AS total_revenue,
	   SUM(SUM(revenue)) OVER(PARTITION BY category ORDER BY DATE_TRUNC('MONTH', sale_date)::DATE) AS cum_revenue
FROM sales
GROUP BY category, DATE_TRUNC('MONTH',sale_date)::DATE
ORDER BY category, DATE_TRUNC('MONTH',sale_date)::DATE;
















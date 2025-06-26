DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);
INSERT INTO products (product_id, product_name) VALUES
(1, 'Laptop'),
(2, 'Desk'),
(3, 'Chair'),
(4, 'Monitor'),
(5, 'Mouse'),
(6, 'Keyboard'),
(7, 'Webcam'),
(8, 'Notebook');

DROP TABLE IF EXISTS sales ;
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    sale_date DATE,
    quantity_sold INT
);

INSERT INTO sales (sale_id, product_id, sale_date, quantity_sold) VALUES
-- Product 1: Laptop (recent + past)
(1, 1, '2024-06-10', 20),
(2, 1, '2024-05-15', 30),
(3, 1, '2024-03-01', 10),
-- Product 2: Desk (recent)
(4, 2, '2024-05-20', 25),
(5, 2, '2024-06-01', 15),
-- Product 3: Chair (old, not recent)
(6, 3, '2024-01-10', 50),
-- Product 4: Monitor (recent)
(7, 4, '2024-04-10', 40),
(8, 4, '2024-06-20', 20),
-- Product 5: Mouse (recent)
(9, 5, '2024-05-01', 10),
(10, 5, '2024-06-05', 10),
-- Product 6: Keyboard (recent)
(11, 6, '2024-04-25', 15),
-- Product 7: Webcam (zero sales in past 3 months)
(12, 7, '2024-02-15', 5);
--  2. How would you retrieve the top 5 products by sales volume, excluding any products that had zero sales in the past 3 months?
SELECT p.product_name, sum(s.quantity_sold) as volume
FROM sales s
JOIN products p
ON p.product_id=s.product_id
WHERE  s.product_id IN (
			SELECT s2.product_id FROM sales s2
			WHERE s.product_id=s2.product_id AND
				  s2.sale_date<= CURRENT_DATE - INTERVAL '90 DAYS')
GROUP BY p.product_name
ORDER BY volume DESC
LIMIT 5;

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10, 2)
);
INSERT INTO transactions (transaction_id, customer_id, transaction_date, amount) VALUES
-- Customer 1: Feb, Mar, Apr → valid (Feb-Mar, Mar-Apr)
(1, 1, '2024-02-15', 120.00),
(2, 1, '2024-03-10', 90.00),
(3, 1, '2024-04-05', 75.00),
-- Customer 2: Jan, Mar → not consecutive
(4, 2, '2024-01-20', 200.00),
(5, 2, '2024-03-15', 110.00),
-- Customer 3: May, Jun → valid
(6, 3, '2024-05-10', 55.00),
(7, 3, '2024-06-11', 60.00),
-- Customer 4: Feb only → not valid
(8, 4, '2024-02-20', 45.00),
-- Customer 5: Mar, Apr, Jun → Mar-Apr valid (Apr-Jun not consecutive)
(9, 5, '2024-03-05', 70.00),
(10, 5, '2024-04-07', 80.00),
(11, 5, '2024-06-08', 90.00),
-- Customer 6: Apr, May, Jun → valid (Apr-May, May-Jun)
(12, 6, '2024-04-03', 90.00),
(13, 6, '2024-05-04', 95.00),
(14, 6, '2024-06-05', 100.00);
SELECT * FROM transactions;


--3. Given a table of customer transactions, identify all customers who made purchases in two or more consecutive months.
WITH cte AS (
		SELECT customer_id, transaction_date,
			   LAG(transaction_date) OVER(PARTITION BY customer_id ORDER BY transaction_date) AS prev
		FROM transactions
)
SELECT DISTINCT customer_id FROM cte
WHERE (EXTRACT(YEAR FROM transaction_date) * 12 + EXTRACT(MONTH FROM transaction_date)) -
	(EXTRACT(YEAR FROM prev) * 12 + EXTRACT(MONTH FROM prev)) = 1
;












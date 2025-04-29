CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name TEXT,
    country TEXT
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    amount NUMERIC,
    status TEXT,
    order_date DATE
);

-- Sample Data
INSERT INTO customers (name, country) VALUES
('Alice', 'USA'), ('Bob', 'Canada'), ('Carlos', 'Mexico');

INSERT INTO orders (customer_id, amount, status, order_date) VALUES
(1, 120.50, 'shipped', '2024-01-10'),
(1, 75.00, 'pending', '2024-03-05'),
(2, 200.00, 'shipped', '2024-02-20'),
(3, 50.00, 'cancelled', '2024-04-01');
--1. ✅ Scalar Return
--Function: Return total number of orders

CREATE OR REPLACE FUNCTION total_orders()
RETURNS INT
LANGUAGE SQL
AS $$
	SELECT count(customer_id) from orders;
$$;
SELECT * FROM total_orders();

--2. 🔢 Return SETOF Scalar
--Function: Return all distinct statuses from orders

CREATE OR REPLACE FUNCTION distinct_status()
RETURNS SETOF TEXT
LANGUAGE SQL
AS $$
	SELECT DISTINCT status FROM orders;
$$;
SELECT * FROM distinct_status();

--3. RETURNS TABLE (named columns)
-- Function: Return shipped orders with customer name
CREATE OR REPLACE FUNCTION shipped_orders()
RETURNS TABLE(order_id INT,customer TEXT, amount NUMERIC )
LANGUAGE SQL
AS $$
	SELECT orders.order_id, customers.name, orders.amount 
	FROM customers
	LEFT JOIN orders on orders.customer_id=customers.customer_id
	WHERE orders.status='shipped';
$$;

SELECT * FROM shipped_orders();
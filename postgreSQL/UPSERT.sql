--UPSERT
--An UPSERT is a combination of INSERT and UPDATE operations. It allows you to insert a new record into a database,
--but if a record with the same unique key already exists, it will update the existing record instead.
-- Create a sample table

CREATE TABLE t_tags(
	id SERIAL PRIMARY KEY,
	tag TEXT UNIQUE,
	update_date TIMESTAMP DEFAULT NOW()
);

-- INSERT some sample data

INSERT INTO t_tags(tag)
VALUES ('hello'),
		('Hi'),
		('How are you');

SELECT * FROM t_tags;

--UPSERT ON CONFLICT DO NOTHING
INSERT INTO t_tags (tag)
VALUES ('Hi')
ON CONFLICT DO NOTHING;

----UPSERT ON CONFLICT SET NEW VALUES
INSERT INTO t_tags(tag)
VALUES ('Hi')
ON CONFLICT(tag) 
DO UPDATE SET
	tag=EXCLUDED.tag||' BABY',
	update_date=NOW();

-- PRACTICE 1
-- Create new table orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

--Insert some data
INSERT INTO orders(order_id,customer_id,order_date,total_amount)
VALUES (1234,11,'2025-01-23',1000);

SELECT * FROM orders;

--You have a orders table with order_id, customer_id, order_date, and total_amount. Insert a new order, and if an order 
--with the same order_id exists, update the customer_id, order_date, and total_amount. Additionally, if the total_amount 
--is the same, do nothing.

INSERT INTO orders(order_id,customer_id,order_date,total_amount)
VALUES (1234,23,'2025-01-23',1001)
ON CONFLICT(order_id)
DO UPDATE SET
	order_id=EXCLUDED.order_id,
	customer_id=EXCLUDED.customer_id,
	order_date=EXCLUDED.order_date,
	total_amount = EXCLUDED.total_amount;

--UPSERT with Condition on Conflict
--You have a user_profiles table with user_id, name, email, and status. If a user profile with the same email already 
--exists, update their status to "active" and set the name to the new value, but only if their current status is not 
--"active".
CREATE TABLE user_profiles (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    status VARCHAR(50)
);

INSERT INTO user_profiles (name, email, status)
VALUES ('Jack Smith', 'jacksmith@example.com', 'active'),
	   ('Jack worth', 'worthsmith@example.com', 'active');


SELECT * FROM user_profiles;

UPDATE user_profiles
SET status='not'
where user_id=2;

--
INSERT INTO user_profiles (name, email, status)
VALUES ('Lulli Corn', 'worthsmith@example.com', 'active')
ON CONFLICT (email)
DO UPDATE SET
	name=EXCLUDED.name,
	status=EXCLUDED.status
	WHERE user_profiles.status<>'active';

--UPSERT with Multiple Values
--Insert multiple records into the inventory table at once. If an item with the same item_id already exists, 
--update the stock_quantity and price.
CREATE TABLE inventory (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(100),
    stock_quantity INT,
    price DECIMAL(10, 2)
);

INSERT INTO inventory (item_id, item_name, stock_quantity, price)
VALUES
    (1, 'Widget A', 100, 19.99),
    (2, 'Widget B', 200, 29.99),
    (3, 'Widget C', 150, 9.99);

INSERT INTO inventory (item_id, item_name, stock_quantity, price)
VALUES
    (4, 'Widget D', 100, 19.99),
    (5, 'Widget B', 200, 29.99),
    (3, 'Widget C', 300, 19.99)
ON CONFLICT (item_id)
DO UPDATE SET
	stock_quantity=EXCLUDED.stock_quantity,
	price=EXCLUDED.price

	
SELECT * FROM inventory;
-- Insert data into table
-- Create table customers
--customer_id, first_name, last_name, email, age
CREATE TABLE customers(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	email VARCHAR(100),
	age INT
);

-- View the table
SELECT * FROM customers;

-- Insert data into table
INSERT INTO customers(first_name, last_name, email, age)
VALUES ('manasa', 'bitla', 'manasa5357@gmail.com', 35);

INSERT INTO customers(first_name, last_name, email, age)
VALUES ('Shravan', 'Gundu', 'shravan7865682@gmail.com', 36);

--Insert multiple records into table

INSERT INTO customers(first_name, last_name, email, age)
VALUES ('Dhillu', 'gundu', 'dhillu@gmail.com', 8),
	   ('Nihu', 'gundu', 'nihu@gmail.com', 3),
	   ('Nidhi', 'bitla', 'nidhi@gmail.com', 35);


-- View the table
SELECT * FROM customers;

-- Insert data with quotes

INSERT INTO customers (first_name)
Values ('Bill''o ss')

SELECT * FROM customers;

-- RETURNING clause
-- full record
INSERT INTO customers(first_name)
VALUES ('Baby') RETURNING *;

-- specific column
INSERT INTO customers(first_name)
VALUES ('paapa') RETURNING customer_id;

select * FROM customers
WHERE first_name='manasa'

-- Update data to a column

SELECT * FROM customers;

UPDATE customers
SET email='hi@gmail.com'
WHERE email='manasa5357@gmail.com'
RETURNING *;

SELECT * FROM customers;
--UPDATE multiple column values
UPDATE customers
SET email='baby@gmail.com',
	age=3
WHERE customer_id=9;

-- UPDATE all records at once
SELECT * FROM customers;

UPDATE customers
SET is_enable='T'
RETURNING *

-- DELETE records from table
DELETE FROM customers
WHERE customer_id=9

-- to DELETE all records
DELETE FROM customers;
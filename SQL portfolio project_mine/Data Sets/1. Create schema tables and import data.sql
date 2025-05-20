-- WARNING:
-- Running this script will drop and recreate the 'datawarehouseanalytics' database.
-- All existing data will be permanently deleted.

-- DROP DATABASE must be run in a different session or using a script outside of the database you're connected to.
-- Example (from psql CLI or admin tool):

--DROP DATABASE IF EXISTS datawarehouseanalytics;
 --CREATE DATABASE datawarehouseanalytics;

-- After creating the database, connect to it:
-- \c datawarehouseanalytics

-- Create the schema
CREATE SCHEMA IF NOT EXISTS gold;

-- Create dimension tables
CREATE TABLE gold.dim_customers (
    customer_key INT,
    customer_id INT,
    customer_number VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    marital_status VARCHAR(50),
    gender VARCHAR(50),
    birthdate DATE,
    create_date DATE
);

CREATE TABLE gold.dim_products (
    product_key INT,
    product_id INT,
    product_number VARCHAR(50),
    product_name VARCHAR(50),
    category_id VARCHAR(50),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    maintenance VARCHAR(50),
    cost INT,
    product_line VARCHAR(50),
    start_date DATE
);

CREATE TABLE gold.fact_sales (
    order_number VARCHAR(50),
    product_key INT,
    customer_key INT,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INT,
    quantity SMALLINT,
    price INT
);

-- Truncate tables before loading data
TRUNCATE TABLE gold.dim_customers;
TRUNCATE TABLE gold.dim_products;
TRUNCATE TABLE gold.fact_sales;

-- Import the below csv files in their respective tables using import
-- "gold.dim_products.csv.csv"
-- "gold.dim_products.csv.csv"
-- "gold.dim_products.csv.csv"
-- You can find these datasets in the project github
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

-- Analyse sales performance over time
select * from gold.fact_sales limit 2;

-- Get total sales by year
select to_char(order_date, 'yyyy') as Year, sum(sales_amount) as Total_sales
from gold.fact_sales
where order_date is not null
group by to_char(order_date, 'yyyy')
order by to_char(order_date, 'yyyy');

-- add total number of customers, total order quantity
select to_char(order_date, 'yyyy') as Year, sum(sales_amount) as Total_sales, count(distinct customer_key) as Total_customers,
sum(quantity) as Total_quantity
from gold.fact_sales
where order_date is not null
group by to_char(order_date, 'yyyy')
order by to_char(order_date, 'yyyy');

-- by month
select to_char(order_date, 'mm') as month, sum(sales_amount) as Total_sales, count(distinct customer_key) as Total_customers,
sum(quantity) as Total_quantity
from gold.fact_sales
where order_date is not null
group by to_char(order_date, 'mm')
order by to_char(order_date, 'mm');

-- by year and month

select to_char(order_date, 'yyyy') as Year,to_char(order_date, 'mm') as month, sum(sales_amount) as Total_sales, count(distinct customer_key) as Total_customers,
sum(quantity) as Total_quantity
from gold.fact_sales
where order_date is not null
group by to_char(order_date, 'yyyy'),to_char(order_date, 'mm')
order by to_char(order_date, 'yyyy'), to_char(order_date, 'mm');

-- month with year - first day of month 
select cast(date_trunc('month', order_date)as date) as order_date, sum(sales_amount) as Total_sales, count(distinct customer_key) as Total_customers,
sum(quantity) as Total_quantity
from gold.fact_sales
where order_date is not null
group by cast(date_trunc('month', order_date) as date)
order by cast(date_trunc('month', order_date)as date);

-- year  - first day of year 
select cast(date_trunc('year', order_date)as date) as order_date, sum(sales_amount) as Total_sales, count(distinct customer_key) as Total_customers,
sum(quantity) as Total_quantity
from gold.fact_sales
where order_date is not null
group by cast(date_trunc('year', order_date) as date)
order by cast(date_trunc('year', order_date)as date);


-- Cumulative Analysis
-- Aggregate the data progressively over the time
select * from gold.fact_sales limit 5;

-- calculate the total sales per month and the running total of sales over timeselect 

select cast(date_trunc('month', order_date) as date) as orderdate, sum(sales_amount) as total_sales,
	   sum(sum(sales_amount)) over(order by cast(date_trunc('month', order_date) as date)) as running_total
from gold.fact_sales
where order_date is not null
group by cast(date_trunc('month', order_date) as date)
order by cast(date_trunc('month', order_date) as date);

-- running total for each year

select cast(date_trunc('year', order_date) as date) as orderdate, sum(sales_amount) as total_sales,
	   sum(sum(sales_amount)) over(order by cast(date_trunc('year', order_date) as date)) as running_total
from gold.fact_sales
where order_date is not null
group by cast(date_trunc('year', order_date) as date)
order by cast(date_trunc('year', order_date) as date);


--Moving average -

select cast(date_trunc('month', order_date) as date) as orderdate, sum(sales_amount) as total_sales,
	   sum(sum(sales_amount)) over(order by cast(date_trunc('month', order_date) as date)) as running_total,
	   round(avg(price),2) as avg_price,
	   round(avg(avg(price)) over(order by cast(date_trunc('month', order_date) as date))) as running_avg_price 
from gold.fact_sales
where order_date is not null
group by cast(date_trunc('month', order_date) as date)
order by cast(date_trunc('month', order_date) as date);

select cast(date_trunc('year', order_date) as date) as orderdate, sum(sales_amount) as total_sales,
	   sum(sum(sales_amount)) over(order by cast(date_trunc('year', order_date) as date)) as running_total,
	   round(avg(price)) as avg_price,
	   round(avg(avg(price)) over(order by cast(date_trunc('year', order_date) as date))) as running_avg_price 
from gold.fact_sales
where order_date is not null
group by cast(date_trunc('year', order_date) as date)
order by cast(date_trunc('year', order_date) as date);

-- Performance analysis
-- comparing the current value to a target value
select * from gold.fact_sales;
select * from gold.dim_products limit 5;
-- Analyze the yearly performance of products by comparing each product's sales to both its average sales performance and the previousl year's sales


--  Year over Year analysis
with cte as(
		select to_char(s.order_date,'yyyy')as order_year, sum(s.sales_amount) as current_sales,
			round(avg(sum(s.sales_amount)) over(partition by p.product_name))as overall_avg_sales,p.product_name as product_name
		from gold.fact_sales s
		left join gold.dim_products p on p.product_key=s.product_key
		where s.order_date is not null
		group by to_char(s.order_date,'yyyy'),p.product_name
		order by p.product_name
)
select order_year, product_name, current_sales, 
	   lag(current_sales) over(partition by product_name order by order_year) as prev_year_sales,
	   current_sales - lag(current_sales) over(partition by product_name order by order_year) as diff_prev_curr,
	   case
	   		when  current_sales - lag(current_sales) over(partition by product_name order by order_year) > 0 then 'Increase'
			when  current_sales - lag(current_sales) over(partition by product_name order by order_year) < 0 then 'Decrease'
			else 'No change'
		end change_prev_curr,
	   overall_avg_sales,
	   current_sales - overall_avg_sales as diff_avg,
	   case
	   		when  current_sales - overall_avg_sales > 0 then 'Above avg'
			when  current_sales - overall_avg_sales < 0 then 'Below avg'
			else 'Avg'
	  end avg_change
from cte;

-- Month over month analysis
with cte as(
		select to_char(s.order_date,'mm')as order_month, sum(s.sales_amount) as current_sales,
			round(avg(sum(s.sales_amount)) over(partition by p.product_name))as overall_avg_sales,p.product_name as product_name
		from gold.fact_sales s
		left join gold.dim_products p on p.product_key=s.product_key
		where s.order_date is not null
		group by to_char(s.order_date,'mm'),p.product_name
		order by p.product_name
)
select order_month, product_name, current_sales, 
	   lag(current_sales) over(partition by product_name order by order_month) as prev_mon_sales,
	   current_sales - lag(current_sales) over(partition by product_name order by order_month) as diff_prev_curr,
	   case
	   		when  current_sales - lag(current_sales) over(partition by product_name order by order_month) > 0 then 'Increase'
			when  current_sales - lag(current_sales) over(partition by product_name order by order_month) < 0 then 'Decrease'
			else 'No change'
		end change_prev_curr,
	   overall_avg_sales,
	   current_sales - overall_avg_sales as diff_avg,
	   case
	   		when  current_sales - overall_avg_sales > 0 then 'Above avg'
			when  current_sales - overall_avg_sales < 0 then 'Below avg'
			else 'Avg'
	  end avg_change
from cte;


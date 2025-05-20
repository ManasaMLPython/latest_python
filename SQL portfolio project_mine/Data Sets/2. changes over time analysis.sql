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





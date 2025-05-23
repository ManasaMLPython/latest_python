/* 
========================================================================================================================================
Customer Report
========================================================================================================================================
Purpose:
	- This report consolidates key customer metrics and behaviour
Highlights:
	1. Gather essential details like name, age and transactions details.
	2. Segment customers into categories(VIP, Regular, New) and age groups.
	3. Aggregate customer level metrics:
		- Total orders
		- Total sales
		- Total quantity purchased
		- Total products
		- lifespan(in months)
	4. Calculate valueablr KPIs:
		- Recency (months since last order)
		- Average order value
		- Average monthly spend
========================================================================================================================================
*/
select * from gold.dim_customers;
select * from gold.fact_sales;
select * from gold.dim_products;
with base_details as (
	select 
	s.order_number, 
	s.product_key, 
	s.order_date, 
	s.sales_amount, 
	s.quantity,
	c.customer_key,
	c.customer_number,
	c.first_name || ' '||c.last_name as Name,
	date_part('year',age(current_date,c.birthdate)) as age 
	from gold.fact_sales s
	left join gold.dim_customers c
	on c.customer_key = s.customer_key
	where s.order_date is not null
),
aggregations as(
	select
	customer_key,customer_number,name,age,count(distinct order_number) as total_orders,sum(sales_amount) as total_sales, sum(quantity) as total_quantity,
	count(distinct product_key) as total_products, min(order_date) first_order, max(order_date) as last_order, 
    (EXTRACT(YEAR FROM max(order_date)::date) - EXTRACT(YEAR FROM min(order_date)::date)) * 12 +
    (EXTRACT(MONTH FROM max(order_date)::date) - EXTRACT(MONTH FROM min(order_date)::date)) AS lifespan
	from base_details
	group by customer_key,customer_number,name,age
)
select customer_key,customer_number,name,age, 
		case
			when age<20  then 'Below 20'
			when age between 20 and 29  then '20-29'
			when age between 30 and 39  then '30-39'
			when age between 40 and 49  then '40-49'
			else '50 and above'
		end as age_group,
		case
			when lifespan>=12 and total_sales>5000 then 'VIP'
			when lifespan>=12 and total_sales<=5000 then 'Regular'
			else 'New'
		end as customer_segment,
		last_order, 
		DATE_PART('year', AGE(current_date, last_order)) * 12 +
		DATE_PART('month', AGE(current_date, last_order)) as recency,
		total_orders, total_sales, total_quantity, total_products, lifespan,
		-- Average order value AOV = Total Sales / Number of Orders
		case
			when total_orders=0 then 0
			else total_sales/total_orders
		end as avg_order_value,
		-- Average monthly spend AMS = Total sales/number of unique months with sales(lifespan)
		case
			when lifespan=0 then total_sales
			else round(total_sales/lifespan)
		end as avg_monthly_spend
from aggregations
;
/*
===============================================================================
===============================================================================
===============================================================================
						CREATE VIEW
===============================================================================
===============================================================================
===============================================================================*/
create or replace view gold.customer_report as
		with base_details as (
			select 
			s.order_number, 
			s.product_key, 
			s.order_date, 
			s.sales_amount, 
			s.quantity,
			c.customer_key,
			c.customer_number,
			c.first_name || ' '||c.last_name as Name,
			date_part('year',age(current_date,c.birthdate)) as age 
			from gold.fact_sales s
			left join gold.dim_customers c
			on c.customer_key = s.customer_key
			where s.order_date is not null
		),
		aggregations as(
			select
			customer_key,customer_number,name,age,count(distinct order_number) as total_orders,sum(sales_amount) as total_sales, sum(quantity) as total_quantity,
			count(distinct product_key) as total_products, min(order_date) first_order, max(order_date) as last_order, 
		    (EXTRACT(YEAR FROM max(order_date)::date) - EXTRACT(YEAR FROM min(order_date)::date)) * 12 +
		    (EXTRACT(MONTH FROM max(order_date)::date) - EXTRACT(MONTH FROM min(order_date)::date)) AS lifespan
			from base_details
			group by customer_key,customer_number,name,age
		)
		select customer_key,customer_number,name,age, 
				case
					when age<20  then 'Below 20'
					when age between 20 and 29  then '20-29'
					when age between 30 and 39  then '30-39'
					when age between 40 and 49  then '40-49'
					else '50 and above'
				end as age_group,
				case
					when lifespan>=12 and total_sales>5000 then 'VIP'
					when lifespan>=12 and total_sales<=5000 then 'Regular'
					else 'New'
				end as customer_segment,
				last_order, 
				DATE_PART('year', AGE(current_date, last_order)) * 12 +
				DATE_PART('month', AGE(current_date, last_order)) as recency,
				total_orders, total_sales, total_quantity, total_products, lifespan,
				-- Average order value AOV = Total Sales / Number of Orders
				case
					when total_orders=0 then 0
					else total_sales/total_orders
				end as avg_order_value,
				-- Average monthly spend AMS = Total sales/number of unique months with sales(lifespan)
				case
					when lifespan=0 then total_sales
					else round(total_sales/lifespan)
				end as avg_monthly_spend
		from aggregations
;

-- 1.
select * from gold.customer_report;

--2.
select age_group , count(customer_number), sum(total_sales) from gold.customer_report
group by age_group;

--3.
select customer_segment, count(customer_number) as total_customers, sum(total_sales) as total_sales from gold.customer_report
group by customer_segment;
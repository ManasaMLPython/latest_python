/* 
========================================================================================================================================
Product Report
========================================================================================================================================
Purpose:
	- This report consolidates key product metrics and behaviour
Highlights:
	1. Gather essential details like product name, category, sub category and cost.
	2. Segment product by revenue to identify high-performers, mid-range and low-performers.
	3. Aggregate product level metrics:
		- Total orders
		- Total sales
		- Total quantity purchased
		- Total customers(unique)
		- lifespan(in months)
	4. Calculate valueablr KPIs:
		- Recency (months since last sale)
		- Average order revenue
		- Average monthly revenue
========================================================================================================================================
*/
select * from gold.dim_products;
with base_details as (
		select 
			s.order_number, 
			s.product_key, 
			p.product_number,
			s.order_date, 
			s.sales_amount,
			s.customer_key,
			s.price, 
			s.quantity,
			p.category,
			p.subcategory
		from gold.fact_sales s
		left join gold.dim_products p
		on p.product_key = s.product_key
		where s.order_date is not null
),
aggregations as(
	select
	product_key,product_number,category,subcategory,count(distinct order_number) as total_orders,sum(sales_amount) as total_sales, sum(quantity) as total_quantity,
	count(distinct customer_key) as total_customers, min(order_date) first_order, max(order_date) as last_order, 
    (EXTRACT(YEAR FROM max(order_date)::date) - EXTRACT(YEAR FROM min(order_date)::date)) * 12 +
    (EXTRACT(MONTH FROM max(order_date)::date) - EXTRACT(MONTH FROM min(order_date)::date)) AS lifespan
	from base_details
	group by product_key,product_number,category,subcategory
)
select product_key,product_number,category,subcategory, 
		case
			when total_sales>50000 then 'High-performers'
			when total_sales>=100000 then 'Mid-range'
			else 'Low-performers'
		end as product_segment,
		last_order, 
		DATE_PART('year', AGE(current_date, last_order)) * 12 +
		DATE_PART('month', AGE(current_date, last_order)) as recency,
		total_orders, total_sales, total_quantity, total_customers, lifespan,
		-- Average order revenue AOR = Total Sales / Number of Orders
		case
			when total_orders=0 then 0
			else total_sales/total_orders
		end as avg_order_revenue,
		-- Average monthly revenue AMR = Total sales/number of unique months with sales(lifespan)
		case
			when lifespan=0 then total_sales
			else round(total_sales/lifespan)
		end as avg_monthly_revenue
from aggregations
;


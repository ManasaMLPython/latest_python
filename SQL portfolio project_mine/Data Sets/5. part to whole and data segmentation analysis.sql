-- Part to whole analysis
-- Analyze how an individual part is performing compared to the overall, allowing us to understand which category has the greatest impact on the business
-- ([measure]/total[measure])* 100

-- Task - which categories contribute the most to overall sales
select * from gold.fact_sales;
select * from gold.dim_products;

with cte as(
	select p.product_name as category_name,
	sum(s.sales_amount) as total_sales
	from gold.fact_sales s
	left join gold.dim_products p
	on s.product_key = p.product_key
	group by p.category
	)
select category_name, total_sales,
sum(total_sales) over() as overall_sales,
round((total_sales/sum(total_sales) over())*100,2) || '%' as per
from cte;

----------------------------------------------------------------------------------------------------------------------
-- Data segmentation
-- Group the data based on a specific range helps understand the correlation between two measures
-- ex:total products by sales range or total customers by age

-- Task: segment products into cost ranges and count how many products fall into each 
with cte as(
	select product_key, product_name, cost,
		   case
		   		when cost<100 then 'Below 100'
				when cost between 100 and 500 then '100-500'
				when cost between 500 and 1000 then '500-1000'
				else 'Above 1000'
			end as cost_range
	from gold.dim_products
)
select cost_range, count(product_key) as total_products
from cte
group by cost_range
order by total_products desc;

-- Task: Group customers into three segments based on their spending behaviour:
-- VIP : customers with atleast 12 months of history and spending morethan 5000
-- Regular : Customers with atleast 12 months of history but spending 5000 or less
-- New : Customer with lifespan less than 12 months
-- And find the total number of customers by each group

--step 1: create a new measure lifespan
with cte as (
		select c.customer_key as customer_key, sum(s.sales_amount) as total_sales, min(s.order_date) as first_order, max(s.order_date) as last_order,
				DATE_PART('year', AGE(max(s.order_date), min(s.order_date))) * 12 +
				DATE_PART('month', AGE(max(s.order_date), min(s.order_date))) AS lifespan_months
		from gold.fact_sales s
		left join gold.dim_customers c
		on c.customer_key = s.customer_key
		group by c.customer_key
		),
seg as (
		select *, 
			case
				when lifespan_months>=12 and total_sales>5000 then 'VIP'
				when lifespan_months>=12 and total_sales<=5000 then 'Regular'
				else 'New'
			end as customer_segment
from cte
)
select customer_segment, count(customer_key)
from seg
group by customer_segment
order by count(customer_key) desc
;






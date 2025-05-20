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


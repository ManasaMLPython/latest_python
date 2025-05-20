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
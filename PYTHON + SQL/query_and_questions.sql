DROP TABLE IF EXISTS df_orders;
CREATE TABLE IF NOT EXISTS public.df_orders (
    order_id INTEGER PRIMARY KEY,
    order_date TIMESTAMP,
    ship_mode VARCHAR(20),
    segment VARCHAR(20),
    country VARCHAR(20),
    city VARCHAR(20),
    state VARCHAR(20),
    postal_code INTEGER,
    region VARCHAR(20),
    category VARCHAR(20),
    sub_category VARCHAR(20),
    product_id VARCHAR(20),
    quantity INTEGER,
    discount DECIMAL(7,2),
    sale_price DECIMAL(7,2),
    profit DECIMAL(7,2)
);
select * from df_orders;

-- check dtypes
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    numeric_precision,
    numeric_scale,
    is_nullable,
    column_default
FROM 
    information_schema.columns
WHERE 
    table_name = 'df_orders'
    AND table_schema = 'public';
--=========================================INSIGHTS==========================================

--1. Find top 10 highest revenue generating products
SELECT product_id, SUM(sale_price * quantity) AS Total_sales
FROM df_orders
GROUP BY product_id
ORDER BY Total_sales DESC
LIMIT 10;

-- 2. Find top 5 highest selling products in each region
	WITH cte AS(
		SELECT region, product_id, SUM(sale_price * quantity) AS Total_sales,
		DENSE_RANK() OVER(PARTITION BY region ORDER BY SUM(sale_price*quantity) DESC) AS rank
		FROM df_orders
		GROUP BY region, product_id
		)
SELECT region, product_id, Total_sales, rank
FROM cte
WHERE rank<=5;

-- 3. Find month over month growth comparision for jan 2022 and jan 2023 sales eg: jan 2022 vs jan 2024

WITH cte AS (
			SELECT EXTRACT(MONTH FROM order_date) AS order_month,
			 SUM(CASE 
				   	WHEN EXTRACT(YEAR FROM order_date)=2022 THEN sale_price else 0
				 END) AS SALES_2022,
			SUM(
				CASE
					WHEN EXTRACT(YEAR FROM order_date)=2023 THEN sale_price else 0
				END) AS SALES_2023
			FROM df_orders
			GROUP BY order_month
			ORDER BY order_month
			)
SELECT order_month, sales_2022, sales_2023, ROUND(((sales_2023-sales_2022)/NULLIF(sales_2022,0))*100,2)|| '%' AS growth
FROM cte
;

-- 4. For each category which month had highest sales
WITH cte AS (
		SELECT category, TO_CHAR(order_date, 'MM-YYYY') order_month, SUM(sale_price) AS total_sales
		FROM df_orders
		GROUP BY category, order_month
		ORDER BY category, order_month
),
cte_ranked AS (
		SELECT *,
			   RANK() OVER(PARTITION BY category ORDER BY total_sales DESC) AS rnk
		FROM cte
)
SELECT category, order_month, total_sales
FROM cte_ranked
WHERE rnk=1;


--5. For each sub category which month had highest sales
WITH cte AS(
		SELECT sub_category , TO_CHAR(order_date, 'MM-YYYY') order_month, SUM(sale_price) AS total_sales,
			   RANK() OVER(PARTITION BY sub_category ORDER BY SUM(sale_price) DESC) AS rnk
		FROM df_orders
		GROUP BY sub_category, order_month
		ORDER BY sub_category, order_month
)
SELECT sub_category, order_month, total_sales
FROM cte
WHERE rnk=1;

--6. Which subcategory had highest growth by profit in 2023 compare to 2022
WITH cte AS (
			SELECT sub_category,  
				   SUM(
						CASE
							WHEN EXTRACT(YEAR FROM order_date)=2022 THEN sale_price 
							ELSE 0
						END
				   ) AS total_sales_2022,
				   SUM(
						CASE
							WHEN EXTRACT(YEAR FROM order_date)=2023 THEN sale_price 
							ELSE 0
						END
				   ) AS total_sales_2023
			FROM df_orders
			GROUP BY sub_category
			ORDER BY sub_category
),
growth_cte AS(
			SELECT *,
				   ROUND((total_sales_2023-total_sales_2022)*100/NULLIF(total_sales_2022,0),2)||'%' AS growth_rate,
				   RANK() OVER(ORDER BY ROUND((total_sales_2023-total_sales_2022)*100/NULLIF(total_sales_2022,0),2) DESC) AS rnk
			FROM cte
)
SELECT sub_category, total_sales_2022, total_sales_2023, GROWTH_RATE
FROM growth_cte
WHERE rnk=1;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  runner_id INT,
  registration_date TIMESTAMP
);
INSERT INTO runners (runner_id, registration_date) VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');
DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INT,
  customer_id INT,
  pizza_id INT,
  exclusions VARCHAR(10),
  extras VARCHAR(10),
  order_time TIMESTAMP
);
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES
  (1, 101, 1, '', '', '2020-01-01 18:05:02'),
  (2, 101, 1, '', '', '2020-01-01 19:00:52'),
  (3, 102, 1, '', '', '2020-01-02 23:51:23'),
  (3, 102, 2, '', NULL, '2020-01-02 23:51:23'),
  (4, 103, 1, '4', '', '2020-01-04 13:23:46'),
  (4, 103, 1, '4', '', '2020-01-04 13:23:46'),
  (4, 103, 2, '4', '', '2020-01-04 13:23:46'),
  (5, 104, 1, NULL, '1', '2020-01-08 21:00:29'),
  (6, 101, 2, NULL, NULL, '2020-01-08 21:03:13'),
  (7, 105, 2, NULL, '1', '2020-01-08 21:20:29'),
  (8, 102, 1, NULL, NULL, '2020-01-09 23:54:33'),
  (9, 103, 1, '4', '1, 5', '2020-01-10 11:22:59'),
  (10, 104, 1, NULL, NULL, '2020-01-11 18:34:49'),
  (10, 104, 1, '2, 6', '1, 4', '2020-01-11 18:34:49');
 

drop table if exists runner_orders;
CREATE TABLE runner_orders (
  order_id INT,
  runner_id INT,
  pickup_time VARCHAR(20),
  distance VARCHAR(10),
  duration VARCHAR(20),
  cancellation VARCHAR(30)
);
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES
  (1, 1, '2020-01-01 18:15:34', '20km', '32 minutes', NULL),
  (2, 1, '2020-01-01 19:10:54', '20km', '27 minutes', NULL),
  (3, 1, '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  (4, 2, '2020-01-04 13:53:03', '23.4km', '40minutes', NULL),
  (5, 3, '2020-01-08 21:10:57', '10km', '15minutes', NULL),
  (6, 3, NULL, NULL, NULL, 'Restaurant Cancellation'),
  (7, 2, '2020-01-08 21:30:45', '25km', '25mins', NULL),
  (8, 2, '2020-01-10 00:15:02', '23.4 km', '15 minute', NULL),
  (9, 2, NULL, NULL, NULL, 'Customer Cancellation'),
  (10, 1, '2020-01-11 18:50:20', '10km', '10minutes', NULL);

DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INT,
  pizza_name TEXT
);
INSERT INTO pizza_names (pizza_id, pizza_name) VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');

DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  pizza_id INT,
  toppings TEXT
);
INSERT INTO pizza_recipes (pizza_id, toppings) VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');

CREATE TABLE pizza_toppings (
  topping_id INT,
  topping_name TEXT
);
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');

create table pizza_recipes_ingredients (
pizza_id int,topping_id int);
INSERT INTO pizza_recipes_ingredients (pizza_id, topping_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 8), (1, 10),
(2, 4), (2, 6), (2, 7), (2, 9), (2, 11), (2, 12);

-- ---------------------------------------A.PIZZA METRICS---------------------------------------------------
-- 1. How many pizzas were ordered?
SELECT count(*)
FROM customer_orders;

-- 2. How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) 
FROM customer_orders;

-- 3.How many successful orders were delivered by each runner?
SELECT runner_id,COUNT(order_id) AS successful_deliveries
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;
select * from runner_orders;

-- 4.How many of each type of pizza was delivered?
SELECT p.pizza_name, count(*) 
FROM customer_orders c
JOIN pizza_names p
ON p.pizza_id = c.pizza_id
JOIN runner_orders r
ON r.order_id = c.order_id
WHERE cancellation IS NULL
GROUP BY p.pizza_name;

-- 5.How many Vegetarian and Meatlovers were ordered by each customer?
-- orders including failed
SELECT c.customer_id, pizza_name, count(*) as Count_of_Pizza
FROM customer_orders c
JOIN pizza_names p
ON p.pizza_id = c.pizza_id
GROUP BY c.customer_id, p.pizza_id, p.pizza_name
ORDER BY c.customer_id;

-- only successfull orders

SELECT customer_id , count(co.order_id) as Count_of_Pizza,pizza_name FROM customer_orders as co
join pizza_names as pn 
on co.pizza_id=pn.pizza_id
join runner_orders as ro
on co.order_id=ro.order_id
where cancellation is NULL
group by customer_id,pizza_name
order by customer_id;

-- 6.What was the maximum number of pizzas delivered in a single order?
WITH cte AS (
		SELECT c.order_id, COUNT(*) AS orders
		FROM customer_orders c
		JOIN runner_orders ro
		ON c.order_id=ro.order_id
		WHERE cancellation IS NULL
		GROUP BY c.order_id
)
SELECT MAX(orders) AS max_orders_in_single_order
FROM cte;

 Update customer_orders set extras =NULL where customer_id='102';
Update customer_orders set exclusions =NULL where customer_id='102';
Update customer_orders set exclusions ='4' where customer_id='103';
Update customer_orders set extras =NULL where customer_id='103';
select * from runner_orders;

-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT c.customer_id, 
	   SUM(
			CASE
				WHEN exclusions IS NULL AND extras IS NULL THEN 1
				ELSE 0
			END
	   ) AS Pizzas_without_changes,
	  SUM(
			CASE
				WHEN exclusions IS NOT NULL OR extras IS NOT NULL THEN 1
				ELSE 0
			END) AS pizzas_with_changes
FROM customer_orders c
JOIN runner_orders r
ON r.order_id= c.order_id AND r.cancellation IS NULL
GROUP BY c.customer_id
;

-- 8 How many pizzas were delivered that had both exclusions and extras?
SELECT c.customer_id, 
	   SUM(
			CASE
				WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN 1
				ELSE 0
			END
	   ) AS Pizzas_exclusion_extra
FROM customer_orders c
JOIN runner_orders r
ON r.order_id= c.order_id AND r.cancellation IS NULL
GROUP BY c.customer_id
;

-- 9.What was the total volume of pizzas ordered for each hour of the day?
SELECT EXTRACT(HOUR FROM order_time) AS HOUR_OF_ORDER, count(c.order_id) AS volume_of_pizzas
FROM customer_orders c
JOIN runner_orders r
ON r.order_id= c.order_id AND r.cancellation IS NULL
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY EXTRACT(HOUR FROM order_time);

-- 10.What was the volume of orders for each day of the week?
SELECT TO_CHAR(order_time, 'Day') AS DAY_OF_ORDER, count(c.order_id) AS volume_of_pizzas
FROM customer_orders c
JOIN runner_orders r
ON r.order_id= c.order_id AND r.cancellation IS NULL
GROUP BY TO_CHAR(order_time, 'Day')
ORDER BY TO_CHAR(order_time, 'Day');


--  ----------------------------------------B. Runner and Customer Experience----------------------------------------
-- 1) How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT 
  EXTRACT(WEEK FROM registration_date) AS signup_week,
  COUNT(*) AS runners_signed_up
FROM runners
GROUP BY signup_week;

--================================================================
Update runner_orders set duration ='20 minutes' where order_id='3';
Update runner_orders set duration ='25 minutes' where order_id='7';
Update runner_orders set duration ='40 minutes' where order_id='4';
Update runner_orders set duration ='15 minutes' where order_id='5';
Update runner_orders set duration ='15 minutes' where order_id='8';
====================================================================

-- 2)What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT runner_id, ROUND(AVG(REGEXP_REPLACE(duration,'\D','','g')::INT)) AS avg_time_to_pickup
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;

-- 3)What was the average distance travelled for each customer?
SELECT customer_id, ROUND(AVG(REGEXP_REPLACE(distance,'[^0-9.]','','g')::NUMERIC),2) AS avg_distance
FROM customer_orders c
JOIN runner_orders r
ON c.order_id=r.order_id AND cancellation IS NULL
GROUP BY customer_id;

--4) What was the difference between the longest and shortest delivery times for all orders?
SELECT MAX(REGEXP_REPLACE(duration,'\D','','g')::INT) - MIN(REGEXP_REPLACE(duration,'\D','','g')::INT) AS avg_time_to_pickup
FROM runner_orders
WHERE cancellation IS NULL;

--5)What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT runner_id,order_id, ROUND((REGEXP_REPLACE(distance,'[^0-9.]','','g')::NUMERIC)/ROUND((REGEXP_REPLACE(duration,'\D','','g')::NUMERIC)/60,4),2) AS avg_speed
FROM runner_orders
WHERE cancellation IS NULL;

-- 6)What is the successful delivery percentage for each runner?
WITH cte AS (
			SELECT runner_id, COUNT(*) AS total_deliveries,
				   SUM(
						CASE 
							WHEN cancellation IS NULL THEN 1
							ELSE 0
						END
				   ) AS successful_deliveries
			FROM runner_orders
			GROUP BY runner_id
		)
SELECT runner_id, total_deliveries, successful_deliveries,(successful_deliveries*100)/total_deliveries || '%' AS success_percentage
FROM cte
ORDER BY runner_id;

-- ---------------------------------3.C. Ingredient Optimisation----------------------------------------------------------
-- 1)What are the standard ingredients for each pizza?
SELECT pizza_name,i.pizza_id, ARRAY_AGG(topping_name) as toppings
FROM pizza_recipes_ingredients i
JOIN pizza_names n
ON i.pizza_id=n.pizza_id
JOIN pizza_toppings t
ON t.topping_id = i.topping_id
GROUP BY pizza_name,i.pizza_id;
-- 2) What was the most commonly added extra?
select * from customer_orders;
select * from runners;
select * from runner_orders;
select * from pizza_recipes_ingredients;

  
## 1. What is the most popular item on the menu? Which item is teh least popular?
## 2. Average pizza order (how many pizza pies do most people buy per order?)
## 3. Average price of pizza.
## 4. Is there a trend in revenue/total orders? Which month made the most money/most orders? Which month made the least money/orders?
## 5. Which size of pizza is most ordered?
## 6. What are considered peak hours for the pizza shop?
## 7. What day of the week is most popular for orders? Which day of the week is least popular?

## Imported 4 different csv files which are named order_details, orders, pizza_types, and pizzas 

USE pizza_place_sales

## Lets look at the different tables

SHOW tables

## We have 4 different tables which are order_details, orders, pizza_types, and pizzas. Lets see what each table contains.
 
SELECT * 
	FROM order_details;

SELECT *
	FROM orders;

SELECT *
	FROM pizza_types;
    
SELECT * 
	FROM pizzas;

## Date range

SELECT MIN(date) AS nearest_date, MAX(date) AS further_date
FROM orders;

## So we are dealing with a year's worth of data. Lets start with answering question 

#---------------------------------------------------------------------------------------------------------------------

## Question 1. What is the most popular item on the menu? Which item is the least popular?

SELECT pizza_id, COUNT(pizza_id) AS total_count
	FROM order_details
    GROUP BY pizza_id
    ORDER BY total_count DESC;

## By using the pizza_id from the order table, we can see the most bought pizza is the big meat pizza size small, while the least bought pizza is The Greek XXL pizza. 

#---------------------------------------------------------------------------------------------------------------------

## Qeustion 2. Average pizza order (how many pizza pies do most people buy per order?)

SELECT MAX(order_id) AS total_orders
	FROM order_details;
    
## As we see there is 21,350 orders with the sum for each of their respective orders. It would be difficult to add all of these numbers one by one.
## But how about we take the sum of the quantity for the orders and divide that with the number of orders.

SELECT SUM(quantity) AS total_quantity
	FROM order_details;

## We get 49,574. Lets divide that by the total number of orders!

SELECT SUM(quantity)/MAX(order_id) AS average_pizza_per_order
	FROM order_details;
    
    ## We get an average of 2.3 pizzas per order.
#---------------------------------------------------------------------------------------------------------------------

## Question 3. Average Price of a pizza.

SELECT AVG(price) AS avg_price
	FROM pizzas;
    
## We can see that the avergage price of the pizza is approximately $16.44.

#---------------------------------------------------------------------------------------------------------------------

## Question 4. Is there a trend in revenue/total orders? Which month made the most money/most orders? Which month made the least money/orders?

SELECT DISTINCT(MONTHNAME(date)) AS months, ROUND(SUM(price)) AS total_value, COUNT(order_details.order_id) AS total_orders
	FROM pizzas
    INNER JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
	INNER JOIN orders ON order_details.order_id = orders.order_id
    GROUP BY months;
    
    ## From this query we were able to pull the total orders and total price for each month. If we simply click the "total_value" icon we can see that July made the most orders
    ## and revenue while October made the least amount of orders and revenue.

#---------------------------------------------------------------------------------------------------------------------

## Question 5. Which size of pizza is most ordered?
    
SELECT DISTINCT size, COUNT(order_id) AS total_orders
	FROM order_details
    INNER JOIN pizzas on order_details.pizza_id = pizzas.pizza_id
    GROUP BY size
    ORDER BY size;

## From this query, we see that most customers purchases large orders!

#---------------------------------------------------------------------------------------------------------------------

## Question 6. What are considered peak hours for the pizza shop?

SELECT HOUR(time) AS order_hour, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

## Based on these results, peak hours are from the hours of roughly 12pm - 2:00pm. I grouped the order time to hours because it makes
## the answer more cohesive instead of having each individual time per hour such as (11:38:36 AM and 11:57:40 AM) which are actual times, show Excel sheet)

#---------------------------------------------------------------------------------------------------------------------

## Question 7. What day of the week is most popular for orders? Which day of the week is least popular?

SELECT DAYNAME(date) AS weekday, COUNT(order_id) AS total_orders
	FROM orders
    GROUP BY weekday
    ORDER BY total_orders DESC;

## The results indicate that Friday is the most popular day while Sunday is the least popular day. 
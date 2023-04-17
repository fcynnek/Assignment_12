-- Assignment #12 for Coders Campus Bootcamp
-- By: Kenny Cheng

CREATE DATABASE assignment_12;
USE assignment_12;

-- Q2: Create your database based on your design in MySQL
CREATE TABLE `customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(150) NOT NULL,
  `customer_phone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`customer_id`));

CREATE TABLE `orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date_time` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`));

CREATE TABLE `pizzas` (
  `pizza_id` INT NOT NULL AUTO_INCREMENT,
  `pizza_type` VARCHAR(50) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`pizza_id`));

CREATE TABLE `customers_orders` (
  `customer_id` INT NOT NULL,
  `order_id` INT NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`));
    
CREATE TABLE `orders_pizzas` (
  `order_id` INT NOT NULL,
  `pizza_id` INT NOT NULL,
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
    FOREIGN KEY (`pizza_id`) REFERENCES `pizzas` (`pizza_id`));

-- Q3: Populate your database with three orders
INSERT INTO customers (customer_name, customer_phone)
VALUES ('Trevor Page', '226-555-4982');

INSERT INTO customers (customer_name, customer_phone)
VALUES ('John Doe', '555-555-9498');

INSERT INTO pizzas (pizza_type, price)
VALUES ('Pepperoni and Cheese', 7.99);

INSERT INTO pizzas (pizza_type, price)
VALUES ('Vegetarian', 9.99);

INSERT INTO pizzas (pizza_type, price)
VALUES ('Meat Lover', 14.99);

INSERT INTO pizzas (pizza_type, price)
VALUES ('Hawaiian', 12.99);

INSERT INTO orders (order_date_time)
VALUES ('2014-10-09 09:47:00');

INSERT INTO orders (order_date_time)
VALUES ('2014-10-09 13:20:00');

INSERT INTO orders (order_date_time)
VALUES ('2014-10-09 09:47:00');

INSERT INTO customers_orders (customer_id, order_id)
VALUES (1, 1);

INSERT INTO customers_orders (customer_id, order_id)
VALUES (2, 2);

INSERT INTO customers_orders (customer_id, order_id)
VALUES (1, 3);

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (1, 1);

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (1, 3);

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (2, 2);

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (2, 3);

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (3, 3);

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (3, 4);

-- CHECKPOINT
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM pizzas;
SELECT * FROM customers_orders;
SELECT * FROM orders_pizzas;

SELECT customer_id, COUNT(*) AS num_pizzas
FROM customers_orders
JOIN orders_pizzas ON order_id = order_id
GROUP BY customer_id;

-- Q4: Now the restaurant would like to know which customers are spending the most money at their establishment. 
-- Write a SQL query which will tell them how much money each individual customer has spent at their restaurant
SELECT customers.customer_name, SUM(pizzas.price) AS total_spent
FROM customers
JOIN customers_orders ON customers.customer_id = customers_orders.customer_id
JOIN orders ON customers_orders.order_id = orders.order_id
JOIN orders_pizzas ON orders.order_id = orders_pizzas.order_id
JOIN pizzas ON orders_pizzas.pizza_id = pizzas.pizza_id
GROUP BY customers.customer_name;

-- Q5: Modify the query from Q4 to separate the orders not just by customer, 
-- but also by date so they can see how much each customer is ordering on which date.
SELECT customers.customer_name, DATE(orders.order_date_time) AS order_date, 
       SUM(pizzas.price) AS total_spent
FROM customers
JOIN customers_orders ON customers.customer_id = customers_orders.customer_id
JOIN orders ON customers_orders.order_id = orders.order_id
JOIN orders_pizzas ON orders.order_id = orders_pizzas.order_id
JOIN pizzas ON orders_pizzas.pizza_id = pizzas.pizza_id
GROUP BY customers.customer_name, order_date;

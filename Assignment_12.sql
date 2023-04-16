-- Assignment #12 for Coders Campus Bootcamp
-- By: Kenny Cheng

CREATE DATABASE assignment_12;
USE assignment_12;

CREATE TABLE `customers` (
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`customer_id`));
  
ALTER TABLE `customers` 
ADD COLUMN `customer_phone` VARCHAR(20) NOT NULL AFTER `customer_name`;

CREATE TABLE `orders` (
  `order_id` INT NOT NULL,
  `order_date_time` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`));

CREATE TABLE `pizzas` (
  `pizza_id` INT NOT NULL,
  `pizza_type` VARCHAR(50) NOT NULL,
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

INSERT INTO customers (customer_id, customer_name, customer_phone)
VALUES (1, 'Trevor Page', '226-555-4982');

INSERT INTO customers (customer_id, customer_name, customer_phone)
VALUES (2, 'John Doe', '555-555-9498');

INSERT INTO pizzas (pizza_id, pizza_type)
VALUES (1, 'Pepperoni and Cheese');

INSERT INTO pizzas (pizza_id, pizza_type)
VALUES (2, 'Vegetarian');

INSERT INTO pizzas (pizza_id, pizza_type)
VALUES (3, 'Meat Lover');

INSERT INTO pizzas (pizza_id, pizza_type)
VALUES (4, 'Hawaiian');

ALTER TABLE `pizzas` 
ADD COLUMN `price` DECIMAL(6,2) NOT NULL AFTER `pizza_type`;

UPDATE pizzas
SET price = 7.99
WHERE pizza_id = 1;

UPDATE pizzas
SET price = 9.99
WHERE pizza_id = 2;

UPDATE pizzas
SET price = 14.99
WHERE pizza_id = 3;

UPDATE pizzas
SET price = 12.99
WHERE pizza_id = 4;

INSERT INTO orders (order_id, order_date_time)
VALUES (1, '2014-10-09 09:47:00');

INSERT INTO orders (order_id, order_date_time)
VALUES (2, '2014-10-09 13:20:00');

INSERT INTO orders (order_id, order_date_time)
VALUES (3, '2014-10-09 09:47:00');

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

SELECT * FROM orders_pizzas;
DELETE FROM orders_pizzas
WHERE order_id = 2
AND pizza_id = 2;

SELECT * FROM customers_orders;
DELETE FROM customers_orders;

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (2, 3);

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (3, 3);

INSERT INTO orders_pizzas (order_id, pizza_id)
VALUES (3, 4);

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM pizzas;
SELECT * FROM customers_orders;
SELECT * FROM orders_pizzas;

SELECT * FROM customers
JOIN customers_orders ON customers.customer_id = customers_orders.order_id
JOIN orders ON customers_orders.customer_id = orders.order_id
JOIN orders_pizzas ON orders.order_id = orders_pizzas.pizza_id
JOIN pizzas ON orders_pizzas.pizza_id = pizzas.pizza_id;

SELECT customers.customer_name, SUM(pizzas.price) AS total_spent
FROM customers
JOIN customers_orders ON customers.customer_id = customers_orders.customer_id
JOIN orders ON customers_orders.order_id = orders.order_id
JOIN orders_pizzas ON orders.order_id = orders_pizzas.order_id
JOIN pizzas ON orders_pizzas.order_id = pizzas.pizza_id
GROUP BY customers.customer_name;
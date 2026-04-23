/* 
===============================================================
DDL Script: Inserting values to 'EcomPractice' Database
===============================================================
Script Purpose:
  This script creates tables in the 'EcomPractice' database , dropping existing tables
  if they already exist.
Run this script to re-define the DDL structure of 'EcomPractice' Database Tables
===============================================================
*/




-- Create DDL for Tables
-- DDL defines the structure of database tables


-- Customers
IF OBJECT_ID('Customers', 'U') IS NOT NULL 
	DROP TABLE Customers;
CREATE TABLE Customers (
  customer_id  INT PRIMARY KEY,
  full_name    VARCHAR(100),
  email        VARCHAR(100),
  city         VARCHAR(50),
  country      VARCHAR(50),
  signup_date  DATE,
  is_premium   BIT DEFAULT 0
);

-- Products
IF OBJECT_ID('Products', 'U') IS NOT NULL
	DROP TABLE Products
CREATE TABLE Products (
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(100),
  category     VARCHAR(50),
  price        DECIMAL(10,2),
  cost         DECIMAL(10,2),
  stock_qty    INT,
  is_active    BIT DEFAULT 1
);

-- Orders
IF OBJECT_ID('Orders', 'U') IS NOT NULL
	DROP TABLE Orders
CREATE TABLE Orders (
  order_id      INT PRIMARY KEY,
  customer_id   INT FOREIGN KEY REFERENCES Customers(customer_id),
  order_date    DATE,
  status        VARCHAR(20), -- 'completed','pending','cancelled'
  shipping_city VARCHAR(50),
  discount_pct  DECIMAL(5,2) DEFAULT 0
);

-- Order Items
IF OBJECT_ID('Order_Items', 'U') IS NOT NULL
	DROP TABLE Order_Items
CREATE TABLE Order_Items (
  item_id    INT PRIMARY KEY,
  order_id   INT FOREIGN KEY REFERENCES Orders(order_id),
  product_id INT FOREIGN KEY REFERENCES Products(product_id),
  quantity   INT,
  unit_price DECIMAL(10,2)
);

-- Reviews
IF OBJECT_ID('Reviews', 'U') IS NOT NULL
	DROP TABLE Reviews
CREATE TABLE Reviews (
  review_id   INT PRIMARY KEY,
  customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
  product_id  INT FOREIGN KEY REFERENCES Products(product_id),
  rating      TINYINT CHECK (rating BETWEEN 1 AND 5),
  review_date DATE
);

-- Returns
IF OBJECT_ID('Returns', 'U') IS NOT NULL
	DROP TABLE Returns
CREATE TABLE Returns (
  return_id   INT PRIMARY KEY,
  order_id    INT FOREIGN KEY REFERENCES Orders(order_id),
  product_id  INT FOREIGN KEY REFERENCES Products(product_id),
  return_date DATE,
  reason      VARCHAR(200)
);

-- Sample data
INSERT INTO Customers VALUES
(1,'Ali Mammadov','ali@email.com','Baku','Azerbaijan','2022-01-15',1),
(2,'Sara Johnson','sara@email.com','London','UK','2022-03-20',0),
(3,'James Lee','james@email.com','New York','USA','2022-06-01',1),
(4,'Leyla Hasanova','leyla@email.com','Baku','Azerbaijan','2023-01-10',0),
(5,'Carlos Ruiz','carlos@email.com','Madrid','Spain','2023-04-05',1),
(6,'Anna Petrova','anna@email.com','Moscow','Russia','2021-11-22',0),
(7,'Wei Zhang','wei@email.com','Shanghai','China','2022-08-14',1),
(8,'Fatima Al-Hassan','fatima@email.com','Dubai','UAE','2023-02-28',0),
(9,'Tom Brown','tom@email.com','London','UK','2021-05-17',1),
(10,'Mia Rossi','mia@email.com','Rome','Italy','2023-07-01',0);

INSERT INTO Products VALUES
(1,'Wireless Headphones','Electronics',89.99,42.00,150,1),
(2,'Running Shoes','Footwear',65.00,28.00,300,1),
(3,'Coffee Maker','Kitchen',45.50,18.00,80,1),
(4,'Yoga Mat','Sports',25.00,9.00,200,1),
(5,'Laptop Stand','Electronics',35.00,14.00,120,1),
(6,'Water Bottle','Sports',15.00,5.00,500,1),
(7,'Desk Lamp','Home',28.00,11.00,90,1),
(8,'Bluetooth Speaker','Electronics',55.00,24.00,60,1),
(9,'Backpack','Accessories',75.00,32.00,110,1),
(10,'Smart Watch','Electronics',199.99,95.00,40,1),
(11,'Old Keyboard','Electronics',20.00,8.00,0,0),
(12,'Sunglasses','Accessories',40.00,15.00,75,1);

INSERT INTO Orders VALUES
(1,1,'2024-01-05','completed','Baku',0),
(2,2,'2024-01-12','completed','London',10),
(3,3,'2024-01-20','completed','New York',0),
(4,1,'2024-02-01','completed','Baku',5),
(5,4,'2024-02-14','cancelled','Baku',0),
(6,5,'2024-02-20','completed','Madrid',0),
(7,2,'2024-03-01','completed','London',15),
(8,6,'2024-03-10','pending','Moscow',0),
(9,7,'2024-03-15','completed','Shanghai',0),
(10,3,'2024-03-22','completed','New York',10),
(11,8,'2024-04-01','completed','Dubai',0),
(12,9,'2024-04-05','cancelled','London',0),
(13,1,'2024-04-10','completed','Baku',0),
(14,10,'2024-04-15','pending','Rome',0),
(15,5,'2024-05-01','completed','Madrid',20);

INSERT INTO Order_Items VALUES
(1,1,1,1,89.99),(2,1,5,2,35.00),(3,2,2,1,65.00),
(4,2,4,1,25.00),(5,3,10,1,199.99),(6,4,3,1,45.50),
(7,4,6,3,15.00),(8,5,9,1,75.00),(9,6,8,1,55.00),
(10,6,4,2,25.00),(11,7,1,1,89.99),(12,7,7,1,28.00),
(13,8,2,2,65.00),(14,9,12,1,40.00),(15,9,6,2,15.00),
(16,10,10,1,199.99),(17,11,3,1,45.50),(18,12,9,1,75.00),
(19,13,5,1,35.00),(20,13,8,1,55.00),(21,14,4,3,25.00),
(22,15,1,2,89.99),(23,15,2,1,65.00);

INSERT INTO Reviews VALUES
(1,1,1,5,'2024-01-10'),(2,2,2,4,'2024-01-18'),
(3,3,10,5,'2024-01-25'),(4,1,3,3,'2024-02-05'),
(5,5,8,5,'2024-02-25'),(6,7,12,4,'2024-03-20'),
(7,3,10,4,'2024-03-28'),(8,2,1,5,'2024-03-05'),
(9,8,3,2,'2024-04-06'),(10,6,2,3,'2024-03-15');

INSERT INTO Returns VALUES
(1,2,2,'2024-01-20','Wrong size'),
(2,7,1,'2024-03-10','Defective'),
(3,10,10,'2024-04-01','Not as described'),
(4,5,9,'2024-02-20','Changed mind');

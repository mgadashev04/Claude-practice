-- The marketing team wants a full list of all customers to prepare an export.
-- Task 1: Return all columns from the Customers table.
SELECT * FROM Customers;


-- The product team wants to see only products currently available for sale.
-- Task 2: Return product_name, category, and price for all active products.
SELECT product_name, category, price
FROM Products
WHERE is_active = 1;

-- The finance team needs all orders from the first quarter of 2024.
-- Task 3: Return order_id, customer_id, order_date, and status for orders placed between Jan 1 and Mar 31 2024.
SELECT 
order_id,
customer_id,
order_date,
status
FROM Orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-03-31'

  
-- Loyalty team wants to send a special offer to premium customers.
-- Task 4: Return full_name and email for all premium customers. Rename full_name to Customer.
SELECT
full_name AS Customers,
email
FROM Customers

  
-- A budget-focused campaign needs cheap products to feature.
-- Task 5: Return product_name and price for all products priced below 30, sorted cheapest first.
SELECT 
product_name,
price
FROM Products
WHERE price < 30
ORDER BY price ASC

  
-- The CEO asks: how many customers do we have in total?
-- Task 6: Return a single number: the total count of customers.
SELECT 
COUNT(*) AS total_customers
FROM Customers

  
-- Operations team wants to know how many orders are completed, pending, and cancelled.
-- Task 7: Return status and the count of orders for each status.
SELECT 
status,
COUNT(*) AS total_status
FROM Orders
GROUP BY status

  
-- Finance wants the gross revenue — sum of quantity × unit_price across all items.
-- Task 9: Return total_revenue as a single number.
SELECT 
SUM(stock_qty * cost) AS total_revenue
FROM Products 

  
-- A campaign is targeting two specific categories.
-- Task 9: Task: Return product_name and category for products in Electronics or Kitchen.
SELECT 
product_name,
category
FROM Products
WHERE category = 'Electronics' OR category = 'Kitchen'

  
-- WHERE category IN ('Electronics', 'Kitchen)'
-- Regional sales wants all UK-based customers.
-- Task 10: Return full_name and city for all customers where country is UK. 
SELECT 
full_name,
city
FROM Customers
WHERE country = 'UK'

  
-- The homepage hero banner shows the top products by price.
-- Task 11: Return product_name and price for all active products, sorted most expensive first.
SELECT 
product_name,
price
FROM Products
WHERE is_active = 1
ORDER BY price DESC

  
-- Pricing team wants to understand the average price in each category.
-- Task 12: Task: Return category and avg_price, rounded to 2 decimal places.
SELECT
category,
ROUND(AVG(price) , 2) AS  avg_price
FROM Products
GROUP BY category

  
-- Finance needs to audit all orders where a discount was given.
-- Task 13: Return order_id, customer_id, and discount_pct for orders where discount_pct is greater than 0.
SELECT
order_id,
customer_id,
discount_pct
FROM Orders
WHERE discount_pct > 0

  
-- The gift guide page shows the five priciest items.
-- Task 14: Return the top 5 products by price, showing product_name and price.
SELECT TOP 5
product_name,
price
FROM Products
ORDER BY price DESC

  
-- The retention team wants to target customers who are entering their second year.
-- Task 15: Task: Return full_name and signup_date for customers who signed up in 2023.
SELECT 
full_name,
signup_date
FROM Customers
WHERE YEAR(signup_date) = 2023

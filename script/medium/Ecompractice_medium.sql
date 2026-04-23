
-- #16 Customer name on every order
-- The orders report needs to show the customer's name alongside each order.
-- Task: Return order_id, full_name, order_date, and status by joining Orders to Customers.


SELECT
o.order_id,
c.full_name,
o.order_date,
o.status
FROM Orders as o
LEFT JOIN Customers as c
ON o.customer_id = c.customer_id


-- #17 Every product sold with its order
-- The sales report needs order details combined with product names.
-- Task Return order_id, order_date, product_name, quantity, 
-- and unit_price by joining Orders, Order_Items, and Products.


SELECT
o.order_id,
o.order_date,
p.product_name,
oi.quantity,
oi.unit_price
FROM Orders AS o
LEFT JOIN Order_Items as oi
ON o.order_id = oi.order_id
LEFT JOIN Products AS p
ON oi.product_id = p.product_id

-- #18 Customers who have never ordered
-- Re-engagement teams wants customers who signed up but never placed an order
-- Task Return full_name and email for customers with no orders

SELECT
c.full_name,
c.email
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL

-- #19 Revenue per customer
-- Account managers want to see total spend per customer
-- Task: Return full_name and total_spent (quantity * unit_price), sorted highest to lowest

SELECT
c.full_name,
SUM(oi.quantity * oi.unit_price) AS total_spent
FROM Customers AS c
LEFT JOIN Order_Items AS oi
ON c.customer_id = oi.order_id
GROUP BY c.full_name
ORDER BY total_spent DESC



-- #20 Items per order with order total
-- The packing team wants to know how many items and the total value for each order
-- Task: Return order_id, count of items(Item_count), and order total (order_total) for each order

SELECT 
order_id,
COUNT(item_id) AS item_count,
SUM(quantity * unit_price) AS order_total
FROM Order_Items
GROUP BY order_id

-- #21 Categories with more than 2 products
-- Catalogue team want to find well-stocked categories
-- Task: Return category and product_count for categories that have more than 2 active products

SELECT 
Category,
COUNT(*) AS product_count
FROM Products
WHERE is_active = 1
GROUP BY Category
HAVING COUNT(*) > 2

-- #22 Monthly order count in 2024
-- Trend report needs to show how many orders were placed each month
-- Task: return order_month, as (YYYY-MM) and order_count, sorted chronologically

SELECT 
FORMAT(order_date, 'yyyy-MM') AS order_month,
COUNT(*) AS order_count
FROM Orders
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY order_month DESC

-- #23 Profit margin per product
-- Finance want to see each products margin and flag high vs low margin items
-- Task: Return product_name, margin_pct(rounded to 1 decimal), and margin_tier column
-- 'high' if: above 50%, else 'low'


SELECT
product_name,
ROUND((price - cost) * 100 / price, 1) AS margin_pct,
CASE
	WHEN (price - cost) * 100 / price > 50 THEN 'High'
	ELSE 'Low'
	END AS margin_tier
FROM Products

-- #24 Average rating per product
-- The product page shows a star rating.Calculate it 
-- from the Reviews table
-- Task: Return product_name and avg_rating (rounded
-- to 1 decimal for products that have at least one review



SELECT 
p.product_name,
ROUND(AVG(r.rating), 1) AS avg_rating
FROM Products AS p
LEFT JOIN Reviews AS r
ON p.product_id = r.product_id
WHERE r.rating IS NOT NULL
GROUP BY p.product_name

-- #25 Orders with full customer and total
-- The management dashboard needs one row per order
-- customer name, date, status and order value
-- Task: Return order_id, fullname, order_date, status
-- and order_total


SELECT 
o.order_id,
c.full_name,
o.order_date,
o.status,
SUM(oi.quantity * oi.unit_price) AS order_total
FROM Customers AS c
LEFT JOIN Orders as o
ON c.customer_id = o.customer_id
LEFT JOIN Order_Items as oi
ON oi.order_id = o.order_id
GROUP BY o.order_id, c.full_name,
o.order_date,
o.status
 ORDER BY order_id

 -- #26 Products never ordered
 -- Inventory team wants to identify dead stock 
 -- products that have never been sold
 -- Task: Return product_name and category for
 -- products with no entries in Order Items


 SELECT 
 p.product_name,
 p.category
 FROM Products AS p
 LEFT JOIN Order_Items AS oi
 ON p.product_id = oi.product_id
 WHERE oi.product_id IS NULL
  

-- #27 Return rate per product
-- Quality team wants to see which
-- products are being returned most often 
-- Task: Return product_name, times_sold,
-- times_returned, and return_rate (%) rounded 
-- to 1 decimal

SELECT
p.product_name,
COUNT(DISTINCT oi.item_id) AS times_sold,
COUNT(DISTINCT r.return_id) AS times_returned,
ROUND(COUNT(DISTINCT r.return_id) * 100.0 / NULLIF(COUNT(DISTINCT oi.item_id),0 ), 1 ) AS return_rate
FROM Products AS p
LEFT JOIN Order_Items AS oi
ON p.product_id = oi.product_id
LEFT JOIN Returns AS r
ON p.product_id = r.product_id
GROUP BY p.product_name


-- #28 Customers with more than one order
-- VIP team defines a returning customer as
-- someone with 2 or more orders
-- Task: Return full_name and order_count for 
-- customers who placed more than one order

SELECT 
c.full_name,
COUNT(o.order_id) AS order_count
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.customer_id = o.customer_id
GROUP BY full_name
HAVING COUNT(o.order_id) > 1


-- #29 Revenue by country 
-- Geographic sales report needs total revenue broken
-- down by customer country
-- Task: Return country and total_revenue, sorted highest to lowest

SELECT 
c.country,
SUM(oi.quantity * unit_price) AS total_revenue
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.customer_id = o.order_id
LEFT JOIN Order_Items AS oi
ON o.order_id = oi.product_id
GROUP BY c.country
ORDER BY total_revenue DESC

-- #30 Low stock alert
-- Warehouse system needs to flag products running low
-- on stock
-- Task: Return product_name, category, stocky_qty,
-- for active products with fewer than 70 units
-- sorted by stock_qty ascending


SELECT product_name, 
category,
stock_qty
FROM Products
WHERE stock_qty < 70 AND is_active = 1
ORDER BY stock_qty ASC

-- #31 Cancelled order value lost
-- Finance wants to know how much revenue was lost 
-- to cancelled orders
-- Task: Return total_cancelled_value -
-- sum of order items belonging to cancelled orders

SELECT 
SUM(oi.unit_price * oi.quantity) AS total_cancelled_value
FROM Orders AS o
LEFT JOIN Order_Items as oi
ON o.order_id = oi.order_id
WHERE status = 'cancelled'

-- #32 Best reviewed product category
-- Marketing wants to feature the highest rated product in a
-- campaign
-- Task: Return category, avg_rating sorted best to worst

SELECT 
p.category,
AVG(r.rating) AS avg_rating
FROM Products AS p
LEFT JOIN Reviews AS r
ON p.product_id = r.product_id
GROUP BY p.category
ORDER BY avg_rating DESC

-- #33 First order date per customer
-- CRM team wants to know when each customer first
-- purchased 
-- Task: Return full_name and first_order_date for
-- customers who have at least one completed order

SELECT 
c.full_name,
MIN(o.order_date) AS first_order_date
FROM Customers AS c
LEFT JOIN Orders AS o
ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.full_name

-- #34 Products with below-average price
-- Deals page needs products that are priced below
-- the store's overall average
-- Task: Return product_name and price or active products 
-- priced below the average product price

SELECT
	p.product_name,
	p.price
FROM Products AS p
WHERE p.is_active = 1 
	AND price < (SELECT AVG(price) FROM Products WHERE is_active = 1)
	ORDER BY price DESC

SELECT * FROM Orders
SELECT * FROM Products

-- Revenue with discount applied 
-- Finance nneds actual collected revenue
-- applying each order's discount to its items
-- Task: Return order_id, and net_revenue,
-- where net_revenue = order total * (1 - discount_pct/100)


SELECT 
o.order_id,
SUM(oi.quantity * oi.unit_price * (1 - o.discount_pct / 100)) AS net_revenue
FROM Orders AS o
LEFT JOIN Order_Items AS oi
ON o.order_id = oi.order_id
GROUP BY o.order_id


SELECT *
FROM Orders

SELECT *
FROM Order_Items

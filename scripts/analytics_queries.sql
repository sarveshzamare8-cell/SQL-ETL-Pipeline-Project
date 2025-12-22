
-- 1. Total Revenue
SELECT SUM(price) AS total_revenue
FROM production_clean;


-- 2. Revenue by Country
SELECT country, SUM(price) AS total_revenue
FROM production_clean
GROUP BY country
ORDER BY total_revenue DESC;


-- 3. Top 10 Customers by Spending
SELECT name, SUM(price) AS total_spent
FROM production_clean
GROUP BY name
ORDER BY total_spent DESC
LIMIT 10;


-- 4. Orders Count by Payment Method
SELECT payment_method, COUNT(*) AS total_orders
FROM production_clean
GROUP BY payment_method
ORDER BY total_orders DESC;


-- 5. Most Purchased Product
SELECT product, COUNT(*) AS total_purchases
FROM production_clean
GROUP BY product
ORDER BY total_purchases DESC
LIMIT 1;


-- 6. Average Order Value
SELECT AVG(price) AS average_order_value
FROM production_clean;


-- 7. Orders by Country
SELECT country, COUNT(*) AS total_orders
FROM production_clean
GROUP BY country
ORDER BY total_orders DESC;


-- 8. Revenue by Product
SELECT product, SUM(price) AS product_revenue
FROM production_clean
GROUP BY product
ORDER BY product_revenue DESC;
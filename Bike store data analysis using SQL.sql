--1.Total sales by year.
SELECT YEAR(orders.order_date) AS year, 
	SUM(order_items.list_price * order_items.quantity) AS total_sales
FROM orders
JOIN order_items ON order_items.order_id = orders.order_id
GROUP BY YEAR(orders.order_date)
ORDER BY year;

--2.Total sales by month.
SELECT YEAR(orders.order_date) AS year, MONTH(orders.order_date) AS month, 
	SUM(order_items.list_price * order_items.quantity) AS total_sales
FROM orders
JOIN order_items ON order_items.order_id = orders.order_id
GROUP BY YEAR(orders.order_date), MONTH(orders.order_date)
ORDER BY year, month;

--3.Total sales by day.
SELECT orders.order_date, 
	SUM(order_items.list_price * order_items.quantity) AS total_sales
FROM orders
JOIN order_items ON order_items.order_id = orders.order_id
GROUP BY orders.order_date
ORDER BY total_sales DESC;

--4.Top selling products by quantity.
SELECT products.product_name, 
	SUM(CONVERT(INT, order_items.quantity)) AS total_sold
FROM products
JOIN order_items ON order_items.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_sold DESC;

--5.Top selling products by revenue.
SELECT products.product_name, 
	SUM(order_items.list_price * order_items.quantity) AS total_revenue
FROM products
JOIN order_items ON order_items.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_revenue DESC;

--6.Sales performance by different stores.
SELECT stores.store_name, 
	SUM(order_items.list_price * order_items.quantity) AS total_sales
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
JOIN stores ON orders.store_id = stores.store_id
GROUP BY stores.store_name
ORDER BY total_sales DESC;

--7.Discount offered on each product and total discount given.
SELECT products.product_name, 
	SUM(order_items.discount) AS total_discount
FROM order_items
JOIN products ON order_items.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_discount DESC;

--8.Number of bikes in stock for each category.
SELECT categories.category_name, 
	SUM(CONVERT(INT, stocks.quantity)) AS total_stock
FROM stocks
JOIN products ON products.product_id = stocks.product_id
JOIN categories ON products.category_id = categories.category_id
GROUP BY categories.category_name
ORDER BY total_stock DESC;

--9.Average price of bikes in each category.
SELECT categories.category_name, 
	AVG(products.list_price) AS average_price
FROM products
JOIN categories ON products.category_id = categories.category_id
GROUP BY categories.category_name
ORDER BY average_price DESC;

--10.List all products with a price below a certain threshold.
SELECT product_name, list_price
FROM products
WHERE list_price < 100; -- Replace 100 with the desired threshold.

--11.List all discontinued products (if a discontinued flag exists).
SELECT products.product_name
FROM products;

--12.Number of customers by city/state/country.
SELECT customers.city, customers.state, COUNT(*) AS total_customer
FROM customers
GROUP BY customers.city, customers.state
ORDER BY total_customer DESC;

--13.Most frequent buying customers.
SELECT customers.first_name, customers.last_name, 
	COUNT(orders.order_id) AS toal_order
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.first_name, customers.last_name
ORDER BY toal_order DESC;

--14.Total spending of each customer.
SELECT c.first_name, c.last_name, 
    SUM(oi.list_price * oi.quantity) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.first_name, c.last_name
ORDER BY total_spending DESC;

--15.Average order value per customer.
SELECT c.first_name, c.last_name, 
    AVG(oi.list_price * oi.quantity) AS average_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.first_name, c.last_name
ORDER BY average_order_value DESC;

--16.List of products with low stock.
SELECT p.product_name, 
    SUM(CONVERT(INT,s.quantity)) AS total_stock
FROM stocks s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(CONVERT(INT,s.quantity)) < 10 -- Replace 10 with the desired threshold.
ORDER BY total_stock ASC;

--17.Inventory value by product category.
SELECT c.category_name, 
    SUM(s.quantity * p.list_price) AS inventory_value
FROM stocks s
JOIN products p ON s.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY inventory_value DESC;

--18.Total stock value of the store.
SELECT st.store_name, 
    SUM(s.quantity * p.list_price) AS total_stock_value
FROM stocks s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id
GROUP BY st.store_name
ORDER BY total_stock_value DESC;

--19.Most popular brands among customers.
SELECT b.brand_name, 
    COUNT(oi.product_id) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY total_sold DESC;

--20.Find the most profitable product categories.
SELECT c.category_name, 
    SUM(oi.list_price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;






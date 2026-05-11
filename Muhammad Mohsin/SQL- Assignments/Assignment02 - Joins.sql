-- ============================================================
--  ASSIGNMENT 02 — Joins
--  Database : BikeStores
-- ============================================================


-- ============================================================
--  Question 1
--  Retrieve the product_name, list_price, and category_name
--  for every product.
--  Use production.products and production.categories.
--  Sort the results by product_name ascending.
-- ============================================================

-- Write your query below:

SELECT pd.product_name, pd.list_price, pc.category_name 
FROM production.products pd
INNER JOIN production.categories pc ON pd.category_id = pc.category_id
order by pd.product_name asc

-- ============================================================
--  Question 2
--  Show the customer full name (as full_name), order_id,
--  and order_date for all customers who have placed an order.
--  Use sales.customers and sales.orders.
--  Sort by order_date descending.
-- ============================================================

-- Write your query below:

SELECT SCR.first_name + SCR.last_name  AS FULL_NAME, SDR.order_id, SDR.order_date
FROM sales.customers SCR
INNER JOIN sales.orders SDR
ON SCR.customer_id = SDR.customer_id ORDER BY SDR.order_date DESC

-- ============================================================
--  Question 3
--  Retrieve product_name, list_price, category_name, and
--  brand_name for every product.
--  Use production.products, production.categories,
--  and production.brands.
--  Sort by brand_name then product_name (both ascending).
-- ============================================================

-- Write your query below:

SELECT  pp.product_name, pp.list_price, pc.category_name, pd.brand_name FROM 
production.products pp 
inner join production.categories pc 
ON pp.category_id = pc.category_id
inner join production.brands pd 
ON pp.brand_id = pd.brand_id
order by pd.brand_name ASC, PP.product_name ASC 

-- ============================================================
--  Question 4
--  List all products along with their order_id and item_id.
--  Make sure products that have NEVER been ordered also appear
--  in the result (those rows will have NULL for order_id
--  and item_id).
--  Use production.products and sales.order_items.
--  Sort by order_id ascending.
-- ============================================================

-- Write your query below:
SELECT pp.product_name, so.order_id, so.item_id  
FROM production.products pp 
LEFT JOIN sales.order_items so 
ON pp.product_id = so.product_id
ORDER BY so.order_id ASC


-- ============================================================
--  Question 5
--  Using your answer from Question 4 as a base, filter the
--  results to show ONLY the products that have never been
--  ordered.
--  Display only product_id and product_name.
-- ============================================================

-- Write your query below:
SELECT pp.product_name, so.order_id, so.item_id  
FROM production.products pp 
LEFT JOIN sales.order_items so 
ON pp.product_id = so.product_id
WHERE so.order_id IS NULL
ORDER BY so.order_id ASC



-- ============================================================
--  Question 6
--  Show all stores along with any orders placed at each store.
--  Display store_name, store_id (from stores), order_id,
--  and order_date.
--  Every store must appear in the result, even if it has
--  no orders yet.
--  Use sales.orders and sales.stores.
-- ============================================================

-- Write your query below:
SELECT sts.store_name, sts.store_id, sod.order_date
FROM sales.stores sts
LEFT JOIN sales.orders sod
ON sts.store_id = sod.store_id

-- ============================================================
--  Question 7
--  List every staff member alongside their manager's name.
--  Display:
--    • staff full name   (as staff_name)
--    • manager full name (as manager_name)
--  Use only the sales.staffs table.
--  Staff who have no manager should NOT appear in the result.
-- ============================================================

-- Write your query below:
SELECT emp.first_name + ' ' + emp.last_name AS Staff_Name, 
mng.first_name + ' ' + mng.last_name AS Manager_Name
FROM sales.staffs emp 
inner join sales.staffs mng
ON emp.staff_id = mng.manager_id


-- ============================================================
--  Question 8
--  Generate every possible combination of store name and
--  brand name.
--  Display store_name and brand_name.
--  Use sales.stores and production.brands.
--  How many total rows do you expect?
--  Write the expected count as a comment next to your query.
-- ============================================================

-- Write your query below:

SELECT ss.store_name, pb.brand_name
FROM sales.stores AS ss
CROSS JOIN production.brands pb

-- there are 3 stores and 9 brands 
-- so the total records will be 27

-- ============================================================
--  Question 9
--  Retrieve the customer full name (as full_name), order_id,
--  order_date, product_name, and list_price for every order
--  that has been placed.
--  Use sales.customers, sales.orders, sales.order_items,
--  and production.products.
--  Sort by order_date ascending, then full_name ascending.
-- ============================================================

-- Write your query below:
SELECT sc.first_name + ' ' + sc.last_name AS Full_Name,
so.order_id, so.order_date,
pp.product_name,
oi.list_price
FROM sales.customers AS SC
inner join sales.orders so ON sc.customer_id = so.customer_id
inner join sales.order_items OI ON so.order_id = oi.order_id
inner join production.products pp ON oi.product_id = pp.product_id
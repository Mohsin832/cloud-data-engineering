SELECT sc.first_name + ' ' + sc.last_name as full_name ,
sum(oi.quantity * oi.list_price * (1- oi.discount)) as total_spent
FROM sales.customers  as sc
inner join sales.orders as so
ON sc.customer_id = so.customer_id
inner join sales.order_items oi
ON so.order_id = oi.order_id
group by sc.first_name, sc.last_name
HAVING sum(oi.quantity * oi.list_price * (1- oi.discount)) > 10000
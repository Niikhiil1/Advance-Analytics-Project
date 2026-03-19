--Data segmentation

--group the data based on a specific range.
--it helps us to understand the correlation between two measures.

--example:
--1. total products by range
--2. total customers by age
select top 20 * from products;

select top 20 * from sales;

select top 20 * from customers;


select 
min(cost) as min_cost,
max(cost) as max_cost
from products;
--segment the products into cost ranges and count how many products fall into each segment.

with product_segments as(
select
product_key,
product_name,
cost,
case when cost < 100 then 'Below 100'
	when cost between 100 and 500 then '100-500'
	when cost between 500 and 1000 then '500-1000'
	when cost between 1000 and 1500 then '1000-1500'
	when cost between 1500 and 2000 then '1500-2000'
	else 'above 2000'
end cost_range
from products)

select 
cost_range,
count(product_key) as total_products
from product_segments
group by cost_range;

--group customers in three segments bassed on their spending behaviour 
--vip: atleast 12 months of history and spending more then 5000
--regular: atleatr 12 months of history and spending 5000 and less
--new: lifespan less than 12 months
--and find total number of customers in each group.

with customer_segment as(
select 
c.customer_key,
sum(s.sales_amount) as total_spending,
max(s.order_date) as lastt_order,
min(s.order_date) as first_order,
datediff(month, min(s.order_date), max(s.order_date)) as lifespan
from sales s
left join customers c
on s.customer_key = c.customer_key
group by c.customer_key)

select 
count(customer_key) as total_customers,
filtered_data 
from(
select 
customer_key,
case when lifespan >= 12 and total_spending > 5000 then 'VIP'
	 when lifespan >= 12 and total_spending between 3000 and 5000 then 'Regular'
	 else'New'
end as filtered_data
from customer_segment) t
group by filtered_data
order by total_customers;
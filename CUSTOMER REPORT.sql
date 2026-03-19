/*
Customer Report

===========================================================================

This report consolidates key customer metrices and behaviors.

============================================================================
Highlights:

1. Gathers essential fields such as names, ages, and transaction details.
2. Segments customers into categories(VIP, Regular, New) and aagegroups.
3. Aggregates customer-level metrices:
	-total orders
	-total sales
	-total quantity purchased
	-total products
	-lifespan
4. Calculate valuable KPIs:
	-recency(months since last order)
	-avg ordrer value
	-avg monthly spend

5. In the last putting this all in a view so that making a power bi report on this will be very easy and much more insightful.
*/

--1. Base Query: Retrives core columns from table.
--====================================================
--first ctes
create view dbo.report_customers as 

with base_query as(
select 
s.order_number, 
s.product_key,
s.order_date,
s.sales_amount,
s.quantity,
c.customer_key,
c.customer_number,
concat(c.first_name, ' ', c.last_name) as customer_name,
datediff(year, c.birthdate, getdate()) as age
from sales s 
left join customers c
on s.customer_key = c.customer_key
where order_date is not null)

--=======================================================
--second ctes
, customer_segmentation as(
select 
customer_key,
customer_number,
customer_name,
age,
count(distinct order_number) as total_orders,
sum(quantity) as total_quantity,
sum(sales_amount) as total_sales,
count(distinct product_key) as total_products,
max(order_date) as last_order_date,
datediff(month, min(order_date), max(order_date)) as lifespan
from base_query
group by 
	customer_key,
	customer_number,
	customer_name,
	age)

select
customer_key,
customer_number,
customer_name,
age,
case when lifespan >= 12 and total_sales > 5000 then 'VIP'
	 when lifespan >= 12 and total_sales <= 5000 then 'Regular'
	 else 'New'
end as customer_segmentation,
case when age < 20 then 'Under 20'
	 when age between 20 and 30 then '20-30'
	 when age between 30 and 40 then '30-40'
	 when age between 40 and 50 then '40-50'
	 else 'Above 50'
end as age_group,
total_sales,
total_products,
total_orders,
total_quantity, 
lifespan,
last_order_date,
--recency
datediff(month, last_order_date, getdate()) as recency,
--avg order value
case when total_orders = 0 then 0
	 else total_sales / total_orders 
end as avg_order_value,

--avg monthly spend
case when lifespan = 0 then total_sales
	 else total_sales / lifespan 
end as avg_monthly_spend
from customer_segmentation



select * from dbo.report_customers;
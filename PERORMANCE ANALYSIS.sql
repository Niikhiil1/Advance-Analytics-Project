--Performance Analysis

--It is the process of comparing the current value to the target value
--helps us measure success and compare performance

--example:
--1. 0current sales - avg sales
--2. current year sales - previous year sales
--3. YOY analysis

select top 20 * from sales;
select top 20 * from products;
--Analyze the yearly performance of products by comparing current sales to avg sales and previous year sales.


--year over year analysis
with yearly_sales as(
select
year(s.order_date) as order_year, 
p.product_name, 
sum(s.sales_amount) as current_sales
from sales s 
left join products p
on s.product_key = p.product_key
where order_date is not null
group by year(s.order_date),
p.product_name
)
select order_year,
product_name,
current_sales,
avg(current_sales) over(partition by product_name) as avg_sales,
current_sales - avg(current_sales) over (partition by product_name) as diff_avg,
lag(current_sales) over(partition by product_name order by order_year) as previous_year_sales,
current_sales - lag(current_sales) over(partition by product_name order by order_year) as diff_current_sales
from yearly_sales
order by product_name, order_year;


--month by month analysis
with monthly_analysis as(
select 
month(s.order_date) as order_month,
p.product_name,
sum(s.sales_amount) as current_sales
from sales s 
left join products p
on s.product_key = p.product_key
where order_date is not null
group by month(s.order_date),
p.product_name
)
select
order_month,
product_name,
avg(current_sales) over(partition by order_month) as avg_sales,
current_sales - avg(current_sales) over(partition by order_month) as diff_avg_sales,
lag(current_sales) over(partition by product_name order by order_month) as previos_sales,
current_sales - lag(current_sales) over(partition by product_name order by order_month) as diff_previos_sales,
current_sales
from monthly_analysis
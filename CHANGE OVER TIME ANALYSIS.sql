--change over time analysis

--it means how the measure evolves over the time.
--help tracks the trend and identify seasonality in your data.
--example :
-- 1. avg cost by month
-- 2. total sales by year.
-- trends

select top 20 * from [dbo].[sales];

-- chnage of time trend(total sales by order date.)
select 
order_date,
sum(sales_amount) as total_sales
from sales
where order_date is not null
group by order_date
order by order_date asc;


-- chnage of time trend(total sales by order year.)
select 
year(order_date) as order_year,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from sales
where order_date is not null
group by year(order_date)
order by year(order_date) asc;

--total sales by month

select
month(order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as totl_customer
from sales
where order_date is not null
group by month(order_date)
order by month(order_date);

--trend of ales over months and year

select
year(order_date) as order_year,
month(order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customer
from sales
where order_date is not null
group by year(order_date), month(order_date)
order by year(order_date), month(order_date);

--using datetrunc to get the month and year in same column
select 
DATETRUNC(month, order_date) as order_year,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers
from sales
where order_date is not null
group by DATETRUNC(month, order_date)
order by DATETRUNC(month, order_date)


--using format keyword to get the month name instead of numericals

select 
format(order_date, 'yyyy-MMM') as order_date,
sum(sales_amount) as total_sales,
count(distinct customer_key ) as total_customers
from  sales
where order_date is not null
group by format(order_date, 'yyyy-MMM')
order by format(order_date, 'yyyy-MMM')
--cumulative analysis

--it is aggregating the data progressively over time.
--in simple words it helps us to understand how our business is growing or declining

--examples:
--running total of sales by year
--moving avg of sales by month


select top(20) * from sales;
--calculate the total sales per month and running total of sales over time.
select 
order_month,
total_sales,
sum(total_sales) over( order by order_month ) as running_total
from
(
select 

datetrunc(month, order_date) as order_month,
sum(sales_amount) as total_sales
from sales
where order_date is not null
group by DATETRUNC(month, order_date)) t

-- in the above query it is giving the cumulative sum of all the years but if we want the cumulative running total of each year then we will use

select
order_month,
total_sales,
sum(total_sales) over(partition by order_month order by order_month) as running_total
from(

select 
sum(sales_amount) as total_sales,
datetrunc(month, order_date) as order_month
from
sales
where order_date is not null
group by DATETRUNC(month, order_date)) t

--moving avg of sales by month
select 
order_month, 
avg_price,
sum(avg_price) over(order by order_month) as moving_avg
from
(select 
datetrunc(month, order_date) as order_month,
avg(price) as avg_price
from sales
where order_date is not null
group by datetrunc(month, order_date)
)t
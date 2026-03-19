--Part_to_whole_anaysis or Propotional analysis

--analyze how an individual part is performing compared to overall.
--in simple words, it helps us to understand which category is making how much impact on the business.

select top 20 * from sales;
select top 20 * from products;
--which categories contribute the most to overall sales?
with category_sales as(
select 
p.category,
sum(s.sales_amount) as total_sales
from sales s
left join products p
on s.product_key = p.product_id
group by category)

select category,
total_sales,
sum(total_sales) over() as overall_sales,
concat(round((cast(total_sales as float)/ sum(total_sales) over()) * 100, 2), '%') as percentage_of_total
from category_sales
order by total_sales desc;
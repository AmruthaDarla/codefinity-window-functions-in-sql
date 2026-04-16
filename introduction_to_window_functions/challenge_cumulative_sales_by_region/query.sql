-- Write your code here
select sale_id,
sale_date,
employee_id,
region,
amount,
sum(amount) over(partition by region order by sale_date, sale_id) as cumulative_sales
from sales
order by region, sale_date, sale_id;
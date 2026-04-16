-- Write your code here
select sale_id,
sale_date,
employee_id,
amount,
avg(amount) over(partition by employee_id 
    order by sale_date 
    rows between 6 preceding and current row) as moving_avg_7d
from sales
order by employee_id, sale_date;
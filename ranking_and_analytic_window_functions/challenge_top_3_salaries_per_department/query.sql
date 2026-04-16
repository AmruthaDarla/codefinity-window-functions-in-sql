-- Write your code here
select employee_id,
name,
department,
salary
from (
    select employee_id,name,department, salary,
    rank() over(partition by department order by salary desc) as salary_rank 
from employees) as ranked
    where salary_rank<=3
order by department, salary desc, name;
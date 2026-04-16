-- Write your code here
select sale_id, sale_date, employee_id, amount, 
sum(amount) over(partition by employee_id order by sale_date) as running_total
    from sales
order by employee_id, sale_date, sale_id;
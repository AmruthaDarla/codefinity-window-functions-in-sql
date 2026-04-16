-- Write your code here
select e.employee_id, e.name,
p.review_date, p.score,
lag(p.score) over(partition by p.employee_id order by p.review_date) as previous__score,
    p.score-lag(p.score) over(partition by p.employee_id order by p.review_date) as score_difference
from employees e join performance p on e.employee_id=p.employee_id
order by e.employee_id, p.review_date;
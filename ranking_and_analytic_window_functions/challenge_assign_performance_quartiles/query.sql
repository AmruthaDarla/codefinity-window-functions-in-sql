SELECT
    e.employee_id,
    e.name,
    AVG(p.score) AS avg_score,
    NTILE(4) OVER (ORDER BY AVG(p.score) DESC) AS performance_quartile
FROM
    employees e
JOIN
    performance p ON e.employee_id = p.employee_id
GROUP BY
    e.employee_id,
    e.name
ORDER BY
    avg_score DESC;
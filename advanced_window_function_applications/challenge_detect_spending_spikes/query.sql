SELECT
    p.performance_id,
    p.employee_id,
    p.review_date,
    p.score,
    e.name,
    e.department,
    p.score AS transaction_amount,
    AVG(p.score) OVER (
        PARTITION BY p.employee_id
        ORDER BY p.review_date
        RANGE BETWEEN INTERVAL '12 months' PRECEDING AND INTERVAL '1 day' PRECEDING
    ) AS avg_last_12_months,
    CASE
        WHEN p.score >= 2 * AVG(p.score) OVER (
            PARTITION BY p.employee_id
            ORDER BY p.review_date
            RANGE BETWEEN INTERVAL '12 months' PRECEDING AND INTERVAL '1 day' PRECEDING
        )
        THEN 1
        ELSE 0
    END AS is_spike
FROM
    performance p
JOIN
    employees e ON p.employee_id = e.employee_id
ORDER BY
    p.employee_id,
    p.review_date;
-- Write your code here
WITH cohort_activity AS (
  SELECT
    e.employee_id,
    DATE_TRUNC('month', e.hire_date) AS signup_month,
    DATE_TRUNC('month', p.review_date) AS activity_month,
    CASE WHEN p.performance_id IS NOT NULL THEN TRUE ELSE FALSE END AS is_active
  FROM employees e
  LEFT JOIN performance p
    ON e.employee_id = p.employee_id
)
SELECT
  signup_month,
  activity_month,
  COUNT(DISTINCT CASE WHEN is_active THEN employee_id END) * 100.0
    / COUNT(DISTINCT employee_id) AS retention_rate
FROM cohort_activity
WHERE activity_month IS NOT NULL
GROUP BY signup_month, activity_month
ORDER BY signup_month, activity_month;

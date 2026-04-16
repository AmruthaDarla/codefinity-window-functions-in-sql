SELECT
  p.employee_id,
  p.review_date,
  p.score,
  (
    SELECT AVG(p2.score::numeric)
    FROM performance p2
    WHERE p2.employee_id = p.employee_id
      AND p2.review_date >= (date_trunc('month', p.review_date) - INTERVAL '2 months')
      AND p2.review_date <= p.review_date
  ) AS rolling_3_month_avg_score
FROM performance p
ORDER BY p.employee_id, p.review_date;
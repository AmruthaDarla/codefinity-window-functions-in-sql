SELECT
  e.employee_id,
  e.name,
  COALESCE(SUM(p.score), 0) AS total_score,
  COUNT(p.performance_id) AS review_count,
  NTILE(4) OVER (ORDER BY COALESCE(SUM(p.score),0) DESC)      AS score_quartile,
NTILE(4) OVER (ORDER BY COUNT(p.performance_id) DESC)      AS frequency_quartile

FROM
  employees e
LEFT JOIN
  performance p ON e.employee_id = p.employee_id
GROUP BY
  e.employee_id, e.name
ORDER BY
  e.employee_id;
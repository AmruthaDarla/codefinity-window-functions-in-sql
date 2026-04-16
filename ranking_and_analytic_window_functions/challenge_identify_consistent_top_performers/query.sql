WITH performance_with_quartile AS (
    SELECT
        p.*,
        NTILE(4) OVER (PARTITION BY p.review_date
                       ORDER BY p.score DESC) AS quartile
    FROM performance p
),
top_quartile AS (
    SELECT
        employee_id,
        review_date,
        ROW_NUMBER() OVER (PARTITION BY employee_id
                           ORDER BY review_date) AS rn
    FROM performance_with_quartile
    WHERE quartile = 1
),
consecutive AS (
    SELECT t1.employee_id
    FROM top_quartile t1
    JOIN top_quartile t2
      ON t1.employee_id = t2.employee_id
     AND t1.rn = t2.rn - 1
)
SELECT DISTINCT e.employee_id,
                e.name
FROM employees e
JOIN consecutive c
  ON e.employee_id = c.employee_id
ORDER BY e.employee_id;
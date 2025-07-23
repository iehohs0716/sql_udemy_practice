WITH products_total_saled AS (
  SELECT p.*
  , COALESCE(sum(product_qty),0) AS qty_total
  FROM my_db.products AS p
    LEFT OUTER JOIN my_db.order_details od ON od.product_id = p.id
  GROUP BY p.id
)
SELECT *, 
  CASE 
    WHEN qty_total < 10 THEN 'C'
    WHEN qty_total < 20 THEN 'B'
    ELSE 'A'
  END AS rnk
FROM products_total_saled
ORDER BY qty_total DESC, id ASC;
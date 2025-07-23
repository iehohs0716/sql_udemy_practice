SELECT
    p.*
    , COALESCE(sum(product_qty), 0) AS product_qty_total
FROM my_db.products p
LEFT OUTER JOIN my_db.order_details od 
ON od.product_id = p.id
GROUP BY p.id 
ORDER BY p.id
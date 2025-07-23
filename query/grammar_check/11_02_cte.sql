SELECT *
FROM my_db.products p
WHERE p.price > (
    SELECT avg(price)
    FROM my_db.products
  )
ORDER BY price DESC,
  id ASC;
SELECT u.id,
  u.first_name,
  u.email
FROM my_db.users AS u
WHERE u.id in (
    SELECT DISTINCT o.user_id
    FROM my_db.orders o
    WHERE EXTRACT(
        MONTH
        FROM o.order_time
      ) = 12
      AND EXTRACT(
        YEAR
        FROM o.order_time
      ) = 2017
  )
ORDER BY id;
SELECT
    o.id AS order_id
    , o.order_time
    , o.amount
    , u.id AS user_id
    , u.last_name
    , u.first_name
FROM my_db.orders o
JOIN my_db.users u 
    ON u.id = o.user_id
JOIN my_db.prefectures p
    ON p.id = u.prefecture_id
WHERE
    p.name = '東京都'
ORDER BY order_id ASC
;
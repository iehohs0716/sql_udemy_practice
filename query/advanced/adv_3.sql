SELECT p.id AS id,
    p.name AS name,
    ROUND(AVG(o.amount), 0) AS amount
FROM my_db.prefectures p
    LEFT JOIN my_db.users u ON p.id = u.prefecture_id
    LEFT JOIN my_db.orders o ON o.user_id = u.id
WHERE o.amount IS NOT NULL
GROUP BY p.id;
-- 都道府県ごとの客単価平均を求める
-- 都道府県ID, 都道府県名, 客単価平均
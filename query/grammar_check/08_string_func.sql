SELECT
    CONCAT(first_name, 'さん')
    , email 
FROM my_db.users
WHERE 
    gender = 2
ORDER BY id ASC;
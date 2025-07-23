SELECT 
    request_month
    , count(*) AS count
FROM my_db.access_logs
WHERE 
    request_month >= '2017-01-01'
    AND request_month < '2017-07-01'
GROUP BY request_month
HAVING count >= 1000
ORDER BY request_month
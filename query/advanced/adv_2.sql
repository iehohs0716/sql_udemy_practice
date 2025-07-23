SELECT date_format(o.order_time, '%Y-%m') date_month,
    ROUND(avg(o.amount), 0) amount
FROM my_db.orders o
GROUP BY date_format(o.order_time, '%Y-%m');
-- 月における平均客単価を求める（金額は四捨五入して整数にする）
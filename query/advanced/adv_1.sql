SELECT ROUND(avg(o.amount), 0) amount
FROM my_db.orders o;
-- 全期間における平均客単価を求める（金額は四捨五入して整数にする)
WITH my_numbers AS (
    SELECT a.N + b.N * 10 AS n
    FROM (
            SELECT 0 AS N
            UNION
            SELECT 1
            UNION
            SELECT 2
            UNION
            SELECT 3
            UNION
            SELECT 4
            UNION
            SELECT 5
            UNION
            SELECT 6
            UNION
            SELECT 7
            UNION
            SELECT 8
            UNION
            SELECT 9
        ) a,
        (
            SELECT 0 AS N
            UNION
            SELECT 1
            UNION
            SELECT 2
            UNION
            SELECT 3
            UNION
            SELECT 4
            UNION
            SELECT 5
            UNION
            SELECT 6
            UNION
            SELECT 7
            UNION
            SELECT 8
            UNION
            SELECT 9
        ) b
),
min_date AS (
    SELECT MIN(order_time) AS base_date
    FROM my_db.orders
),
max_date AS (
    SELECT MAX(order_time) AS base_date
    FROM my_db.orders
),
year_month_series AS (
    SELECT date_format(
            DATE_ADD(
                (
                    SELECT *
                    from min_date
                ),
                INTERVAL my_numbers.n MONTH
            ),
            '%Y-%m'
        ) AS yearmonth
    FROM my_numbers,
        min_date
    WHERE DATE_ADD(
            (
                SELECT *
                from min_date
            ),
            INTERVAL my_numbers.n MONTH
        ) <= (
            SELECT *
            from max_date
        )
    ORDER BY yearmonth
),
my_matrix AS (
    SELECT p.id,
        p.name,
        yms.yearmonth
    FROM my_db.prefectures p
        CROSS JOIN year_month_series yms
),
sum_produced AS (
    SELECT p.id AS id,
        p.name AS name,
        date_format(o.order_time, '%Y-%m') yearmonth,
        round(avg(o.amount), 0) AS amount
    FROM my_db.prefectures p
        LEFT JOIN my_db.users u ON p.id = u.prefecture_id
        LEFT JOIN my_db.orders o ON o.user_id = u.id
    WHERE o.amount IS NOT NULL
    GROUP BY p.id,
        date_format(o.order_time, '%Y-%m')
    ORDER BY p.id ASC,
        yearmonth ASC
)
SELECT ROW_NUMBER() OVER (
        ORDER BY m.id ASC,
            m.yearmonth ASC
    ) rn,
    m.name,
    m.yearmonth,
    COALESCE(sp.amount, 0) amount
FROM my_matrix m
    LEFT JOIN sum_produced sp ON sp.id = m.id
    AND sp.yearmonth = m.yearmonth
ORDER BY rn ASC -- 都道府県 and 月ごとの客単価平均を求める(月が歯抜けになることは許されない)
    -- 行番号, 都道府県名, 客単価平均
WITH FIN_CHANGE_DATE AS (
    SELECT product_id, MAX(change_date) as fin_change_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
),
PRODUCT_LIST AS (
    SELECT DISTINCT product_id
    FROM Products
)
SELECT p.product_id as product_id, COALESCE((SELECT new_price FROM Products WHERE product_id = p.product_id AND change_date = f.fin_change_date), 10) as price
FROM PRODUCT_LIST as p
LEFT JOIN FIN_CHANGE_DATE as f ON p.product_id = f.product_id

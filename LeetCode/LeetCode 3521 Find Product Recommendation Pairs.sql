WITH PP AS (
    SELECT user_id, PP.product_id, category
    FROM ProductPurchases PP
    INNER JOIN ProductInfo PI ON PP.product_id = PI.product_id
)
SELECT P1.product_id as product1_id, P2.product_id as product2_id, P1.category as product1_category, P2.category as product2_category, COUNT(P1.user_id) as customer_count
FROM PP P1
INNER JOIN PP P2 on P1.user_id = P2.user_id AND P1.product_id < P2.product_id 
GROUP BY P1.product_id, P2.product_id, P1.category, P2.category
HAVING COUNT(P1.user_id) >= 3
ORDER BY customer_count desc, product1_id, product2_id
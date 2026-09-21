SELECT Users.user_id as buyer_id, Users.join_date, COUNT(Orders.order_id) as orders_in_2019
FROM Users
LEFT JOIN Orders on Users.user_id = Orders.buyer_id AND Orders.order_date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY Users.user_id, Users.join_date
ORDER BY Users.user_id
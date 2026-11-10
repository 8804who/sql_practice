WITH Users as (
    SELECT DISTINCT user_id
    FROM Signups
),
ConfirmedCount as (
    SELECT user_id, COUNT(action) as confirmed_count
    FROM Confirmations
    WHERE action = 'confirmed'
    GROUP BY user_id
),
ConfirmationCount as (
    SELECT user_id, COUNT(action) as confirmation_count
    FROM Confirmations
    GROUP BY user_id
)
SELECT u.user_id, (COALESCE(cc1.confirmed_count,0)::numeric / COALESCE(cc2.confirmation_count,1))::numeric(10, 2) AS confirmation_rate
FROM Users u 
LEFT JOIN ConfirmedCount cc1 on u.user_id = cc1.user_id
LEFT JOIN ConfirmationCount cc2 on u.user_id = cc2.user_id 
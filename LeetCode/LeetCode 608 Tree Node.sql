SELECT A.id,
    CASE
        WHEN A.p_id IS NULL THEN 'Root'
        WHEN B.p_id IS NOT NULL THEN 'Inner'
        ELSE 'Leaf'
    END as type
FROM Tree as A
LEFT JOIN (SELECT DISTINCT p_id FROM Tree) as B ON A.id = B.p_id
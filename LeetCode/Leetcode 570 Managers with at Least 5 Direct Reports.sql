SELECT A.name as name
FROM Employee as A
    INNER JOIN Employee as B on A.id = B.managerId
GROUP BY A.id, A.name
HAVING COUNT(B.id) >= 5;
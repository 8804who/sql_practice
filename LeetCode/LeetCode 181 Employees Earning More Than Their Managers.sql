SELECT name as Employee
FROM Employee E1
WHERE salary > (SELECT salary FROM Employee E2 WHERE E2.id = E1.managerId)
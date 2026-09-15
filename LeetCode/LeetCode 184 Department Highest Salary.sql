SELECT d.name as Department, e.name as Employee, e.salary as Salary
FROM Employee as e
INNER JOIN (
        SELECT departmentId, MAX(salary) as salary
        FROM Employee
        GROUP BY departmentId
    ) as ms 
    ON e.salary = ms.salary 
    AND e.departmentId = ms.departmentId
INNER JOIN Department as d
    ON e.departmentId = d.id
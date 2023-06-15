/* total number of customers in each region*/
SELECT g.Region, COUNT(DISTINCT s.Customers) AS TotalCustomers,
       ROUND((COUNT(DISTINCT s.Customers) * 100 / SUM(COUNT(DISTINCT s.Customers)) OVER ()),2) AS Percentage
FROM Sales s
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Region
ORDER BY TotalCustomers DESC;
/* most popular product category*/
SELECT p.Category, COUNT(*) AS PurchaseCount
FROM Sales s
JOIN Products p ON s.PID = p.PID
GROUP BY p.category
ORDER BY PurchaseCount DESC;

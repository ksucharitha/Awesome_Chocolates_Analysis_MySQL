/*Total sales amount for each salesperson*/
SELECT s.SPID,p.Salesperson,SUM(s.Amount) AS TotalSalesAmount
GROUP BY p.Salesperson
ORDER BY TotalSalesAmount DESC;
/* sales performance of each region based on total sales amount*/
SELECT g.Region, SUM(s.Amount) AS TotalSalesAmount,
ROUND((SUM(s.Amount) / (SELECT SUM(Amount) FROM Sales) * 100),2) AS PercentageSales
FROM Sales s
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Region;

/* top-selling products*/
SELECT p.Product, SUM(s.Amount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.PID = p.PID
GROUP BY p.Product
ORDER BY TotalSalesAmount DESC;

/* top-selling products according to region*/
SELECT p.Product, SUM(s.Amount) AS TotalSalesAmount, g.Region 
FROM Sales s
JOIN geo g ON s.GeoID=g.GeoID
JOIN Products p ON s.PID = p.PID
GROUP BY  g.region,p.product
HAVING TotalSalesAmount = (
    SELECT MAX(TotalSalesAmount)
    FROM (
        SELECT p.Product, SUM(s.Amount) AS TotalSalesAmount, g.Region 
        FROM Sales s
        JOIN geo g ON s.GeoID=g.GeoID
        JOIN Products p ON s.PID = p.PID
        GROUP BY  g.region,p.product
        
    ) AS subquery
    WHERE subquery.Region = g.Region
)ORDER BY TotalSalesAmount DESC;

/* top-selling products according to country*/
SELECT p.Product, g.Geo, SUM(s.Amount) AS TotalSalesAmount
FROM Sales s
JOIN geo g ON s.GeoID=g.GeoID
JOIN Products p ON s.PID = p.PID
GROUP BY  g.Geo,p.product
HAVING TotalSalesAmount = (
    SELECT MAX(TotalSalesAmount)
    FROM (
        SELECT p.Product, g.Geo, SUM(s.Amount) AS TotalSalesAmount
        FROM Sales s
		JOIN geo g ON s.GeoID=g.GeoID
		JOIN Products p ON s.PID = p.PID
		GROUP BY  g.Geo,p.product
    ) AS subquery
    WHERE subquery.Geo = g.Geo
)ORDER BY TotalSalesAmount DESC;


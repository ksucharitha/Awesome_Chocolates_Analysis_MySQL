 /*Total sales amount and quantity sold for each product */
SELECT PID, SUM(Amount) AS TotalSalesAmount, SUM(Boxes) AS TotalQuantitySold
FROM Sales
GROUP BY PID
ORDER BY TotalSalesAmount DESC;

/*Average sales amount per box for each product*/
SELECT s.PID, p.Product, ROUND(AVG(s.Amount / s.Boxes),2) AS AverageSalesPerBox
FROM Sales s
JOIN Products p ON s.PID = p.PID
GROUP BY s.PID, p.Product;

/*Top-selling products in each category*/
SELECT p.Category, p.Product, SUM(s.Amount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.PID = p.PID
GROUP BY p.Category, p.Product
HAVING TotalSalesAmount = (
    SELECT MAX(TotalSalesAmount)
    FROM (
        SELECT p.Category, p.Product, SUM(s.Amount) AS TotalSalesAmount
        FROM Sales s
        JOIN Products p ON s.PID = p.PID
        GROUP BY p.Category, p.Product
    ) AS subquery
    WHERE subquery.Category = p.Category
);

/* Percentage of Top-selling product in each region*/

SELECT p.Product, g.Region, pl.Salesperson, SUM(s.Amount) AS SalesAmount,
    ROUND((SUM(s.Amount) / (SELECT SUM(Amount) FROM Sales)) * 100,2)AS PercentageSales
FROM Sales s
JOIN Products p ON s.PID = p.PID
JOIN geo g ON s.GeoID = g.GeoID
JOIN People pl ON s.SPID = pl.SPID
WHERE s.PID = (
    SELECT PID
    FROM (
        SELECT PID, SUM(Amount) AS TotalSales
        FROM Sales
        GROUP BY PID
        ORDER BY TotalSales DESC
        LIMIT 1
    ) AS subquery
)
GROUP BY p.Product, g.Region;

/* Sales distribution by product size:*/
SELECT p.Size, COUNT(*) AS SalesCount, 
ROUND(count(*)*100.0/(select count(*) FROM sales),2) AS Percentage
FROM Sales s
JOIN Products p ON s.PID = p.PID
GROUP BY p.Size;





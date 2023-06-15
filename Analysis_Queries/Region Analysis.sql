/* total sales amount and quantity sold in each region*/
SELECT g.Region, SUM(s.Amount) AS TotalSalesAmount, SUM(s.Boxes) AS TotalQuantitySold
FROM Sales s
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Region;

/*top-performing regions based on sales performance*/
SELECT g.Region, SUM(s.Amount) AS TotalSalesAmount, ROUND((SUM(s.Amount)*100/t.TotalAmount),2)AS PercentageSales
FROM Sales s
JOIN geo g ON s.GeoID = g.GeoID
JOIN (SELECT SUM(Amount) AS TotalAmount FROM Sales) t
GROUP BY g.Region, t.TotalAmount
ORDER BY TotalSalesAmount DESC;


/*sales distribution across different geographies*/
SELECT g.Geo, COUNT(s.SPID) AS SalesCount
FROM Sales s
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Geo;

/* average sales amount per customer in each region*/
SELECT g.Region, ROUND(AVG(s.Amount),2) AS AverageSalesAmountPerCustomer
FROM Sales s
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Region;


USE AdventureWorksDW;

SELECT ProductKey, 
COUNT(*) 
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1;

SELECT ProductKey
FROM dimproduct
WHERE ProductKey IS NULL;


SELECT SalesOrderNumber,
	   SalesOrderLineNumber
FROM  factresellersales  
GROUP BY SalesOrderNumber, 
         SalesOrderLineNumber 
HAVING COUNT(*) > 1;

SELECT SalesOrderNumber,
       SalesOrderLineNumber,
COUNT(*)
FROM factresellersales
WHERE SalesOrderNumber IS NULL AND SalesOrderLineNumber IS NULL
GROUP BY SalesOrderNumber,
         SalesOrderLineNumber;


SELECT * FROM factresellersales;

SELECT P.EnglishProductName AS NomeProdotto,
       SUM(F.SalesAmount) AS Fatturato_Totale,
       SUM(F.OrderQuantity) AS QuantitaTotaleVenduta,
AVG (unitPrice) AS PrezzoMedio,
SUM(SalesAmount)/SUM(OrderQuantity)AS PrezzoMedio2
FROM dimproduct AS P
INNER JOIN factresellersales AS F
ON P.ProductKey = F.ProductKey
WHERE F.OrderDate >= '2020-01-01'
GROUP BY P.EnglishProductName;

SELECT OrderDate,
       COUNT(*) AS Numero_Transazioni
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate;


SELECT C.EnglishProductCategoryName AS CategoriaProdotto,
       SUM(F.SalesAmount) AS FatturatoTotale,
       SUM(F.OrderQuantity) AS QuantitaTotaleVenduta,
AVG (unitPrice) AS PrezzoMedio 
FROM dimproduct AS P
INNER JOIN dimproductsubcategory AS S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
INNER JOIN dimproductcategory AS C 
ON S.ProductCategoryKey = C.ProductCategoryKey
INNER JOIN factresellersales AS F
ON P.ProductKey = F.ProductKey
GROUP BY C.EnglishProductCategoryName;

SELECT * FROM dimgeography;

SELECT 
	G.City AS Città,
    SUM(F.SalesAmount) AS FatturatoTotale
FROM dimgeography AS G 
INNER JOIN dimreseller AS R 
ON G.GeographyKey = R.GeographyKey
INNER JOIN factresellersales AS F 
ON F.ResellerKey = R.ResellerKey
WHERE F.OrderDate >= '2020-01-01'
GROUP BY G.City
HAVING  SUM(F.SalesAmount) >60000;








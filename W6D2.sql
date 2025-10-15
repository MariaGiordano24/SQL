SHOW DATABASES;
USE AdventureWorksDW;
SHOW TABLES;

SELECT * FROM dimproduct;
DESCRIBE dimproduct;
SELECT 
    ProductKey AS CodiceProdotto,
    ProductAlternateKey AS CodiceModello,
    EnglishProductName AS NomeProdotto,
    Color AS Colore,
    StandardCost AS CostoStandard,
    FinishedGoodsFlag AS ProdottoFinito
FROM dimproduct;


SELECT 
    ProductKey AS CodiceProdotto,
    ProductAlternateKey AS CodiceModello,
    EnglishProductName AS NomeProdotto,
    Color AS Colore,
    StandardCost AS CostoStandard,
    FinishedGoodsFlag AS ProdottoFinito
FROM dimproduct
WHERE FinishedGoodsFlag = 1;


SELECT 
    ProductKey AS CodiceProdotto,
    ProductAlternateKey AS CodiceModello,
    EnglishProductName AS NomeProdotto,
    StandardCost AS CostoStandard,
    ListPrice AS PrezzoListino
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' 
   OR ProductAlternateKey LIKE 'BK%';
   
   
SELECT 
    ProductKey AS CodiceProdotto,
    ProductAlternateKey AS CodiceModello,
    EnglishProductName AS NomeProdotto,
    StandardCost AS CostoStandard,
    ListPrice AS PrezzoListino,
    ListPrice - StandardCost AS Markup
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' 
   OR ProductAlternateKey LIKE 'BK%';
   
   
SELECT 
    ProductKey AS CodiceProdotto,
    ProductAlternateKey AS CodiceModello,
    EnglishProductName AS NomeProdotto,
    StandardCost AS CostoStandard,
    ListPrice AS PrezzoListino,
    ListPrice - StandardCost AS Markup
FROM dimproduct
WHERE FinishedGoodsFlag = 1
  AND ListPrice BETWEEN 1000 AND 2000
ORDER BY ListPrice;

SELECT * FROM dimemployee;
DESCRIBE dimemployee;

SELECT 
	EmployeeKey,
    LastName,
    Title,
    DepartmentName,
    Position,
    SalesPersonFlag
FROM dimemployee
WHERE SalesPersonFlag = 1;

SELECT DISTINCT DepartmentName
FROM dimemployee;

SELECT * FROM factresellersales ;

SELECT 
       SalesOrderNumber,
       SalesOrderLineNumber,
       OrderDate,
	   ProductKey
       OrderQuantity,
       SalesAmount,
       TotalProductCost,
       SalesAmount - TotalProductCost AS 'Profitto'
FROM factresellersales
WHERE ProductKey IN (597, 598, 477, 214) 
AND  OrderDate>='2020-01-01';

       



  
  
  

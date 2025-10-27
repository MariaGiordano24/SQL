USE adv;

CREATE VIEW PRODUCT AS 
SELECT P.ProductKey AS ID_PRODOTTO,
       P.EnglishProductName AS NOME_PRODOTTO,
       S.EnglishProductSubcategoryName AS NOME_SOTTOCATEGORIA,
       c.EnglishProductCategoryName AS NOME_CATEGORIA
FROM DimProduct AS P
INNER JOIN DimProductSubcategory S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
INNER JOIN DimProductCategory AS C
ON S.ProductCategoryKey = C.ProductCategoryKey;

SELECT * FROM PRODUCT;

CREATE VIEW RESELLER AS
SELECT R.ResellerKey AS ID_RIVENDITORE,
       R.ResellerName AS NOME_RIVENDITORE,
       G.City AS CITTA,
       G.EnglishCountryRegionName AS NOME_REGIONE
FROM DimReseller AS R
INNER JOIN DimGeography AS G
ON R.GeographyKey = G.GeographyKey;

SELECT * FROM RESELLER;

CREATE VIEW SALES AS
SELECT 
    S.OrderDate AS DATA_ORDINE,
    S.SalesOrderNumber AS NUMERO_ORDINE,
    S.SalesOrderLineNumber AS NUMERO_RIGA_ORDINE,
    P.ProductKey AS ID_PRODOTTO,
    ResellerKey AS ID_RIVENDITORE,
    UnitPrice AS PREZZO_UNITARIO,
    S.OrderQuantity AS QUANTITA,
    S.SalesAmount AS TOTALE_VENDITA,
IFNULL(TotalProductCost, StandardCost*OrderQuantity) AS PROFITTO
FROM FactResellerSales AS S
JOIN DimProduct AS P
ON P.ProductKey = S.ProductKey;

SELECT * FROM SALES;





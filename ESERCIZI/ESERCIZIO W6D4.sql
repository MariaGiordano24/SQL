USE AdventureWorksDW;

SELECT ProductKey,
EnglishProductName,
EnglishProductSubcategoryName,
p.ProductSubcategoryKey
FROM dimproduct p 
LEFT JOIN dimproductsubcategory s 
ON p.ProductSubcategorykey = s.ProductSubcategoryKey;


SELECT ProductKey,
EnglishProductName,
EnglishProductCategoryName,
EnglishProductSubcategoryName
FROM dimproduct p 
LEFT JOIN dimproductsubcategory s 
ON p.ProductSubcategorykey = s.ProductSubcategoryKey
LEFT JOIN dimproductcategory c
ON s.Productcategorykey = c.ProductcategoryKey;


SELECT DISTINCT p.ProductKey,
                p.EnglishProductName,
                c.EnglishProductCategoryName,
                s.EnglishProductSubcategoryName
FROM dimproduct p 
JOIN factresellersales sale
ON p.ProductKey = sale.ProductKey
LEFT JOIN dimproductsubcategory s 
ON p.ProductSubcategoryKey= s.ProductSubcategoryKey
LEFT JOIN dimproductcategory c 
ON s.ProductCategoryKey = c.ProductCategoryKey;


SELECT ProductKey,
       EnglishProductName,
       FinishedGoodsFlag
FROM dimproduct
WHERE ProductKey NOT IN (SELECT ProductKey
                                FROM factresellersales)
AND FinishedGoodsFlag = 1;


SELECT  SalesOrderNumber,
        SalesOrderLineNumber,
		EnglishProductName,
        OrderDate,
		UnitPrice,
        OrderQuantity,
        TotalProductCost
FROM factresellersales sale
INNER JOIN dimproduct p 
ON s.ProductKey = p.ProductKey;
















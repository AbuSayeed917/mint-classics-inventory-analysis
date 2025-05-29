SHOW DATABASES;
USE mintclassics;
SHOW Tables;
SELECT COUNT(*) FROM products;
SELECT warehouseCode, COUNT(*) FROM products GROUP BY warehouseCode;
SELECT productCode FROM products
WHERE productCode NOT IN (
  SELECT DISTINCT productCode FROM orderdetails
);
SELECT productCode, SUM(quantityOrdered) AS total_sales
FROM orderdetails
GROUP BY productCode;
SELECT p.productCode, p.productName, p.quantityInStock, 
       SUM(od.quantityOrdered) AS total_sold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode;
SELECT
  p.productCode,
  p.productName,
  p.quantityInStock,
  SUM(od.quantityOrdered) AS totalSold
FROM
  products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY
  p.productCode
ORDER BY
  totalSold ASC;
  DESCRIBE products;
  SELECT 
  p.productCode,
  p.productName,
  p.quantityInStock,
  p.warehouseCode,
  w.warehouseName
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
ORDER BY p.quantityInStock DESC;
SELECT 
  w.warehouseCode,
  w.warehouseName,
  COUNT(p.productCode) AS totalProducts,
  SUM(p.quantityInStock) AS totalStock
FROM warehouses w
JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY totalStock ASC;
SELECT 
  p.productCode,
  p.productName,
  p.quantityInStock,
  SUM(od.quantityOrdered) AS totalSold,
  p.warehouseCode
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode
HAVING (totalSold IS NULL OR totalSold < 20) AND quantityInStock > 100
ORDER BY quantityInStock DESC;
SELECT 
  w.warehouseName,
  p.productName,
  SUM(od.quantityOrdered) AS totalSales
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseName, p.productName
ORDER BY w.warehouseName, totalSales DESC;
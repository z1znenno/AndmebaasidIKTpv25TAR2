CREATE TABLE Products
(
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL
);

insert into Products(ProductName, Manufacturer, ProductCount, Price)
values('Kommid', 'KommiPrint', 1300, 1.30),
('Arvutid', 'TereMaailm', 2000, 1199.99),
('Pallid', 'Pallee', 956, 39.59),
('Telefonid', 'Apple', 400000, 2000),
('Riided', 'Nike', 21000, 61.93);

select * from Products;
--Protseduur mis kuvab Product manufacturer ja price
CREATE PROCEDURE ProductSummary
AS
BEGIN
SELECT ProductName AS Product, Manufacturer, Price
FROM Products
END;
--Kutse
EXEC ProductSummary;

--Protseduur mis lisab uus produkt
CREATE PROCEDURE AddProduct
    @name NVARCHAR(20),
    @manufacturer NVARCHAR(20),
    @count INT,
    @price MONEY
AS
INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price) 
VALUES(@name, @manufacturer, @count, @price);
--Kutse
EXEC AddProduct 'Riided2', 'Nike', 21000, 61.93;

--Kutse2
DECLARE @prodName NVARCHAR(20), @company NVARCHAR(20);
DECLARE @prodCount INT, @price MONEY
SET @prodName = 'Galaxy C7'
SET @company = 'Samsung'
SET @price = 220
SET @prodCount = 5
 
EXEC AddProduct @prodName, @company, @prodCount, @price
 
SELECT * FROM Products

--Kutse 3
DECLARE @prodName NVARCHAR(20), @company NVARCHAR(20);
SET @prodName = 'Honor 9'
SET @company = 'Huawei'
 
EXEC AddProduct @name = @prodName, 
                @manufacturer=@company,
                @count = 3, 
                @price = 18000
--Protsedure ilma kasutava parametriga
CREATE PROCEDURE AddProductWithOptionalCount
    @name NVARCHAR(20),
    @manufacturer NVARCHAR(20),
    @price MONEY,
    @count INT = 1
AS
INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price) 
VALUES(@name, @manufacturer, @count, @price)

--Kutse
DECLARE @prodName NVARCHAR(20), @company NVARCHAR(20), @price MONEY
SET @prodName = 'Redmi Note 5A'
SET @company = 'Xiaomi'
SET @price = 22000
 
EXEC AddProductWithOptionalCount @prodName, @company, @price
 
SELECT * FROM Products

--Protseduur koos OUTPUT parametriga
CREATE PROCEDURE GetPriceStats
    @minPrice MONEY OUTPUT,
    @maxPrice MONEY OUTPUT
AS
SELECT @minPrice = MIN(Price),  @maxPrice = MAX(Price)
FROM Products

--Kutse
DECLARE @minPrice MONEY, @maxPrice MONEY
 
EXEC GetPriceStats @minPrice OUTPUT, @maxPrice OUTPUT
 
PRINT 'Minimaalne hind ' + CONVERT(VARCHAR, @minPrice)
PRINT 'Maksimaalne hind ' + CONVERT(VARCHAR, @maxPrice)

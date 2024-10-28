USE [Mydbslot];
GO


CREATE EXTERNAL DATA SOURCE MyBlobStorage
WITH (
    LOCATION = 'https://myfreepro.dfs.core.windows.net/'
);

CREATE EXTERNAL FILE FORMAT CSVFormat
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2
    )
);


CREATE EXTERNAL TABLE Products (
    -- Define your columns here
    ProductID NVARCHAR(50),
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    ListPrice NVARCHAR(50)
    -- Add other columns as per your CSV structure
)
WITH (
    LOCATION = 'files/products_data/products.csv',
    DATA_SOURCE = MyBlobStorage,
    FILE_FORMAT = CSVFormat
);


SELECT TOP 100 * 
FROM Products;


SELECT category, COUNT(*) AS ProductCount
FROM Products
GROUP BY category;

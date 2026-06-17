USE [warehouse_management];
GO

IF COL_LENGTH('dbo.Products', 'ImagePath') IS NULL
BEGIN
    ALTER TABLE [dbo].[Products]
    ADD [ImagePath] NVARCHAR(1000) NULL;
END;
GO

DECLARE @ProductImages TABLE
(
    Sku NVARCHAR(100) NOT NULL PRIMARY KEY,
    ImagePath NVARCHAR(1000) NOT NULL
);

INSERT INTO @ProductImages (Sku, ImagePath)
VALUES
    (N'DRL-500', N'https://commons.wikimedia.org/wiki/Special:FilePath/Hammer%20drill-1.jpg?width=800');

UPDATE p
SET p.ImagePath = i.ImagePath
FROM [dbo].[Products] AS p
INNER JOIN @ProductImages AS i ON i.Sku = p.Sku
WHERE p.ImagePath IS NULL OR LTRIM(RTRIM(p.ImagePath)) = N'';
GO

UPDATE [dbo].[Products]
SET [ImagePath] = N'https://loremflickr.com/640/480/'
    + REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(COALESCE([ProductName], N'warehouse product'))), N' ', N','), N'/', N','), N'\\', N',')
    + N'?lock='
    + CONVERT(NVARCHAR(20), [ProductID])
WHERE [ImagePath] IS NULL OR LTRIM(RTRIM([ImagePath])) = N'';
GO

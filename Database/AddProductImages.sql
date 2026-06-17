USE [warehouse_management];
GO

IF COL_LENGTH('dbo.Products', 'ImagePath') IS NULL
BEGIN
    ALTER TABLE [dbo].[Products]
    ADD [ImagePath] NVARCHAR(1000) NULL;
END;
GO

UPDATE [dbo].[Products]
SET [ImagePath] = N'https://commons.wikimedia.org/wiki/Special:FilePath/Hammer%20drill-1.jpg?width=800'
WHERE [Sku] = N'DRL-500'
  AND ([ImagePath] IS NULL OR LTRIM(RTRIM([ImagePath])) = N'');
GO

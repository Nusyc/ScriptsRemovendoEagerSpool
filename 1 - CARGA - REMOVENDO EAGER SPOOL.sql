USE MASTER
GO
CREATE DATABASE REMOVENDO_EAGERSPOOL
GO

USE REMOVENDO_EAGERSPOOL

SET NOCOUNT ON
GO

IF OBJECT_ID ('FactProductInventory') IS NOT NULL DROP TABLE FactProductInventory

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactProductInventory]
(
	[ProductKey] [bigint] NOT NULL,
	[DateKey] [int] NOT NULL,
	[MovementDate] [date] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[UnitsIn] [int] NOT NULL,
	[UnitsOut] [int] NOT NULL,
	[UnitsBalance] [int] NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_PRINCIPAL ON FactProductInventory (DateKey,ProductKey)
INCLUDE (MovementDate, UnitCost, UnitsIn, UnitsOut, UnitsBalance)
GO

INSERT [dbo].[FactProductInventory] ([ProductKey], [DateKey], [MovementDate], [UnitCost], [UnitsIn], [UnitsOut], [UnitsBalance])
VALUES (1, 20101228, CAST(N'2010-12-28' AS Date), 0.3200, 0, 0, 875)
GO 6

INSERT [dbo].[FactProductInventory]
SELECT [ProductKey] + ABS(CHECKSUM(NEWID()))  , [DateKey] , [MovementDate], [UnitCost], [UnitsIn], [UnitsOut], [UnitsBalance] FROM [FactProductInventory]
GO 17

select count(*) from [FactProductInventory]



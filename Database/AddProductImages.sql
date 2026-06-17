USE [master]
GO
/****** Объект:  Database [warehouse_management]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
CREATE DATABASE [warehouse_management]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'warehouse_management', FILENAME = N'C:\Users\L1zaRd\warehouse_management.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'warehouse_management_log', FILENAME = N'C:\Users\L1zaRd\warehouse_management_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [warehouse_management] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [warehouse_management].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [warehouse_management] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [warehouse_management] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [warehouse_management] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [warehouse_management] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [warehouse_management] SET ARITHABORT OFF 
GO
ALTER DATABASE [warehouse_management] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [warehouse_management] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [warehouse_management] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [warehouse_management] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [warehouse_management] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [warehouse_management] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [warehouse_management] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [warehouse_management] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [warehouse_management] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [warehouse_management] SET  ENABLE_BROKER 
GO
ALTER DATABASE [warehouse_management] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [warehouse_management] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [warehouse_management] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [warehouse_management] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [warehouse_management] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [warehouse_management] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [warehouse_management] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [warehouse_management] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [warehouse_management] SET  MULTI_USER 
GO
ALTER DATABASE [warehouse_management] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [warehouse_management] SET DB_CHAINING OFF 
GO
ALTER DATABASE [warehouse_management] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [warehouse_management] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [warehouse_management] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [warehouse_management] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [warehouse_management] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [warehouse_management] SET QUERY_STORE = ON
GO
ALTER DATABASE [warehouse_management] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [warehouse_management]
GO
/****** Объект:  Table [dbo].[ActionLogs]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActionLogs](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[ActionDate] [datetime2](0) NOT NULL,
	[ActionType] [nvarchar](60) NOT NULL,
	[EntityName] [nvarchar](80) NULL,
	[EntityID] [int] NULL,
	[Details] [nvarchar](500) NULL,
 CONSTRAINT [PK_ActionLogs] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Categories]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Clients]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [nvarchar](150) NOT NULL,
	[ContactPerson] [nvarchar](120) NULL,
	[Phone] [nvarchar](40) NULL,
	[Email] [nvarchar](120) NULL,
	[Address] [nvarchar](255) NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Employees]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[Position] [nvarchar](80) NOT NULL,
	[Phone] [nvarchar](40) NULL,
	[Email] [nvarchar](120) NULL,
	[HireDate] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[EquipmentTypes]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentTypes](
	[EquipmentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](80) NOT NULL,
	[MaintenanceIntervalDays] [int] NOT NULL,
 CONSTRAINT [PK_EquipmentTypes] PRIMARY KEY CLUSTERED 
(
	[EquipmentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Inventories]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventories](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryNumber] [nvarchar](40) NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[InventoryDate] [datetime2](0) NOT NULL,
	[Status] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_Inventories] PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[InventoryResults]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryResults](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryID] [int] NOT NULL,
	[BalanceID] [int] NOT NULL,
	[ExpectedQuantity] [int] NOT NULL,
	[ActualQuantity] [int] NOT NULL,
	[Difference] [int] NOT NULL,
	[Comment] [nvarchar](255) NULL,
 CONSTRAINT [PK_InventoryResults] PRIMARY KEY CLUSTERED 
(
	[ResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[MaintenancePlans]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenancePlans](
	[PlanID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentID] [int] NOT NULL,
	[PlannedDate] [date] NOT NULL,
	[WorkDescription] [nvarchar](255) NOT NULL,
	[Status] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_MaintenancePlans] PRIMARY KEY CLUSTERED 
(
	[PlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[ProductionLines]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductionLines](
	[LineID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[LineName] [nvarchar](120) NOT NULL,
	[ShiftCode] [nvarchar](20) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ProductionLines] PRIMARY KEY CLUSTERED 
(
	[LineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Products]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Sku] [nvarchar](60) NOT NULL,
	[ProductName] [nvarchar](180) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[PurchasePrice] [decimal](12, 2) NOT NULL,
	[SalePrice] [decimal](12, 2) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[UnitID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[MinStock] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ImagePath] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[QualityChecks]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QualityChecks](
	[QualityCheckID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[CheckDate] [datetime2](0) NOT NULL,
	[Result] [nvarchar](40) NOT NULL,
	[Comment] [nvarchar](255) NULL,
 CONSTRAINT [PK_QualityChecks] PRIMARY KEY CLUSTERED 
(
	[QualityCheckID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[ReceiptItems]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiptItems](
	[ReceiptItemID] [int] IDENTITY(1,1) NOT NULL,
	[ReceiptID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](12, 2) NOT NULL,
 CONSTRAINT [PK_ReceiptItems] PRIMARY KEY CLUSTERED 
(
	[ReceiptItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Receipts]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipts](
	[ReceiptID] [int] IDENTITY(1,1) NOT NULL,
	[ReceiptNumber] [nvarchar](40) NOT NULL,
	[SupplierID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ReceiptDate] [datetime2](0) NOT NULL,
	[Comment] [nvarchar](255) NULL,
 CONSTRAINT [PK_Receipts] PRIMARY KEY CLUSTERED 
(
	[ReceiptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[ShipmentItems]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipmentItems](
	[ShipmentItemID] [int] IDENTITY(1,1) NOT NULL,
	[ShipmentID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](12, 2) NOT NULL,
 CONSTRAINT [PK_ShipmentItems] PRIMARY KEY CLUSTERED 
(
	[ShipmentItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Shipments]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipments](
	[ShipmentID] [int] IDENTITY(1,1) NOT NULL,
	[ShipmentNumber] [nvarchar](40) NOT NULL,
	[ClientID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ShipmentDate] [datetime2](0) NOT NULL,
	[Comment] [nvarchar](255) NULL,
 CONSTRAINT [PK_Shipments] PRIMARY KEY CLUSTERED 
(
	[ShipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[StockBalances]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockBalances](
	[BalanceID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UpdatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_StockBalances] PRIMARY KEY CLUSTERED 
(
	[BalanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[StorageLocations]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorageLocations](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneID] [int] NOT NULL,
	[LocationCode] [nvarchar](40) NOT NULL,
	[MaxWeight] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_StorageLocations] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[StorageZones]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorageZones](
	[ZoneID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[ZoneName] [nvarchar](80) NOT NULL,
	[TemperatureMode] [nvarchar](60) NULL,
 CONSTRAINT [PK_StorageZones] PRIMARY KEY CLUSTERED 
(
	[ZoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Suppliers]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [nvarchar](150) NOT NULL,
	[ContactPerson] [nvarchar](120) NULL,
	[Phone] [nvarchar](40) NULL,
	[Email] [nvarchar](120) NULL,
	[Address] [nvarchar](255) NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Units]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Units](
	[UnitID] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](80) NOT NULL,
	[ShortName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Units] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[UserRoles]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Users]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[Login] [nvarchar](80) NOT NULL,
	[Password] [nvarchar](120) NOT NULL,
	[Email] [nvarchar](120) NULL,
	[Phone] [nvarchar](40) NULL,
	[RoleID] [int] NOT NULL,
	[EmployeeID] [int] NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[IsBlocked] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[WarehouseEquipment]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseEquipment](
	[EquipmentID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[EquipmentTypeID] [int] NOT NULL,
	[InventoryNumber] [nvarchar](60) NOT NULL,
	[EquipmentName] [nvarchar](120) NOT NULL,
	[CommissionedAt] [date] NOT NULL,
	[Status] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_WarehouseEquipment] PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Warehouses]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouses](
	[WarehouseID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseName] [nvarchar](120) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Warehouses] PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[WorkOrders]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrders](
	[WorkOrderID] [int] IDENTITY(1,1) NOT NULL,
	[LineID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[OrderNumber] [nvarchar](40) NOT NULL,
	[PlannedQuantity] [int] NOT NULL,
	[CompletedQuantity] [int] NOT NULL,
	[Status] [nvarchar](40) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_WorkOrders] PRIMARY KEY CLUSTERED 
(
	[WorkOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ActionLogs] ON 
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (1, 1, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Вход', N'Users', 1, N'Первичный вход администратора')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (2, 2, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Поступление', N'Receipts', 1, N'Создано тестовое поступление')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (3, 3, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Отгрузка', N'Shipments', 1, N'Создана тестовая отгрузка')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (4, 4, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Вход', N'Users', 4, N'Вход кладовщика')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (5, 5, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Поступление', N'Receipts', 3, N'Зарегистрировано поступление светотехники')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (6, 6, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Перемещение', N'StockBalances', 11, N'Перемещение труб в зону приёмки')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (7, 7, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Отгрузка', N'Shipments', 3, N'Создана отгрузка для клиента СтройГрад')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (8, 8, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Поступление', N'Receipts', 5, N'Зарегистрировано поступление инструмента')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (9, 9, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Инвентаризация', N'Inventories', 2, N'Запущена инвентаризация Северного склада')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (10, 10, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Изменение', N'Products', 15, N'Обновлена цена кабеля')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (11, 11, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Контроль качества', N'QualityChecks', 4, N'Проведена проверка партии перчаток')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (12, 12, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Отгрузка', N'Shipments', 7, N'Отгрузка кабельной продукции клиенту ИнжСети')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (13, 1, CAST(N'2026-06-18T00:39:48.0000000' AS DateTime2), N'Вход', N'Users', 1, N'Авторизация в системе')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (14, 1, CAST(N'2026-06-18T00:47:26.0000000' AS DateTime2), N'Вход', N'Users', 1, N'Авторизация в системе')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (15, 1, CAST(N'2026-06-18T00:48:12.0000000' AS DateTime2), N'Изменение', N'Products', 2, N'Шуруповёрт 18 В')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (16, 1, CAST(N'2026-06-18T00:48:40.0000000' AS DateTime2), N'Изменение', N'Products', 3, N'Болт М8 оцинкованный')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (17, 1, CAST(N'2026-06-18T00:50:26.0000000' AS DateTime2), N'Изменение', N'Products', 4, N'Труба ПП 20 мм')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (18, 1, CAST(N'2026-06-18T00:50:53.0000000' AS DateTime2), N'Изменение', N'Products', 5, N'Лампа LED 12 Вт')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (19, 1, CAST(N'2026-06-18T00:51:17.0000000' AS DateTime2), N'Изменение', N'Products', 6, N'Смеситель кухонный')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (20, 1, CAST(N'2026-06-18T00:51:45.0000000' AS DateTime2), N'Изменение', N'Products', 7, N'Перфоратор 900 Вт')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (21, 1, CAST(N'2026-06-18T00:52:03.0000000' AS DateTime2), N'Изменение', N'Products', 8, N'УШМ (болгарка) 125 мм')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (22, 1, CAST(N'2026-06-18T00:52:29.0000000' AS DateTime2), N'Изменение', N'Products', 9, N'Шуруп М6 кровельный')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (23, 1, CAST(N'2026-06-18T00:53:10.0000000' AS DateTime2), N'Изменение', N'Products', 10, N'Анкер забивной 10 мм')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (24, 1, CAST(N'2026-06-18T00:53:42.0000000' AS DateTime2), N'Изменение', N'Products', 11, N'Труба ПП 32 мм')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (25, 1, CAST(N'2026-06-18T00:54:09.0000000' AS DateTime2), N'Изменение', N'Products', 12, N'Смеситель для ванны')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (26, 1, CAST(N'2026-06-18T00:54:33.0000000' AS DateTime2), N'Изменение', N'Products', 13, N'LED панель потолочная 36 Вт')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (27, 1, CAST(N'2026-06-18T00:54:50.0000000' AS DateTime2), N'Изменение', N'Products', 14, N'Лампа накаливания E27 60 Вт')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (28, 1, CAST(N'2026-06-18T00:55:11.0000000' AS DateTime2), N'Изменение', N'Products', 15, N'Кабель ВВГ 3х2.5')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (29, 1, CAST(N'2026-06-18T00:55:31.0000000' AS DateTime2), N'Изменение', N'Products', 16, N'Выключатель одноклавишный')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (30, 1, CAST(N'2026-06-18T00:55:56.0000000' AS DateTime2), N'Изменение', N'Products', 17, N'Розетка с заземлением')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (31, 1, CAST(N'2026-06-18T00:56:14.0000000' AS DateTime2), N'Изменение', N'Products', 18, N'Молоток слесарный 500 г')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (32, 1, CAST(N'2026-06-18T00:56:29.0000000' AS DateTime2), N'Изменение', N'Products', 19, N'Набор отвёрток 6 предметов')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (33, 1, CAST(N'2026-06-18T00:56:53.0000000' AS DateTime2), N'Изменение', N'Products', 20, N'Перчатки рабочие х/б')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (34, 1, CAST(N'2026-06-18T00:57:09.0000000' AS DateTime2), N'Изменение', N'Products', 21, N'Каска защитная строительная')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (35, 1, CAST(N'2026-06-18T00:57:28.0000000' AS DateTime2), N'Изменение', N'Products', 22, N'Мешки для мусора 50 л')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (36, 1, CAST(N'2026-06-18T00:57:41.0000000' AS DateTime2), N'Вход', N'Users', 1, N'Авторизация в системе')
GO
INSERT [dbo].[ActionLogs] ([LogID], [UserID], [ActionDate], [ActionType], [EntityName], [EntityID], [Details]) VALUES (37, 1, CAST(N'2026-06-18T01:06:15.0000000' AS DateTime2), N'Вход', N'Users', 1, N'Авторизация в системе')
GO
SET IDENTITY_INSERT [dbo].[ActionLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1, N'Электроинструмент', N'Инструменты с электропитанием')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (2, N'Крепёж', N'Метизы и расходники')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (3, N'Сантехника', N'Трубы, фитинги, смесители')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (4, N'Освещение', N'Лампы и светильники')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (5, N'Электрика', N'Кабели, выключатели, розетки')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (6, N'Ручной инструмент', N'Молотки, отвёртки, ключи')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (7, N'Спецодежда и СИЗ', N'Средства индивидуальной защиты')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (8, N'Хозтовары', N'Расходные материалы для склада')
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (1, N'РемСтрой ООО', N'Павел Егоров', N'+7 499 555-10-10', N'zakupki@remstroy.ru', N'Москва, Ленина 10')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (2, N'МастерДом ИП', N'Ирина Алексеева', N'+7 921 555-20-20', N'order@masterdom.ru', N'Псков, Советская 8')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (3, N'ГородСервис', N'Николай Морозов', N'+7 831 555-30-30', N'supply@gorodservice.ru', N'Нижний Новгород, Заречная 2')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (4, N'СтройГрад', N'Виталий Игнатьев', N'+7 861 555-40-40', N'zakupki@stroygrad.ru', N'Краснодар, Северная 18')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (5, N'ДомСервис', N'Лариса Тимофеева', N'+7 343 555-50-50', N'order@domservice.ru', N'Екатеринбург, Уральская 3')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (6, N'ТехноРемонт', N'Геннадий Прохоров', N'+7 351 555-60-60', N'supply@tehnoremont.ru', N'Челябинск, Заводская 9')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (7, N'ИнжСети', N'Светлана Дементьева', N'+7 495 555-70-70', N'zakupki@injseti.ru', N'Москва, Кабельная 21')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (8, N'ФасадМастер', N'Андрей Климов', N'+7 812 555-80-80', N'order@fasadmaster.ru', N'Санкт-Петербург, Парковая 6')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (9, N'ЭлектроСервис', N'Марина Гаврилова', N'+7 383 555-90-90', N'supply@elektroservice.ru', N'Новосибирск, Энергетиков 4')
GO
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ContactPerson], [Phone], [Email], [Address]) VALUES (10, N'ВодоканалПодряд', N'Станислав Жуков', N'+7 843 555-00-00', N'zakupki@vodokanalpodryad.ru', N'Казань, Речная 12')
GO
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (1, N'Иван Петров', N'Заведующий складом', N'+7 900 111-22-33', N'petrov@warehouse.local', CAST(N'2023-02-01' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (2, N'Анна Смирнова', N'Кладовщик', N'+7 900 222-33-44', N'smirnova@warehouse.local', CAST(N'2023-05-12' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (3, N'Олег Соколов', N'Менеджер', N'+7 900 333-44-55', N'sokolov@warehouse.local', CAST(N'2024-01-15' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (4, N'Сергей Кузнецов', N'Кладовщик', N'+7 900 444-55-66', N'kuznetsov@warehouse.local', CAST(N'2024-03-04' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (5, N'Татьяна Лебедева', N'Менеджер по закупкам', N'+7 900 555-66-77', N'lebedeva@warehouse.local', CAST(N'2024-04-18' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (6, N'Дмитрий Васильев', N'Грузчик', N'+7 900 666-77-88', N'vasilev@warehouse.local', CAST(N'2024-05-20' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (7, N'Екатерина Морозова', N'Логист', N'+7 900 777-88-99', N'morozova@warehouse.local', CAST(N'2024-06-11' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (8, N'Андрей Новиков', N'Оператор склада', N'+7 900 888-99-00', N'novikov@warehouse.local', CAST(N'2024-07-09' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (9, N'Ольга Захарова', N'Бухгалтер', N'+7 900 999-00-11', N'zaharova@warehouse.local', CAST(N'2024-08-22' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (10, N'Павел Степанов', N'Технический специалист', N'+7 900 111-33-55', N'stepanov@warehouse.local', CAST(N'2024-09-30' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (11, N'Мария Волкова', N'Специалист по качеству', N'+7 900 222-44-66', N'volkova.m@warehouse.local', CAST(N'2024-10-14' AS Date), 1)
GO
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Position], [Phone], [Email], [HireDate], [IsActive]) VALUES (12, N'Игорь Семёнов', N'Водитель', N'+7 900 333-55-77', N'semenov@warehouse.local', CAST(N'2024-11-25' AS Date), 1)
GO
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[EquipmentTypes] ON 
GO
INSERT [dbo].[EquipmentTypes] ([EquipmentTypeID], [TypeName], [MaintenanceIntervalDays]) VALUES (1, N'Погрузчик', 30)
GO
INSERT [dbo].[EquipmentTypes] ([EquipmentTypeID], [TypeName], [MaintenanceIntervalDays]) VALUES (2, N'Конвейер', 14)
GO
INSERT [dbo].[EquipmentTypes] ([EquipmentTypeID], [TypeName], [MaintenanceIntervalDays]) VALUES (3, N'Весовой терминал', 45)
GO
INSERT [dbo].[EquipmentTypes] ([EquipmentTypeID], [TypeName], [MaintenanceIntervalDays]) VALUES (4, N'Холодильная установка', 21)
GO
INSERT [dbo].[EquipmentTypes] ([EquipmentTypeID], [TypeName], [MaintenanceIntervalDays]) VALUES (5, N'Штабелер', 20)
GO
INSERT [dbo].[EquipmentTypes] ([EquipmentTypeID], [TypeName], [MaintenanceIntervalDays]) VALUES (6, N'Тележка гидравлическая', 60)
GO
SET IDENTITY_INSERT [dbo].[EquipmentTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventories] ON 
GO
INSERT [dbo].[Inventories] ([InventoryID], [InventoryNumber], [WarehouseID], [EmployeeID], [InventoryDate], [Status]) VALUES (1, N'INV-2026-0001', 1, 1, CAST(N'2026-06-14T08:00:00.0000000' AS DateTime2), N'Завершена')
GO
INSERT [dbo].[Inventories] ([InventoryID], [InventoryNumber], [WarehouseID], [EmployeeID], [InventoryDate], [Status]) VALUES (2, N'INV-2026-0002', 2, 1, CAST(N'2026-06-15T08:00:00.0000000' AS DateTime2), N'Завершена')
GO
INSERT [dbo].[Inventories] ([InventoryID], [InventoryNumber], [WarehouseID], [EmployeeID], [InventoryDate], [Status]) VALUES (3, N'INV-2026-0003', 3, 5, CAST(N'2026-06-16T09:00:00.0000000' AS DateTime2), N'В процессе')
GO
INSERT [dbo].[Inventories] ([InventoryID], [InventoryNumber], [WarehouseID], [EmployeeID], [InventoryDate], [Status]) VALUES (4, N'INV-2026-0004', 4, 5, CAST(N'2026-06-16T10:00:00.0000000' AS DateTime2), N'Запланирована')
GO
SET IDENTITY_INSERT [dbo].[Inventories] OFF
GO
SET IDENTITY_INSERT [dbo].[InventoryResults] ON 
GO
INSERT [dbo].[InventoryResults] ([ResultID], [InventoryID], [BalanceID], [ExpectedQuantity], [ActualQuantity], [Difference], [Comment]) VALUES (1, 1, 1, 12, 12, 0, N'Совпадает')
GO
INSERT [dbo].[InventoryResults] ([ResultID], [InventoryID], [BalanceID], [ExpectedQuantity], [ActualQuantity], [Difference], [Comment]) VALUES (2, 1, 3, 120, 118, -2, N'Недостача 2 уп.')
GO
INSERT [dbo].[InventoryResults] ([ResultID], [InventoryID], [BalanceID], [ExpectedQuantity], [ActualQuantity], [Difference], [Comment]) VALUES (3, 1, 7, 15, 15, 0, N'Совпадает')
GO
INSERT [dbo].[InventoryResults] ([ResultID], [InventoryID], [BalanceID], [ExpectedQuantity], [ActualQuantity], [Difference], [Comment]) VALUES (4, 1, 22, 200, 198, -2, N'Недостача пакетов')
GO
INSERT [dbo].[InventoryResults] ([ResultID], [InventoryID], [BalanceID], [ExpectedQuantity], [ActualQuantity], [Difference], [Comment]) VALUES (5, 2, 9, 300, 298, -2, N'Недостача крепежа')
GO
INSERT [dbo].[InventoryResults] ([ResultID], [InventoryID], [BalanceID], [ExpectedQuantity], [ActualQuantity], [Difference], [Comment]) VALUES (6, 2, 17, 260, 255, -5, N'Недостача розеток')
GO
INSERT [dbo].[InventoryResults] ([ResultID], [InventoryID], [BalanceID], [ExpectedQuantity], [ActualQuantity], [Difference], [Comment]) VALUES (7, 3, 13, 180, 180, 0, N'Совпадает')
GO
INSERT [dbo].[InventoryResults] ([ResultID], [InventoryID], [BalanceID], [ExpectedQuantity], [ActualQuantity], [Difference], [Comment]) VALUES (8, 4, 15, 40, 39, -1, N'Незначительная недостача')
GO
SET IDENTITY_INSERT [dbo].[InventoryResults] OFF
GO
SET IDENTITY_INSERT [dbo].[MaintenancePlans] ON 
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (1, 1, CAST(N'2026-06-18' AS Date), N'Проверка гидравлики и АКБ', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (2, 2, CAST(N'2026-06-21' AS Date), N'Диагностика роликов и привода', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (3, 4, CAST(N'2026-06-25' AS Date), N'Проверка температурных датчиков', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (4, 5, CAST(N'2026-06-20' AS Date), N'Проверка электропривода штабелера', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (5, 6, CAST(N'2026-06-23' AS Date), N'Смазка гидравлики тележки', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (6, 7, CAST(N'2026-06-19' AS Date), N'Проверка тормозной системы', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (7, 8, CAST(N'2026-06-18' AS Date), N'Ремонт подъёмного механизма', N'В работе')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (8, 9, CAST(N'2026-06-22' AS Date), N'Замена масла', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (9, 10, CAST(N'2026-06-24' AS Date), N'Проверка ремней конвейера', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (10, 12, CAST(N'2026-06-26' AS Date), N'Диагностика двигателя', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (11, 13, CAST(N'2026-06-28' AS Date), N'Калибровка весового терминала', N'Запланировано')
GO
INSERT [dbo].[MaintenancePlans] ([PlanID], [EquipmentID], [PlannedDate], [WorkDescription], [Status]) VALUES (12, 14, CAST(N'2026-06-21' AS Date), N'Проверка компрессора', N'Запланировано')
GO
SET IDENTITY_INSERT [dbo].[MaintenancePlans] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductionLines] ON 
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (1, 1, N'Линия комплектации A', N'День', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (2, 1, N'Линия упаковки B', N'Ночь', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (3, 2, N'Линия маркировки C', N'День', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (4, 2, N'Линия фасовки D', N'День', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (5, 3, N'Линия сборки E', N'День', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (6, 3, N'Линия упаковки F', N'Ночь', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (7, 4, N'Линия маркировки G', N'День', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (8, 4, N'Линия комплектации H', N'Ночь', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (9, 1, N'Линия контроля качества I', N'День', 1)
GO
INSERT [dbo].[ProductionLines] ([LineID], [WarehouseID], [LineName], [ShiftCode], [IsActive]) VALUES (10, 2, N'Линия резерв J', N'День', 0)
GO
SET IDENTITY_INSERT [dbo].[ProductionLines] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (1, N'DRL-500', N'Дрель ударная 500 Вт', N'Бытовая ударная дрель', CAST(2600.00 AS Decimal(12, 2)), CAST(3490.00 AS Decimal(12, 2)), 1, 1, 1, 5, 1, N'https://commons.wikimedia.org/wiki/Special:FilePath/Hammer%20drill-1.jpg?width=800')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (2, N'SCR-18', N'Шуруповёрт 18 В', N'Аккумуляторный шуруповёрт', CAST(4100.00 AS Decimal(12, 2)), CAST(5590.00 AS Decimal(12, 2)), 1, 1, 1, 4, 1, N'https://imgs.search.brave.com/P8X-qXd2khFueEwxks-zWzVOjr0sdswY6KOn1b7A4OE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dnNlaW5zdHJ1bWVu/dGkucnUvaW1hZ2Vz/L2dvb2RzL3N0cm9p/dGVsbnlqLWluc3Ry/dW1lbnQvc2h1cnVw/b3ZlcnR5LzE1NzI4/MDY4LzU2MHg1MDQv/MTkyMDA2ODY0Lmpw/Zw')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (3, N'BOLT-M8', N'Болт М8 оцинкованный', N'Упаковка 100 шт', CAST(180.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)), 2, 2, 2, 20, 1, N'https://imgs.search.brave.com/1llRQJHasL3MWwp4Z6tUJXTjsneQXNX5AeOpGyCRIxo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/c29iZXJpemF2b2Qu/cnUvdXBsb2FkL3Jl/c2l6ZV9jYWNoZS9p/YmxvY2svZDZkL3N3/ZHR2a2J6MTYxamhz/eDE0bDdyYXRicHl1/ODh4cXZ5LzQ0MF8z/MzBfMS9ib2x0LXMt/c2hlc3RpZ3Jhbm5v/eS1nb2xvdmtveS1t/OC1raC0yMC1nb3N0/LTc3OThfNzBfLWI0/MV9zb2Jlcml6YXZv/ZC0uanBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (4, N'PIPE-20', N'Труба ПП 20 мм', N'Полипропиленовая труба', CAST(55.00 AS Decimal(12, 2)), CAST(89.00 AS Decimal(12, 2)), 3, 3, 2, 100, 1, N'https://imgs.search.brave.com/IaC9mI33tAtYZPtYVvE2SDOp9j-EPCGJQqijHiy5YYE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9ydHAu/cnUvdXBsb2FkL3Jl/c2l6ZV9jYWNoZS9p/YmxvY2svYWZjLzUw/MF81MDBfMi9hYmlk/cDNyNzJodnpqZnE4/bnVmbHRucmQ1cThu/MjU3ai5qcGc')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (5, N'LED-12', N'Лампа LED 12 Вт', N'Тёплый свет E27', CAST(95.00 AS Decimal(12, 2)), CAST(149.00 AS Decimal(12, 2)), 4, 1, 3, 50, 1, N'https://imgs.search.brave.com/T-mGbSlEDAnzwemmqSfk4r6d2x3QLsvwkBaLAUdRGN4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9lbGVj/dHJvLWtvdC5ydS9p/bWFnZS9jYWNoZS9j/YXRhbG9nL3N2ZXRv/ZGlvZG55ZS9iYXk5/cy1oMjF3L2xlZC1s/YW1wYS1hdG9taWMt/NnNtZDMwMzAtaDIx/dy8wMmMzMDk0NWYy/NzIyNWU5MjlmNTI1/ZmRjYTFmNWY1Zi5q/cGc')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (6, N'MIX-01', N'Смеситель кухонный', N'Однорычажный смеситель', CAST(2100.00 AS Decimal(12, 2)), CAST(2990.00 AS Decimal(12, 2)), 3, 1, 2, 6, 1, N'https://imgs.search.brave.com/qJjiWbL_AWvc2b4R-B_Zq7SFYZM66fVBUWSgpEROMjY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hbWl4/LXRrLnJ1L2ltYWdl/cy9LYXRhbG9nLzA2/MzAwMDAwU21lc2l0/ZWxpX0FjY29vbmEv/YTQ4OTBmLTEtMDEu/anBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (7, N'PERF-26', N'Перфоратор 900 Вт', N'Перфоратор для бетона и кирпича', CAST(5400.00 AS Decimal(12, 2)), CAST(7290.00 AS Decimal(12, 2)), 1, 1, 1, 3, 1, N'https://imgs.search.brave.com/Enez-Z1Ct5MpgokyqwUMsISbAnlVu-Z6bIbxae0Je2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9idWRw/b3N0YWNoLnVhL2lt/YWdlL2NhY2hlL2Nh/dGFsb2cvZWFzeXBo/b3RvLzMxODUvbWFr/aXRhLWhyMTQwZHot/YWt1bXVseWF0b3Ju/aXktcGVyZm9yYXRv/ci0yLTI0NHgyMTEu/anBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (8, N'GRD-125', N'УШМ (болгарка) 125 мм', N'Угловая шлифовальная машина', CAST(2300.00 AS Decimal(12, 2)), CAST(3190.00 AS Decimal(12, 2)), 1, 1, 5, 5, 1, N'https://imgs.search.brave.com/Q4BgPTxZbKKw5COV_r_ZWlhqsajgIk-g4R9sTrZNpsw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly92aXRh/bHMudWEvaW1hZ2Uv/Y2FjaGUvY2F0YWxv/Zy9kZW1vL2VsZWN0/cm8tdG9vbHMvbHMt/MTI5MGtudnAvbHMx/Mjkwa252cC0xLTQ5/MngzNzcuanBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (9, N'SCREW-M6', N'Шуруп М6 кровельный', N'Упаковка 200 шт', CAST(95.00 AS Decimal(12, 2)), CAST(140.00 AS Decimal(12, 2)), 2, 2, 2, 30, 1, N'https://imgs.search.brave.com/USMlvgeC0XZibIKX6Ml45jakwnVkhDSVRV021cqifBE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zaHJ1/YmthLmN2LnVhL3Ro/dW1ibmFpbC5waHA_/cGFnZT1pdGVtc19t/YWluX3BodCZmaWxl/PWZ0cC9waG90b3Mv/MDAwMTg3MTQuanBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (10, N'ANCHOR-10', N'Анкер забивной 10 мм', N'Упаковка 50 шт', CAST(210.00 AS Decimal(12, 2)), CAST(300.00 AS Decimal(12, 2)), 2, 2, 2, 15, 1, N'https://imgs.search.brave.com/wuMnvz_Cr3TZL_E72JIf-guDYzkH4p5BLPfZCsVH4HE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cHJvbXJ1a2F2LXNo/b3AucnUvdGh1bWJz/L3Jlc2l6ZS8zODB4/NDI1L3VwbG9hZHMv/cHJvZHVjdHMvMTc4/OTcwNTcwNDY2OGUz/MDJmOWExNGQuanBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (11, N'PIPE-32', N'Труба ПП 32 мм', N'Полипропиленовая труба', CAST(75.00 AS Decimal(12, 2)), CAST(120.00 AS Decimal(12, 2)), 3, 3, 2, 80, 1, N'https://imgs.search.brave.com/NTWWfidtDCXe0mnAYnXaFUw0OvzXTymxnowkXuFo4Q8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zYW50/ZWgyNC5ieS91cGxv/YWQvcmVzaXplX2Nh/Y2hlL2libG9jay8x/NjIvNjAwXzYwMF8x/NDBjZDc1MGJiYTk4/NzBmMThhYWRhMjQ3/OGIyNDg0MGEvMTYy/YTRkZjA0ZTFiZGMy/YzgwN2M5MjMzNjhh/N2YyZDQuanBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (12, N'FAUCET-02', N'Смеситель для ванны', N'Однорычажный смеситель с лейкой', CAST(2400.00 AS Decimal(12, 2)), CAST(3390.00 AS Decimal(12, 2)), 3, 1, 2, 4, 1, N'https://imgs.search.brave.com/x-OCW5AhgKa3r7r0qynHd-z6UUskpEh0GbioKpqQ4SM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zYW50/ZWhuaWthLW9rLnJ1/L2ltZy9jYXRwaG90/b3MvMjIvcHJlX3Nt/ZXNpdGVsLWxlZGVt/ZS1oMjgtbDIyMjgt/YjEuanBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (13, N'LED-PANEL', N'LED панель потолочная 36 Вт', N'Светодиодная панель 600х600', CAST(850.00 AS Decimal(12, 2)), CAST(1290.00 AS Decimal(12, 2)), 4, 1, 3, 10, 1, N'https://imgs.search.brave.com/EijcyB97hJiY85RAkNSqSKq1mbAxmRrJlDLuzB35wEE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMucHJvbS51YS81/NTcwNTAyNzc3X3cy/MDBfaDIwMF9zdmV0/b2Rpb2RuYXlhLXBv/dG9sb2NobmF5YS1w/YW5lbC5qcGc')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (14, N'BULB-E27', N'Лампа накаливания E27 60 Вт', N'Классическая лампа накаливания', CAST(35.00 AS Decimal(12, 2)), CAST(65.00 AS Decimal(12, 2)), 4, 1, 3, 100, 1, N'https://imgs.search.brave.com/w1gXtYvlpsYk82ZGl8Usps5PYD56zQvyxoC2TvYum9o/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/MjcudWEvc2MtLW1l/ZGlhLS1wcm9kL2Rl/ZmF1bHQvNjIvNzYv/MjEvNjI3NjIxZGMt/ZjE1Ni00ZjVlLTgw/ZmItYmM2MjI3N2E3/MDRiLmpwZw')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (15, N'CABLE-3X2.5', N'Кабель ВВГ 3х2.5', N'Бухта 100 м', CAST(3200.00 AS Decimal(12, 2)), CAST(4490.00 AS Decimal(12, 2)), 5, 6, 9, 10, 1, N'https://imgs.search.brave.com/YTAuFT2dn2naNBrbrt37sp_G087D4Dt_GUHTozvYAtA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93c2Qu/YnkvdXBsb2FkL3Jl/c2l6ZV9jYWNoZS9p/YmxvY2svMzA5L3d1/eno2NGFxaDEweGhw/cnBnN2Y5cjNqd2Q4/MjQzaWhsLzIyMF8y/MDBfMS9tczAzMzQz/NC01MDB4NDAwLmpw/Zw')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (16, N'SWITCH-01', N'Выключатель одноклавишный', N'Бытовой выключатель', CAST(110.00 AS Decimal(12, 2)), CAST(179.00 AS Decimal(12, 2)), 5, 1, 9, 40, 1, N'https://imgs.search.brave.com/0baX5wcdAQTTQc3jp1gxCN5U99aOBAN_3STMyYf0NWY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dnNlaW5zdHJ1bWVu/dGkucnUvaW1hZ2Vz/L2dvb2RzL2VsZWt0/cmlrYS1pLXN2ZXQv/cm96ZXRraS1pLXZ5/a2x5dWNoYXRlbGkv/ODcyNzEyLzU2MHg1/MDQvNTM4Nzk0NzQu/anBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (17, N'SOCKET-01', N'Розетка с заземлением', N'Бытовая розетка', CAST(130.00 AS Decimal(12, 2)), CAST(199.00 AS Decimal(12, 2)), 5, 1, 9, 40, 1, N'https://imgs.search.brave.com/k8ko2UCRvTQnBpGeO5jUtsFEfaCloItiBXBUkCdWx1o/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hdmF0/YXJzLm1kcy55YW5k/ZXgubmV0L2dldC1t/cGljLzUyNTIyNzcv/MmEwMDAwMDE5MjM0/ZDIxOTQ5NTVmNWQw/NTk4ZWU4YTQxYTE3/L29yaWc')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (18, N'HAMMER-500', N'Молоток слесарный 500 г', N'Молоток с фиберглассовой ручкой', CAST(320.00 AS Decimal(12, 2)), CAST(470.00 AS Decimal(12, 2)), 6, 1, 5, 15, 1, N'https://imgs.search.brave.com/6ig9tbuYnbAqs0CctRtGCokzEzWbtOW6pkogy8Pa7cI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zMy5p/bnRlcnRvb2wudWEv/cmVzaXplL2IyYy9p/bWFnZXMvcHJvZHVj/dHMvb3JpZ2luYWwv/aW50ZXJ0b29sLWh0/LTAyNTAtb3JpZ2lu/YWwuanBnP3dpZHRo/PTI0MCZoZWlnaHQ9/MjQw')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (19, N'SCRDRV-SET', N'Набор отвёрток 6 предметов', N'Набор шлицевых и крестовых отвёрток', CAST(450.00 AS Decimal(12, 2)), CAST(650.00 AS Decimal(12, 2)), 6, 2, 5, 12, 1, N'https://imgs.search.brave.com/hATl99DZCyOpl4iNMiGGDhnPCUDYiOijAvKfe2eBe_c/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dnNlaW5zdHJ1bWVu/dGkucnUvaW1hZ2Vz/L2dvb2RzL3J1Y2hu/b2otaW5zdHJ1bWVu/dC9vdHZlcnRraS80/NTYxNzQ2LzU2MHg1/MDQvNjM1NDEwMDIu/anBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (20, N'GLOVES-01', N'Перчатки рабочие х/б', N'Упаковка 12 пар', CAST(180.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)), 7, 2, 6, 25, 1, N'https://imgs.search.brave.com/PCfE2Rn8pk0jXPh7APORu36A6TzaGspIPvsT-_cWbD8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zcGVj/b3ZrYS5ieS9zdG9y/YWdlL3RodW1iL3By/b2R1Y3RzL3c3MjBf/aDcyMF85MTFfZDUz/NGUzOGFmZWVhZTI4/YjM4OGI2MzU2M2Q2/ODFhMjIuanBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (21, N'HELMET-01', N'Каска защитная строительная', N'Защитная каска по ГОСТ', CAST(410.00 AS Decimal(12, 2)), CAST(590.00 AS Decimal(12, 2)), 7, 1, 6, 10, 1, N'https://imgs.search.brave.com/muyWzYDiWYQDe6hjEGK1pkGn2Cq0HtRCmabepMaHgb4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly94aW16/YS5ydS91cGxvYWQv/cmVzaXplX2NhY2hl/L2libG9jay83NDkv/MzAwXzMwMF8xNDBj/ZDc1MGJiYTk4NzBm/MThhYWRhMjQ3OGIy/NDg0MGEvZWVwNmhl/bnAxeWd3eWphaTEy/ODEwN25xNGw4ajdz/cGEuanBn')
GO
INSERT [dbo].[Products] ([ProductID], [Sku], [ProductName], [Description], [PurchasePrice], [SalePrice], [CategoryID], [UnitID], [SupplierID], [MinStock], [IsActive], [ImagePath]) VALUES (22, N'BAG-50', N'Мешки для мусора 50 л', N'Упаковка 50 шт', CAST(145.00 AS Decimal(12, 2)), CAST(220.00 AS Decimal(12, 2)), 8, 2, 7, 20, 1, N'https://imgs.search.brave.com/Hvgwwwnwz_B6t938vz8nRS_XOT6KUx7GfJp0z4rJ-7Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dnNlaW5zdHJ1bWVu/dGkucnUvaW1hZ2Vz/L2dvb2RzL3Jhc2hv/ZG55ZS1tYXRlcmlh/bHktaS1vc25hc3Rr/YS9yYXNob2RuaWtp/LWRseWEtc3Ryb2l0/ZWxub2dvLW9ib3J1/ZG92YW5peWEvMTU5/MDkyMC81NjB4NTA0/LzUyNzk1OTE5Lmpw/Zw')
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[QualityChecks] ON 
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (1, 1, 1, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Маркировка и упаковка соответствуют норме')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (2, 2, 2, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Габариты партии подтверждены')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (3, 3, 3, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'На контроле', N'Требуется повторная проверка паллеты')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (4, 20, 8, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Проверка партии перчаток')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (5, 13, 11, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Светотехника соответствует ТУ')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (6, 15, 11, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Сечение кабеля проверено')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (7, 7, 1, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Инструмент протестирован')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (8, 9, 2, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'На контроле', N'Требуется проверка партии крепежа')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (9, 12, 11, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Смеситель без дефектов')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (10, 21, 8, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Каски соответствуют ГОСТ')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (11, 4, 2, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Не пройдено', N'Обнаружен брак партии труб')
GO
INSERT [dbo].[QualityChecks] ([QualityCheckID], [ProductID], [EmployeeID], [CheckDate], [Result], [Comment]) VALUES (12, 18, 11, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), N'Пройдено', N'Молотки проверены')
GO
SET IDENTITY_INSERT [dbo].[QualityChecks] OFF
GO
SET IDENTITY_INSERT [dbo].[ReceiptItems] ON 
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (1, 1, 1, 1, 10, CAST(2600.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (2, 1, 2, 1, 5, CAST(4100.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (3, 2, 3, 2, 100, CAST(180.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (4, 2, 4, 3, 300, CAST(55.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (5, 3, 13, 6, 50, CAST(850.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (6, 3, 14, 6, 200, CAST(35.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (7, 4, 15, 9, 20, CAST(3200.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (8, 4, 16, 9, 100, CAST(110.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (9, 4, 17, 16, 100, CAST(130.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (10, 5, 7, 5, 10, CAST(5400.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (11, 5, 8, 5, 15, CAST(2300.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (12, 5, 18, 11, 30, CAST(320.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (13, 6, 20, 13, 40, CAST(180.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (14, 6, 21, 13, 20, CAST(410.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (15, 7, 22, 15, 100, CAST(145.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ReceiptItems] ([ReceiptItemID], [ReceiptID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (16, 8, 2, 1, 8, CAST(4100.00 AS Decimal(12, 2)))
GO
SET IDENTITY_INSERT [dbo].[ReceiptItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Receipts] ON 
GO
INSERT [dbo].[Receipts] ([ReceiptID], [ReceiptNumber], [SupplierID], [EmployeeID], [ReceiptDate], [Comment]) VALUES (1, N'REC-2026-0001', 1, 2, CAST(N'2026-06-10T10:00:00.0000000' AS DateTime2), N'Плановая поставка')
GO
INSERT [dbo].[Receipts] ([ReceiptID], [ReceiptNumber], [SupplierID], [EmployeeID], [ReceiptDate], [Comment]) VALUES (2, N'REC-2026-0002', 2, 2, CAST(N'2026-06-11T11:30:00.0000000' AS DateTime2), N'Метизы и сантехника')
GO
INSERT [dbo].[Receipts] ([ReceiptID], [ReceiptNumber], [SupplierID], [EmployeeID], [ReceiptDate], [Comment]) VALUES (3, N'REC-2026-0003', 3, 2, CAST(N'2026-06-12T09:15:00.0000000' AS DateTime2), N'Поставка светотехники')
GO
INSERT [dbo].[Receipts] ([ReceiptID], [ReceiptNumber], [SupplierID], [EmployeeID], [ReceiptDate], [Comment]) VALUES (4, N'REC-2026-0004', 9, 4, CAST(N'2026-06-13T10:00:00.0000000' AS DateTime2), N'Поставка кабельной продукции')
GO
INSERT [dbo].[Receipts] ([ReceiptID], [ReceiptNumber], [SupplierID], [EmployeeID], [ReceiptDate], [Comment]) VALUES (5, N'REC-2026-0005', 5, 4, CAST(N'2026-06-14T11:20:00.0000000' AS DateTime2), N'Поставка инструмента')
GO
INSERT [dbo].[Receipts] ([ReceiptID], [ReceiptNumber], [SupplierID], [EmployeeID], [ReceiptDate], [Comment]) VALUES (6, N'REC-2026-0006', 6, 2, CAST(N'2026-06-15T08:45:00.0000000' AS DateTime2), N'Поставка СИЗ')
GO
INSERT [dbo].[Receipts] ([ReceiptID], [ReceiptNumber], [SupplierID], [EmployeeID], [ReceiptDate], [Comment]) VALUES (7, N'REC-2026-0007', 7, 6, CAST(N'2026-06-16T13:10:00.0000000' AS DateTime2), N'Поставка хозтоваров')
GO
INSERT [dbo].[Receipts] ([ReceiptID], [ReceiptNumber], [SupplierID], [EmployeeID], [ReceiptDate], [Comment]) VALUES (8, N'REC-2026-0008', 1, 2, CAST(N'2026-06-16T15:30:00.0000000' AS DateTime2), N'Дополнительная поставка электроинструмента')
GO
SET IDENTITY_INSERT [dbo].[Receipts] OFF
GO
SET IDENTITY_INSERT [dbo].[ShipmentItems] ON 
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (1, 1, 1, 1, 3, CAST(3490.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (2, 1, 5, 4, 20, CAST(149.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (3, 2, 3, 2, 30, CAST(260.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (4, 3, 4, 3, 40, CAST(89.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (5, 3, 18, 11, 10, CAST(470.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (6, 4, 14, 6, 50, CAST(65.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (7, 4, 22, 15, 20, CAST(220.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (8, 5, 7, 5, 5, CAST(7290.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (9, 5, 19, 12, 8, CAST(650.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (10, 6, 6, 3, 3, CAST(2990.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (11, 7, 15, 9, 5, CAST(4490.00 AS Decimal(12, 2)))
GO
INSERT [dbo].[ShipmentItems] ([ShipmentItemID], [ShipmentID], [ProductID], [LocationID], [Quantity], [UnitPrice]) VALUES (12, 8, 17, 16, 60, CAST(199.00 AS Decimal(12, 2)))
GO
SET IDENTITY_INSERT [dbo].[ShipmentItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Shipments] ON 
GO
INSERT [dbo].[Shipments] ([ShipmentID], [ShipmentNumber], [ClientID], [EmployeeID], [ShipmentDate], [Comment]) VALUES (1, N'SHP-2026-0001', 1, 3, CAST(N'2026-06-12T15:20:00.0000000' AS DateTime2), N'Отгрузка по заявке')
GO
INSERT [dbo].[Shipments] ([ShipmentID], [ShipmentNumber], [ClientID], [EmployeeID], [ShipmentDate], [Comment]) VALUES (2, N'SHP-2026-0002', 2, 3, CAST(N'2026-06-13T09:40:00.0000000' AS DateTime2), N'Самовывоз')
GO
INSERT [dbo].[Shipments] ([ShipmentID], [ShipmentNumber], [ClientID], [EmployeeID], [ShipmentDate], [Comment]) VALUES (3, N'SHP-2026-0003', 4, 7, CAST(N'2026-06-13T14:00:00.0000000' AS DateTime2), N'Отгрузка стройматериалов')
GO
INSERT [dbo].[Shipments] ([ShipmentID], [ShipmentNumber], [ClientID], [EmployeeID], [ShipmentDate], [Comment]) VALUES (4, N'SHP-2026-0004', 5, 7, CAST(N'2026-06-14T10:30:00.0000000' AS DateTime2), N'Доставка по графику')
GO
INSERT [dbo].[Shipments] ([ShipmentID], [ShipmentNumber], [ClientID], [EmployeeID], [ShipmentDate], [Comment]) VALUES (5, N'SHP-2026-0005', 6, 3, CAST(N'2026-06-15T11:00:00.0000000' AS DateTime2), N'Отгрузка инструмента')
GO
INSERT [dbo].[Shipments] ([ShipmentID], [ShipmentNumber], [ClientID], [EmployeeID], [ShipmentDate], [Comment]) VALUES (6, N'SHP-2026-0006', 3, 7, CAST(N'2026-06-15T16:20:00.0000000' AS DateTime2), N'Повторный заказ')
GO
INSERT [dbo].[Shipments] ([ShipmentID], [ShipmentNumber], [ClientID], [EmployeeID], [ShipmentDate], [Comment]) VALUES (7, N'SHP-2026-0007', 7, 3, CAST(N'2026-06-16T09:50:00.0000000' AS DateTime2), N'Отгрузка кабеля и электрики')
GO
INSERT [dbo].[Shipments] ([ShipmentID], [ShipmentNumber], [ClientID], [EmployeeID], [ShipmentDate], [Comment]) VALUES (8, N'SHP-2026-0008', 1, 7, CAST(N'2026-06-16T17:00:00.0000000' AS DateTime2), N'Дополнительная отгрузка')
GO
SET IDENTITY_INSERT [dbo].[Shipments] OFF
GO
SET IDENTITY_INSERT [dbo].[StockBalances] ON 
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (1, 1, 1, 12, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (2, 2, 1, 8, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (3, 3, 2, 120, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (4, 4, 3, 350, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (5, 5, 4, 210, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (6, 6, 3, 9, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (7, 7, 5, 15, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (8, 8, 6, 20, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (9, 9, 7, 300, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (10, 10, 8, 150, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (11, 11, 9, 400, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (12, 12, 10, 8, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (13, 13, 11, 180, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (14, 14, 12, 500, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (15, 15, 13, 40, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (16, 16, 14, 250, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (17, 17, 16, 260, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (18, 18, 11, 90, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (19, 19, 12, 60, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (20, 20, 13, 140, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (21, 21, 13, 55, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (22, 22, 15, 200, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (23, 2, 9, 6, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (24, 4, 16, 120, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (25, 4, 1, 20, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (26, 21, 2, 221, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (27, 1, 3, 116, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (28, 9, 4, 263, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (29, 12, 7, 117, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (30, 18, 9, 106, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (31, 2, 10, 147, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (32, 8, 11, 18, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (33, 5, 13, 284, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (34, 19, 13, 221, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (35, 11, 14, 8, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[StockBalances] ([BalanceID], [ProductID], [LocationID], [Quantity], [UpdatedAt]) VALUES (36, 15, 14, 86, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[StockBalances] OFF
GO
SET IDENTITY_INSERT [dbo].[StorageLocations] ON 
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (1, 1, N'A-01-01', CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (2, 1, N'A-01-02', CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (3, 2, N'B-02-01', CAST(750.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (4, 3, N'C-01-01', CAST(400.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (5, 1, N'A-01-03', CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (6, 2, N'B-02-02', CAST(750.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (7, 3, N'C-01-02', CAST(400.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (8, 4, N'C-02-01', CAST(600.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (9, 5, N'A-03-01', CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (10, 6, N'B-03-01', CAST(350.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (11, 7, N'A-04-01', CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (12, 8, N'B-04-01', CAST(450.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (13, 9, N'A-05-01', CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (14, 10, N'B-05-01', CAST(400.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (15, 1, N'A-01-04', CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[StorageLocations] ([LocationID], [ZoneID], [LocationCode], [MaxWeight]) VALUES (16, 3, N'C-01-03', CAST(400.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[StorageLocations] OFF
GO
SET IDENTITY_INSERT [dbo].[StorageZones] ON 
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (1, 1, N'A', N'Обычный')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (2, 1, N'B', N'Обычный')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (3, 2, N'C', N'Тёплый')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (4, 1, N'C', N'Холодный')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (5, 2, N'A', N'Обычный')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (6, 2, N'B', N'Холодный')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (7, 3, N'A', N'Обычный')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (8, 3, N'B', N'Тёплый')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (9, 4, N'A', N'Обычный')
GO
INSERT [dbo].[StorageZones] ([ZoneID], [WarehouseID], [ZoneName], [TemperatureMode]) VALUES (10, 4, N'B', N'Холодный')
GO
SET IDENTITY_INSERT [dbo].[StorageZones] OFF
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (1, N'ТехноСнаб', N'Мария Волкова', N'+7 495 100-10-10', N'sales@tehnosnab.ru', N'Москва, Складская 1')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (2, N'СтройКомплект', N'Дмитрий Орлов', N'+7 812 200-20-20', N'info@stroikom.ru', N'Санкт-Петербург, Индустриальная 9')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (3, N'СветМаркет', N'Елена Никитина', N'+7 343 300-30-30', N'opt@svetmarket.ru', N'Екатеринбург, Мира 15')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (4, N'ЭлектроМир', N'Виктор Громов', N'+7 495 400-40-40', N'opt@elektromir.ru', N'Москва, Кабельная 7')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (5, N'ИнструментПро', N'Алексей Фролов', N'+7 812 500-50-50', N'sales@instrumentpro.ru', N'Санкт-Петербург, Заводская 3')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (6, N'СпецОдежда Плюс', N'Светлана Кравцова', N'+7 351 600-60-60', N'opt@specodezhda-plus.ru', N'Челябинск, Рабочая 11')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (7, N'ХозТорг', N'Роман Беляев', N'+7 383 700-70-70', N'sales@hoztorg.ru', N'Новосибирск, Складская 22')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (8, N'МеталлТрейд', N'Юлия Карпова', N'+7 861 800-80-80', N'info@metalltrade.ru', N'Краснодар, Промышленная 5')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (9, N'КабельСнаб', N'Артём Гусев', N'+7 495 900-90-90', N'opt@kabelsnab.ru', N'Москва, Электротехническая 14')
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactPerson], [Phone], [Email], [Address]) VALUES (10, N'ИнжСтрой', N'Наталья Воронина', N'+7 843 010-10-10', N'order@injstroy.ru', N'Казань, Строителей 6')
GO
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[Units] ON 
GO
INSERT [dbo].[Units] ([UnitID], [UnitName], [ShortName]) VALUES (1, N'Штука', N'шт')
GO
INSERT [dbo].[Units] ([UnitID], [UnitName], [ShortName]) VALUES (2, N'Упаковка', N'уп')
GO
INSERT [dbo].[Units] ([UnitID], [UnitName], [ShortName]) VALUES (3, N'Метр', N'м')
GO
INSERT [dbo].[Units] ([UnitID], [UnitName], [ShortName]) VALUES (4, N'Килограмм', N'кг')
GO
INSERT [dbo].[Units] ([UnitID], [UnitName], [ShortName]) VALUES (5, N'Литр', N'л')
GO
INSERT [dbo].[Units] ([UnitID], [UnitName], [ShortName]) VALUES (6, N'Рулон', N'рул')
GO
SET IDENTITY_INSERT [dbo].[Units] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 
GO
INSERT [dbo].[UserRoles] ([RoleID], [RoleName], [Description]) VALUES (1, N'Администратор', N'Полный доступ')
GO
INSERT [dbo].[UserRoles] ([RoleID], [RoleName], [Description]) VALUES (2, N'Кладовщик', N'Складские операции')
GO
INSERT [dbo].[UserRoles] ([RoleID], [RoleName], [Description]) VALUES (3, N'Менеджер', N'Просмотр и отгрузки клиентам')
GO
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (1, N'Иван Петров', N'admin', N'admin', N'petrov@warehouse.local', N'+7 900 111-22-33', 1, 1, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (2, N'Анна Смирнова', N'store', N'store', N'smirnova@warehouse.local', N'+7 900 222-33-44', 2, 2, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (3, N'Олег Соколов', N'manager', N'manager', N'sokolov@warehouse.local', N'+7 900 333-44-55', 3, 3, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (4, N'Сергей Кузнецов', N'kuznetsov', N'kuznetsov', N'kuznetsov@warehouse.local', N'+7 900 444-55-66', 2, 4, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (5, N'Татьяна Лебедева', N'lebedeva', N'lebedeva', N'lebedeva@warehouse.local', N'+7 900 555-66-77', 3, 5, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (6, N'Дмитрий Васильев', N'vasilev', N'vasilev', N'vasilev@warehouse.local', N'+7 900 666-77-88', 2, 6, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (7, N'Екатерина Морозова', N'morozova', N'morozova', N'morozova@warehouse.local', N'+7 900 777-88-99', 3, 7, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (8, N'Андрей Новиков', N'novikov', N'novikov', N'novikov@warehouse.local', N'+7 900 888-99-00', 2, 8, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (9, N'Ольга Захарова', N'zaharova', N'zaharova', N'zaharova@warehouse.local', N'+7 900 999-00-11', 3, 9, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (10, N'Павел Степанов', N'stepanov', N'stepanov', N'stepanov@warehouse.local', N'+7 900 111-33-55', 2, 10, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (11, N'Мария Волкова', N'volkova_m', N'volkova_m', N'volkova.m@warehouse.local', N'+7 900 222-44-66', 2, 11, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [Login], [Password], [Email], [Phone], [RoleID], [EmployeeID], [CreatedAt], [IsBlocked]) VALUES (12, N'Игорь Семёнов', N'semenov', N'semenov', N'semenov@warehouse.local', N'+7 900 333-55-77', 2, 12, CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2), 0)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[WarehouseEquipment] ON 
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (1, 1, 1, N'EQ-FORK-001', N'Погрузчик Still RX20', CAST(N'2024-02-10' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (2, 1, 2, N'EQ-CONV-001', N'Конвейер приемки A1', CAST(N'2024-03-18' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (3, 2, 3, N'EQ-SCALE-002', N'Весовой терминал зона B', CAST(N'2024-04-05' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (4, 2, 4, N'EQ-COLD-002', N'Холодильный контур C2', CAST(N'2024-05-11' AS Date), N'Плановое ТО')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (5, 1, 5, N'EQ-STACK-001', N'Штабелер электрический S1', CAST(N'2024-06-01' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (6, 1, 6, N'EQ-CART-001', N'Тележка гидравлическая T1', CAST(N'2024-06-15' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (7, 2, 1, N'EQ-FORK-002', N'Погрузчик Toyota 8FG', CAST(N'2024-07-01' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (8, 2, 5, N'EQ-STACK-002', N'Штабелер электрический S2', CAST(N'2024-07-10' AS Date), N'На ремонте')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (9, 3, 1, N'EQ-FORK-003', N'Погрузчик Komatsu FG25', CAST(N'2024-08-01' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (10, 3, 2, N'EQ-CONV-002', N'Конвейер отгрузки B1', CAST(N'2024-08-15' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (11, 3, 6, N'EQ-CART-002', N'Тележка гидравлическая T2', CAST(N'2024-09-01' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (12, 4, 1, N'EQ-FORK-004', N'Погрузчик Still RX60', CAST(N'2024-09-10' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (13, 4, 3, N'EQ-SCALE-003', N'Весовой терминал зона A', CAST(N'2024-09-20' AS Date), N'В работе')
GO
INSERT [dbo].[WarehouseEquipment] ([EquipmentID], [WarehouseID], [EquipmentTypeID], [InventoryNumber], [EquipmentName], [CommissionedAt], [Status]) VALUES (14, 4, 4, N'EQ-COLD-003', N'Холодильный контур D1', CAST(N'2024-10-01' AS Date), N'Плановое ТО')
GO
SET IDENTITY_INSERT [dbo].[WarehouseEquipment] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouses] ON 
GO
INSERT [dbo].[Warehouses] ([WarehouseID], [WarehouseName], [Address]) VALUES (1, N'Центральный склад', N'Москва, Промышленная 12')
GO
INSERT [dbo].[Warehouses] ([WarehouseID], [WarehouseName], [Address]) VALUES (2, N'Северный склад', N'Химки, Логистическая 4')
GO
INSERT [dbo].[Warehouses] ([WarehouseID], [WarehouseName], [Address]) VALUES (3, N'Южный склад', N'Краснодар, Складская 21')
GO
INSERT [dbo].[Warehouses] ([WarehouseID], [WarehouseName], [Address]) VALUES (4, N'Восточный склад', N'Казань, Логистическая 8')
GO
SET IDENTITY_INSERT [dbo].[Warehouses] OFF
GO
SET IDENTITY_INSERT [dbo].[WorkOrders] ON 
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (1, 1, 1, 1, N'WO-2026-0001', 120, 75, N'В работе', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (2, 2, 2, 2, N'WO-2026-0002', 80, 80, N'Завершен', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (3, 3, 3, 3, N'WO-2026-0003', 60, 15, N'В работе', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (4, 4, 15, 4, N'WO-2026-0004', 50, 50, N'Завершен', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (5, 5, 7, 5, N'WO-2026-0005', 30, 10, N'В работе', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (6, 6, 20, 6, N'WO-2026-0006', 100, 100, N'Завершен', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (7, 7, 17, 7, N'WO-2026-0007', 80, 40, N'В работе', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (8, 8, 22, 8, N'WO-2026-0008', 60, 0, N'Запланирован', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (9, 9, 12, 9, N'WO-2026-0009', 20, 5, N'В работе', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (10, 1, 9, 1, N'WO-2026-0010', 200, 200, N'Завершен', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (11, 2, 16, 2, N'WO-2026-0011', 150, 90, N'В работе', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
INSERT [dbo].[WorkOrders] ([WorkOrderID], [LineID], [ProductID], [EmployeeID], [OrderNumber], [PlannedQuantity], [CompletedQuantity], [Status], [CreatedAt]) VALUES (12, 5, 5, 10, N'WO-2026-0012', 90, 0, N'Запланирован', CAST(N'2026-06-18T00:33:15.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[WorkOrders] OFF
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Categories_CategoryName]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [UQ_Categories_CategoryName] UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_EquipmentTypes_TypeName]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[EquipmentTypes] ADD  CONSTRAINT [UQ_EquipmentTypes_TypeName] UNIQUE NONCLUSTERED 
(
	[TypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Inventories_InventoryNumber]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[Inventories] ADD  CONSTRAINT [UQ_Inventories_InventoryNumber] UNIQUE NONCLUSTERED 
(
	[InventoryNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Products_Sku]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [UQ_Products_Sku] UNIQUE NONCLUSTERED 
(
	[Sku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Receipts_ReceiptNumber]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[Receipts] ADD  CONSTRAINT [UQ_Receipts_ReceiptNumber] UNIQUE NONCLUSTERED 
(
	[ReceiptNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Shipments_ShipmentNumber]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[Shipments] ADD  CONSTRAINT [UQ_Shipments_ShipmentNumber] UNIQUE NONCLUSTERED 
(
	[ShipmentNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Объект:  Index [UQ_StockBalances_ProductID_LocationID]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[StockBalances] ADD  CONSTRAINT [UQ_StockBalances_ProductID_LocationID] UNIQUE NONCLUSTERED 
(
	[ProductID] ASC,
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_StorageLocations_LocationCode]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[StorageLocations] ADD  CONSTRAINT [UQ_StorageLocations_LocationCode] UNIQUE NONCLUSTERED 
(
	[LocationCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_StorageZones_WarehouseID_ZoneName]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[StorageZones] ADD  CONSTRAINT [UQ_StorageZones_WarehouseID_ZoneName] UNIQUE NONCLUSTERED 
(
	[WarehouseID] ASC,
	[ZoneName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Units_ShortName]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[Units] ADD  CONSTRAINT [UQ_Units_ShortName] UNIQUE NONCLUSTERED 
(
	[ShortName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Units_UnitName]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[Units] ADD  CONSTRAINT [UQ_Units_UnitName] UNIQUE NONCLUSTERED 
(
	[UnitName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_UserRoles_RoleName]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[UserRoles] ADD  CONSTRAINT [UQ_UserRoles_RoleName] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Users_Login]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Login] UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_WarehouseEquipment_InventoryNumber]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[WarehouseEquipment] ADD  CONSTRAINT [UQ_WarehouseEquipment_InventoryNumber] UNIQUE NONCLUSTERED 
(
	[InventoryNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_WorkOrders_OrderNumber]    Дата создания скрипта: 18.06.2026 1:10:55 ******/ 
ALTER TABLE [dbo].[WorkOrders] ADD  CONSTRAINT [UQ_WorkOrders_OrderNumber] UNIQUE NONCLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionLogs] ADD  CONSTRAINT [DF_ActionLogs_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Employees_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[EquipmentTypes] ADD  CONSTRAINT [DF_EquipmentTypes_MaintenanceIntervalDays]  DEFAULT ((30)) FOR [MaintenanceIntervalDays]
GO
ALTER TABLE [dbo].[ProductionLines] ADD  CONSTRAINT [DF_ProductionLines_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_MinStock]  DEFAULT ((0)) FOR [MinStock]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[StockBalances] ADD  CONSTRAINT [DF_StockBalances_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[StockBalances] ADD  CONSTRAINT [DF_StockBalances_UpdatedAt]  DEFAULT (sysdatetime()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsBlocked]  DEFAULT ((0)) FOR [IsBlocked]
GO
ALTER TABLE [dbo].[WorkOrders] ADD  CONSTRAINT [DF_WorkOrders_CompletedQuantity]  DEFAULT ((0)) FOR [CompletedQuantity]
GO
ALTER TABLE [dbo].[WorkOrders] ADD  CONSTRAINT [DF_WorkOrders_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ActionLogs]  WITH CHECK ADD  CONSTRAINT [FK_ActionLogs_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ActionLogs] CHECK CONSTRAINT [FK_ActionLogs_Users]
GO
ALTER TABLE [dbo].[Inventories]  WITH CHECK ADD  CONSTRAINT [FK_Inventories_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Inventories] CHECK CONSTRAINT [FK_Inventories_Employees]
GO
ALTER TABLE [dbo].[Inventories]  WITH CHECK ADD  CONSTRAINT [FK_Inventories_Warehouses] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[Inventories] CHECK CONSTRAINT [FK_Inventories_Warehouses]
GO
ALTER TABLE [dbo].[InventoryResults]  WITH CHECK ADD  CONSTRAINT [FK_InventoryResults_Inventories] FOREIGN KEY([InventoryID])
REFERENCES [dbo].[Inventories] ([InventoryID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InventoryResults] CHECK CONSTRAINT [FK_InventoryResults_Inventories]
GO
ALTER TABLE [dbo].[InventoryResults]  WITH CHECK ADD  CONSTRAINT [FK_InventoryResults_StockBalances] FOREIGN KEY([BalanceID])
REFERENCES [dbo].[StockBalances] ([BalanceID])
GO
ALTER TABLE [dbo].[InventoryResults] CHECK CONSTRAINT [FK_InventoryResults_StockBalances]
GO
ALTER TABLE [dbo].[MaintenancePlans]  WITH CHECK ADD  CONSTRAINT [FK_MaintenancePlans_WarehouseEquipment] FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[WarehouseEquipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[MaintenancePlans] CHECK CONSTRAINT [FK_MaintenancePlans_WarehouseEquipment]
GO
ALTER TABLE [dbo].[ProductionLines]  WITH CHECK ADD  CONSTRAINT [FK_ProductionLines_Warehouses] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[ProductionLines] CHECK CONSTRAINT [FK_ProductionLines_Warehouses]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Units] FOREIGN KEY([UnitID])
REFERENCES [dbo].[Units] ([UnitID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Units]
GO
ALTER TABLE [dbo].[QualityChecks]  WITH CHECK ADD  CONSTRAINT [FK_QualityChecks_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[QualityChecks] CHECK CONSTRAINT [FK_QualityChecks_Employees]
GO
ALTER TABLE [dbo].[QualityChecks]  WITH CHECK ADD  CONSTRAINT [FK_QualityChecks_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[QualityChecks] CHECK CONSTRAINT [FK_QualityChecks_Products]
GO
ALTER TABLE [dbo].[ReceiptItems]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptItems_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ReceiptItems] CHECK CONSTRAINT [FK_ReceiptItems_Products]
GO
ALTER TABLE [dbo].[ReceiptItems]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptItems_Receipts] FOREIGN KEY([ReceiptID])
REFERENCES [dbo].[Receipts] ([ReceiptID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ReceiptItems] CHECK CONSTRAINT [FK_ReceiptItems_Receipts]
GO
ALTER TABLE [dbo].[ReceiptItems]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptItems_StorageLocations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[StorageLocations] ([LocationID])
GO
ALTER TABLE [dbo].[ReceiptItems] CHECK CONSTRAINT [FK_ReceiptItems_StorageLocations]
GO
ALTER TABLE [dbo].[Receipts]  WITH CHECK ADD  CONSTRAINT [FK_Receipts_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Receipts] CHECK CONSTRAINT [FK_Receipts_Employees]
GO
ALTER TABLE [dbo].[Receipts]  WITH CHECK ADD  CONSTRAINT [FK_Receipts_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Receipts] CHECK CONSTRAINT [FK_Receipts_Suppliers]
GO
ALTER TABLE [dbo].[ShipmentItems]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentItems_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ShipmentItems] CHECK CONSTRAINT [FK_ShipmentItems_Products]
GO
ALTER TABLE [dbo].[ShipmentItems]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentItems_Shipments] FOREIGN KEY([ShipmentID])
REFERENCES [dbo].[Shipments] ([ShipmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipmentItems] CHECK CONSTRAINT [FK_ShipmentItems_Shipments]
GO
ALTER TABLE [dbo].[ShipmentItems]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentItems_StorageLocations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[StorageLocations] ([LocationID])
GO
ALTER TABLE [dbo].[ShipmentItems] CHECK CONSTRAINT [FK_ShipmentItems_StorageLocations]
GO
ALTER TABLE [dbo].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_Clients] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Shipments] CHECK CONSTRAINT [FK_Shipments_Clients]
GO
ALTER TABLE [dbo].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Shipments] CHECK CONSTRAINT [FK_Shipments_Employees]
GO
ALTER TABLE [dbo].[StockBalances]  WITH CHECK ADD  CONSTRAINT [FK_StockBalances_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[StockBalances] CHECK CONSTRAINT [FK_StockBalances_Products]
GO
ALTER TABLE [dbo].[StockBalances]  WITH CHECK ADD  CONSTRAINT [FK_StockBalances_StorageLocations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[StorageLocations] ([LocationID])
GO
ALTER TABLE [dbo].[StockBalances] CHECK CONSTRAINT [FK_StockBalances_StorageLocations]
GO
ALTER TABLE [dbo].[StorageLocations]  WITH CHECK ADD  CONSTRAINT [FK_StorageLocations_StorageZones] FOREIGN KEY([ZoneID])
REFERENCES [dbo].[StorageZones] ([ZoneID])
GO
ALTER TABLE [dbo].[StorageLocations] CHECK CONSTRAINT [FK_StorageLocations_StorageZones]
GO
ALTER TABLE [dbo].[StorageZones]  WITH CHECK ADD  CONSTRAINT [FK_StorageZones_Warehouses] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[StorageZones] CHECK CONSTRAINT [FK_StorageZones_Warehouses]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Employees]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[UserRoles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserRoles]
GO
ALTER TABLE [dbo].[WarehouseEquipment]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseEquipment_EquipmentTypes] FOREIGN KEY([EquipmentTypeID])
REFERENCES [dbo].[EquipmentTypes] ([EquipmentTypeID])
GO
ALTER TABLE [dbo].[WarehouseEquipment] CHECK CONSTRAINT [FK_WarehouseEquipment_EquipmentTypes]
GO
ALTER TABLE [dbo].[WarehouseEquipment]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseEquipment_Warehouses] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[WarehouseEquipment] CHECK CONSTRAINT [FK_WarehouseEquipment_Warehouses]
GO
ALTER TABLE [dbo].[WorkOrders]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[WorkOrders] CHECK CONSTRAINT [FK_WorkOrders_Employees]
GO
ALTER TABLE [dbo].[WorkOrders]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrders_ProductionLines] FOREIGN KEY([LineID])
REFERENCES [dbo].[ProductionLines] ([LineID])
GO
ALTER TABLE [dbo].[WorkOrders] CHECK CONSTRAINT [FK_WorkOrders_ProductionLines]
GO
ALTER TABLE [dbo].[WorkOrders]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrders_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[WorkOrders] CHECK CONSTRAINT [FK_WorkOrders_Products]
GO
ALTER TABLE [dbo].[InventoryResults]  WITH CHECK ADD  CONSTRAINT [CK_InventoryResults_ActualQuantity] CHECK  (([ActualQuantity]>=(0)))
GO
ALTER TABLE [dbo].[InventoryResults] CHECK CONSTRAINT [CK_InventoryResults_ActualQuantity]
GO
ALTER TABLE [dbo].[InventoryResults]  WITH CHECK ADD  CONSTRAINT [CK_InventoryResults_ExpectedQuantity] CHECK  (([ExpectedQuantity]>=(0)))
GO
ALTER TABLE [dbo].[InventoryResults] CHECK CONSTRAINT [CK_InventoryResults_ExpectedQuantity]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [CK_Products_MinStock] CHECK  (([MinStock]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Products_MinStock]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [CK_Products_PurchasePrice] CHECK  (([PurchasePrice]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Products_PurchasePrice]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [CK_Products_SalePrice] CHECK  (([SalePrice]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Products_SalePrice]
GO
ALTER TABLE [dbo].[ReceiptItems]  WITH CHECK ADD  CONSTRAINT [CK_ReceiptItems_Quantity] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[ReceiptItems] CHECK CONSTRAINT [CK_ReceiptItems_Quantity]
GO
ALTER TABLE [dbo].[ReceiptItems]  WITH CHECK ADD  CONSTRAINT [CK_ReceiptItems_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[ReceiptItems] CHECK CONSTRAINT [CK_ReceiptItems_UnitPrice]
GO
ALTER TABLE [dbo].[ShipmentItems]  WITH CHECK ADD  CONSTRAINT [CK_ShipmentItems_Quantity] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[ShipmentItems] CHECK CONSTRAINT [CK_ShipmentItems_Quantity]
GO
ALTER TABLE [dbo].[ShipmentItems]  WITH CHECK ADD  CONSTRAINT [CK_ShipmentItems_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[ShipmentItems] CHECK CONSTRAINT [CK_ShipmentItems_UnitPrice]
GO
ALTER TABLE [dbo].[StockBalances]  WITH CHECK ADD  CONSTRAINT [CK_StockBalances_Quantity] CHECK  (([Quantity]>=(0)))
GO
ALTER TABLE [dbo].[StockBalances] CHECK CONSTRAINT [CK_StockBalances_Quantity]
GO
ALTER TABLE [dbo].[StorageLocations]  WITH CHECK ADD  CONSTRAINT [CK_StorageLocations_MaxWeight] CHECK  (([MaxWeight]>(0)))
GO
ALTER TABLE [dbo].[StorageLocations] CHECK CONSTRAINT [CK_StorageLocations_MaxWeight]
GO
ALTER TABLE [dbo].[WorkOrders]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrders_CompletedQuantity] CHECK  (([CompletedQuantity]>=(0)))
GO
ALTER TABLE [dbo].[WorkOrders] CHECK CONSTRAINT [CK_WorkOrders_CompletedQuantity]
GO
ALTER TABLE [dbo].[WorkOrders]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrders_PlannedQuantity] CHECK  (([PlannedQuantity]>=(0)))
GO
ALTER TABLE [dbo].[WorkOrders] CHECK CONSTRAINT [CK_WorkOrders_PlannedQuantity]
GO
USE [master]
GO
ALTER DATABASE [warehouse_management] SET  READ_WRITE 
GO

/****** Object:  Database [PosterDelivery_Dev]    Script Date: 12-01-2023 20:52:10 ******/
CREATE DATABASE [PosterDelivery_Dev]  --(EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0', MAXSIZE = 250 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [PosterDelivery_Dev] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [PosterDelivery_Dev] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET ARITHABORT OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PosterDelivery_Dev] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PosterDelivery_Dev] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [PosterDelivery_Dev] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PosterDelivery_Dev] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [PosterDelivery_Dev] SET  MULTI_USER 
GO
ALTER DATABASE [PosterDelivery_Dev] SET ENCRYPTION ON
GO
ALTER DATABASE [PosterDelivery_Dev] SET QUERY_STORE = ON
GO
ALTER DATABASE [PosterDelivery_Dev] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  UserDefinedTableType [dbo].[CustomerExcelData]    Script Date: 12-01-2023 20:52:10 ******/
CREATE TYPE [dbo].[CustomerExcelData] AS TABLE(
	[CustomerId] [int] NULL,
	[AccountName] [nvarchar](500) NULL,
	[ShippingStreet] [nvarchar](500) NULL,
	[ShippingCity] [nvarchar](500) NULL,
	[ShippingState] [nvarchar](500) NULL,
	[ShippingCode] [nvarchar](500) NULL,
	[ContactName] [nvarchar](500) NULL,
	[ContactPhone] [nvarchar](500) NULL,
	[ConsignmentOrBuyer] [nvarchar](500) NULL,
	[DeliveryDay] [int] NULL,
	[IsActive] [tinyint] NULL,
	[Notes] [nvarchar](2000) NULL,
	[Email] [nvarchar](500) NULL,
	[AlternateContact] [nvarchar](500) NULL,
	[TotalBoxes] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DeliveryScanDetailsType]    Script Date: 12-01-2023 20:52:10 ******/
CREATE TYPE [dbo].[DeliveryScanDetailsType] AS TABLE(
	[customerId] [int] NULL,
	[driverCustomerTrackId] [int] NULL,
	[ScannedBy] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[PickupScanDetailsType]    Script Date: 12-01-2023 20:52:10 ******/
CREATE TYPE [dbo].[PickupScanDetailsType] AS TABLE(
	[customerId] [int] NULL,
	[driverCustomerTrackId] [int] NULL,
	[ScannedBy] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL
)
GO
/****** Object:  Table [dbo].[Products]    Script Date: 12-01-2023 20:52:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductSerial] [nvarchar](500) NULL,
	[ProductName] [nvarchar](500) NULL,
	[CategoryId] [int] NULL,
	[ProductPrice] [decimal](18, 0) NULL,
	[IsBarcodeGenerated] [tinyint] NULL,
	[BarcodeImageName] [nvarchar](500) NULL,
	[BarcodeImagePath] [nvarchar](1000) NULL,
	[ProductImageName] [nvarchar](500) NULL,
	[ProductImagePath] [nvarchar](1000) NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [tinyint] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwProducts]    Script Date: 12-01-2023 20:52:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwProducts]
AS
SELECT ProductId, ProductSerial, ProductName, ProductPrice, IsActive
FROM     dbo.Products with(nolock)
GO
/****** Object:  Table [dbo].[CustomerDeliveryDetail]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDeliveryDetail](
	[DeliveryDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryHeaderId] [int] NULL,
	[ProductId] [int] NULL,
	[InitialRefHeaderId] [int] NULL,
	[Quantity] [int] NULL,
	[ScanType] [nvarchar](50) NULL,
	[Notes] [nvarchar](2000) NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[ScannedBy] [int] NULL,
	[IsActive] [tinyint] NULL,
 CONSTRAINT [PK_CustomerDeliveryDetail] PRIMARY KEY CLUSTERED 
(
	[DeliveryDetailsId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerDeliveryHeader]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDeliveryHeader](
	[DeliveryHeaderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[DriverCustomerTrackId] [int] NULL,
	[ScanType] [nvarchar](50) NULL,
	[IsScanned] [tinyint] NULL,
	[IsInvoiceGenerated] [tinyint] NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[ScannedBy] [int] NULL,
	[IsActive] [tinyint] NULL,
 CONSTRAINT [PK_CustomerDeliveryHeader] PRIMARY KEY CLUSTERED 
(
	[DeliveryHeaderId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [nvarchar](500) NULL,
	[ShippingStreet] [nvarchar](500) NULL,
	[ShippingCity] [nvarchar](500) NULL,
	[ShippingState] [nvarchar](500) NULL,
	[ShippingCode] [nvarchar](500) NULL,
	[ContactName] [nvarchar](500) NULL,
	[ContactPhone] [nvarchar](500) NULL,
	[ConsignmentOrBuyer] [nvarchar](500) NULL,
	[DeliveryDay] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[IsActive] [tinyint] NULL,
	[Notes] [nvarchar](2000) NULL,
	[Email] [nvarchar](200) NULL,
	[AlternateContact] [nvarchar](500) NULL,
	[TotalBoxes] [int] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DriverCustomerTrack]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriverCustomerTrack](
	[DriverCustomerTrackId] [int] IDENTITY(1,1) NOT NULL,
	[UserDriverId] [int] NULL,
	[CustomerId] [int] NULL,
	[ActualProductsPicked] [int] NULL,
	[ActualProductsShipped] [int] NULL,
	[ProposedDate] [datetime] NULL,
	[ActualDate] [datetime] NULL,
	[IsCompleted] [tinyint] NULL,
	[ReasonForNotCompletion] [nvarchar](1000) NULL,
	[ScannedStore] [tinyint] NULL,
	[IsActive] [tinyint] NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[CreatedByUser] [int] NULL,
	[DriverVisitDate] [datetime] NULL,
 CONSTRAINT [PK_DriverCustomerTrack] PRIMARY KEY CLUSTERED 
(
	[DriverCustomerTrackId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExceptionLogs]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExceptionLogs](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Type] [nvarchar](100) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[Source] [nvarchar](100) NULL,
	[DateCreated] [datetime] NOT NULL,
	[StatusCode] [nvarchar](50) NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_ExceptionLogs] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetails]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetails](
	[InvoiceDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryHeaderId] [int] NULL,
	[InvoiceHeaderId] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[UserId] [int] NULL,
	[IsActive] [tinyint] NULL,
 CONSTRAINT [PK_InvoiceDetails] PRIMARY KEY CLUSTERED 
(
	[InvoiceDetailsId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceHeader]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceHeader](
	[InvoiceHeaderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[InvoiceAmount] [decimal](18, 2) NULL,
	[InvoiceDate] [datetime] NULL,
	[SoldQuantity] [int] NULL,
	[InvoiceSerialNo] [nvarchar](50) NULL,
	[Tax] [nvarchar](50) NULL,
	[Discount] [nvarchar](50) NULL,
	[TotalInvoiceAmount] [decimal](18, 2) NULL,
	[ActualInvoiceAmount] [decimal](18, 2) NULL,
	[InvoiceFileName] [nvarchar](500) NULL,
	[InvoiceFilePath] [nvarchar](1000) NULL,
	[InvoiceImageString] [nvarchar](max) NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[UserId] [int] NULL,
	[IsActive] [tinyint] NULL,
 CONSTRAINT [PK_InvoiceHeader] PRIMARY KEY CLUSTERED 
(
	[InvoiceHeaderId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](500) NULL,
	[ParentCategoryId] [nvarchar](500) NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [tinyint] NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](100) NULL,
	[IsActive] [tinyint] NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[DateCreated] [datetime] NULL,
	[IsActive] [tinyint] NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](500) NULL,
	[LastName] [nvarchar](500) NULL,
	[EmailId] [nvarchar](500) NULL,
	[UserName] [nvarchar](500) NULL,
	[Password] [nvarchar](max) NULL,
	[LastLoginDateTime] [datetime] NULL,
	[IPAddress] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](100) NULL,
	[IsActive] [tinyint] NULL,
	[MiddleName] [nvarchar](500) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerDeliveryDetail] ADD  CONSTRAINT [DF_CustomerDeliveryDetail_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[CustomerDeliveryHeader] ADD  CONSTRAINT [DF_CustomerDeliveryHeader_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[DriverCustomerTrack] ADD  CONSTRAINT [DF_DriverCustomerTrack_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ExceptionLogs] ADD  CONSTRAINT [DF_ExceptionLogs_LogDate_GETDATE]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[InvoiceDetails] ADD  CONSTRAINT [DF_InvoiceDetails_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[InvoiceHeader] ADD  CONSTRAINT [DF_InvoiceHeader_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_DateCreated]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UserRoles] ADD  CONSTRAINT [DF_UserRoles_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_DateCreated]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CustomerDeliveryDetail]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDeliveryDetail_CustomerDeliveryHeader] FOREIGN KEY([DeliveryHeaderId])
REFERENCES [dbo].[CustomerDeliveryHeader] ([DeliveryHeaderId])
GO
ALTER TABLE [dbo].[CustomerDeliveryDetail] CHECK CONSTRAINT [FK_CustomerDeliveryDetail_CustomerDeliveryHeader]
GO
ALTER TABLE [dbo].[CustomerDeliveryDetail]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDeliveryDetail_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[CustomerDeliveryDetail] CHECK CONSTRAINT [FK_CustomerDeliveryDetail_Products]
GO
ALTER TABLE [dbo].[CustomerDeliveryDetail]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDeliveryDetail_Users] FOREIGN KEY([ScannedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[CustomerDeliveryDetail] CHECK CONSTRAINT [FK_CustomerDeliveryDetail_Users]
GO
ALTER TABLE [dbo].[CustomerDeliveryHeader]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDeliveryHeader_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerDeliveryHeader] CHECK CONSTRAINT [FK_CustomerDeliveryHeader_Customers]
GO
ALTER TABLE [dbo].[CustomerDeliveryHeader]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDeliveryHeader_DriverCustomerTrack] FOREIGN KEY([DriverCustomerTrackId])
REFERENCES [dbo].[DriverCustomerTrack] ([DriverCustomerTrackId])
GO
ALTER TABLE [dbo].[CustomerDeliveryHeader] CHECK CONSTRAINT [FK_CustomerDeliveryHeader_DriverCustomerTrack]
GO
ALTER TABLE [dbo].[CustomerDeliveryHeader]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDeliveryHeader_Users] FOREIGN KEY([ScannedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[CustomerDeliveryHeader] CHECK CONSTRAINT [FK_CustomerDeliveryHeader_Users]
GO
ALTER TABLE [dbo].[DriverCustomerTrack]  WITH CHECK ADD  CONSTRAINT [FK_DriverCustomerTrack_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[DriverCustomerTrack] CHECK CONSTRAINT [FK_DriverCustomerTrack_Customers]
GO
ALTER TABLE [dbo].[DriverCustomerTrack]  WITH CHECK ADD  CONSTRAINT [FK_DriverCustomerTrack_Users] FOREIGN KEY([UserDriverId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DriverCustomerTrack] CHECK CONSTRAINT [FK_DriverCustomerTrack_Users]
GO
ALTER TABLE [dbo].[DriverCustomerTrack]  WITH CHECK ADD  CONSTRAINT [FK_DriverCustomerTrack_Users1] FOREIGN KEY([CreatedByUser])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DriverCustomerTrack] CHECK CONSTRAINT [FK_DriverCustomerTrack_Users1]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetails_CustomerDeliveryHeader] FOREIGN KEY([DeliveryHeaderId])
REFERENCES [dbo].[CustomerDeliveryHeader] ([DeliveryHeaderId])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_CustomerDeliveryHeader]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetails_InvoiceHeader] FOREIGN KEY([InvoiceHeaderId])
REFERENCES [dbo].[InvoiceHeader] ([InvoiceHeaderId])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_InvoiceHeader]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetails_Users1] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_Users1]
GO
ALTER TABLE [dbo].[InvoiceHeader]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceHeader_InvoiceHeader] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[InvoiceHeader] CHECK CONSTRAINT [FK_InvoiceHeader_InvoiceHeader]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[ProductCategory] ([CategoryId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductCategory]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Users]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_UserRoles] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_UserRoles]
GO
/****** Object:  StoredProcedure [dbo].[AssignDriver]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AssignDriver]
(
	@UserDriverId           NUMERIC(18, 0) = 0,
	@CustomerId             NUMERIC(18, 0) = 0,
	@ActualProductsPicked   NUMERIC(18, 0) = 0,
	@ActualProductsShipped  NUMERIC(18, 0) = 0,
	@IsCompleted            BIT            = 0,
	@ReasonForNotCompletion NVARCHAR(500)  = NULL,
	@ActualDate             DATETIME,
	@IsActive               BIT            = 0,
	@CreatedByUser          NUMERIC(18, 0) = 0
)
AS
/****************************************************************************
FILE NAME:      AssignDriver
DESCRIPTION:    Gets a Company from the Company table
AUTHOR:         Mark Kennedy
*****************************************************************************
COMMENTS This was converted from a static query defined in PosterDelivery.Utility.DapperQuery.cs

*****************************************************************************
HISTORY

Date        Initials    Description
----------  ---------   ----------------------------------------------------
01/7/23     MDK         Created
****************************************************************************/
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @DeliveryDay  INT
		DECLARE @ProposedDate DATETIME

		SELECT @DeliveryDay = DeliveryDay FROM Customers with(nolock) WHERE CustomerId = @CustomerId

		IF @DeliveryDay     = 0 OR @DeliveryDay = NULL
			BEGIN
				SET @ProposedDate = GETDATE()
			END
		ELSE
			BEGIN
				SET @ProposedDate = datefromparts(YEAR(GETDATE()), MONTH(GETDATE()), @DeliveryDay)
			END

		PRINT @ProposedDate

		INSERT INTO DriverCustomerTrack(UserDriverId, CustomerId, ActualProductsPicked, ActualProductsShipped, ProposedDate, ActualDate, IsCompleted, ReasonForNotCompletion, IsActive, DateCreated, DateModified, CreatedByUser) VALUES(@UserDriverId, @CustomerId, @ActualProductsPicked, @ActualProductsShipped, @ProposedDate,@ActualDate, @IsCompleted, @ReasonForNotCompletion, @IsActive, GETDATE(), GETDATE(), @CreatedByUser)

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[AssignDriverAndUpdateDeliveryDay]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----Exec AssignDriverAndUpdateDeliveryDay 12,26,1,0,0,null,null,1,8,0,0
CREATE PROCEDURE [dbo].[AssignDriverAndUpdateDeliveryDay] 
	@UserDriverId int = 0,
	@CustomerId int = 0,
	@ActualProductsPicked int = 0,
	@ActualProductsShipped int = 0,
	@IsCompleted BIT = 0,
	@ReasonForNotCompletion NVARCHAR(500) = NULL,
	@ActualDate datetime,
	@IsActive BIT = 0,
	@CreatedByUser int = 0,
	@DriverCustomerTrackId int = 0,
	@DeliveryDay int = 0
AS
BEGIN
	DECLARE @ProposedDate DATETIME

	if (@DriverCustomerTrackId > 0)
			
			BEGIN TRY
				BEGIN TRANSACTION
					
					Update Customers set DeliveryDay=@DeliveryDay where CustomerId=@CustomerId

					IF @DeliveryDay = 0
						BEGIN
							Update DriverCustomerTrack set UserDriverId=@UserDriverId, ProposedDate=NULL, ActualDate=null, DriverVisitDate=GETDATE(), DateModified=GETDATE(), CreatedByUser=@CreatedByUser Where DriverCustomerTrackId=@DriverCustomerTrackId
						END
					ELSE
						BEGIN
							SET @ProposedDate = @ActualDate
							Update DriverCustomerTrack set UserDriverId=@UserDriverId, ProposedDate=@ProposedDate, ActualDate=@ActualDate, DriverVisitDate=GETDATE(), DateModified=GETDATE(), CreatedByUser=@CreatedByUser Where DriverCustomerTrackId=@DriverCustomerTrackId
						END

				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
			END CATCH

	Else 
			
		BEGIN TRY
			BEGIN TRANSACTION

				Update Customers set DeliveryDay=@DeliveryDay where CustomerId=@CustomerId

				IF @UserDriverId <> 0
					Begin
						SET @ProposedDate = @ActualDate

						INSERT INTO DriverCustomerTrack(UserDriverId, CustomerId, ActualProductsPicked, ActualProductsShipped, ProposedDate, ActualDate, IsCompleted, ReasonForNotCompletion, IsActive, DateCreated, DateModified, CreatedByUser) VALUES(@UserDriverId, @CustomerId, @ActualProductsPicked, @ActualProductsShipped, @ProposedDate,@ActualDate, @IsCompleted, @ReasonForNotCompletion, @IsActive, GETDATE(), GETDATE(), @CreatedByUser)
						Print GetDate();
					End
				Print @UserDriverId;
			COMMIT TRANSACTION

		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION;
			END
		END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[CaptureDeliveryScan]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Shubham>
-- Create Date: <Create Date, 20-12-2022 , >
-- Description: <Description, used to capture pickup scan, >
-- =============================================
CREATE PROCEDURE [dbo].[CaptureDeliveryScan]
(
   @deliveryScanTable  dbo.DeliveryScanDetailsType READONLY
)
AS
BEGIN

      DECLARE @HeaderID TABLE(ID INT); 
      DECLARE @ProductId TABLE(ID INT); 
	  Declare @initialHeaderid int;
	  Declare @DriverCustomerTrackId int;
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
	BEGIN TRY

		BEGIN TRANSACTION;

    IF EXISTS (Select Top 1 DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where DriverCustomerTrackId = (Select Top 1 driverCustomerTrackId from @deliveryScanTable) )
	Begin
	Insert into @HeaderID (ID)
	Select DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where DriverCustomerTrackId = (Select Top 1 driverCustomerTrackId from @deliveryScanTable)
	End

	Else
	Begin

    Insert into dbo.CustomerDeliveryHeader (CustomerId, DriverCustomerTrackId,  ScanType,IsScanned, IsInvoiceGenerated, ScannedBy, IsActive)
	OUTPUT inserted.DeliveryHeaderId INTO @HeaderID(ID)
	Select TOP 1 customerId,driverCustomerTrackId, 'Both',1,0,ScannedBy,1 From @deliveryScanTable

	End

	Insert into dbo.CustomerDeliveryDetail (DeliveryHeaderId,ProductId, InitialRefHeaderId, Quantity,ScanType, Notes, ScannedBy, IsActive)
	Select  (Select ID from @HeaderID), ProductId,(Select ID from @HeaderID),Quantity,'Delivery','',ScannedBy,1 from @deliveryScanTable

	 Set @DriverCustomerTrackId = (Select DriverCustomerTrackId from dbo.CustomerDeliveryHeader with(nolock) where DeliveryHeaderId = (Select ID from @HeaderID) )

     Update dbo.DriverCustomerTrack set IsCompleted = 1, ActualProductsShipped = (select count(*) from @deliveryScanTable) where DriverCustomerTrackId = @DriverCustomerTrackId

	 

	COMMIT TRANSACTION;


	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[CapturePickupScan]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Shubham>
-- Create Date: <Create Date, 20-12-2022 , >
-- Description: <Description, used to capture pickup scan, >
-- =============================================
CREATE PROCEDURE [dbo].[CapturePickupScan]
(
   @pickupScanTable  dbo.PickupScanDetailsType READONLY
)
AS
BEGIN

      DECLARE @HeaderID TABLE(ID INT); 
      DECLARE @PickupProductId TABLE(ID INT, Pcount int); 
	  DECLARE @DeliveryProductId TABLE(ID INT, Pcount int); 
	  Declare @initialHeaderid int;
	  Declare @DriverCustomerTrackId int;
	  Declare @ActualSoldQuantity int;
	
	BEGIN TRY

		BEGIN TRANSACTION;

   IF EXISTS (Select Top 1 DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where DriverCustomerTrackId = (Select Top 1 driverCustomerTrackId from @pickupScanTable) )
	Begin
	Insert into @HeaderID (ID)
	Select DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where DriverCustomerTrackId = (Select Top 1 driverCustomerTrackId from @pickupScanTable)
	End

	Else
	Begin
    Insert into dbo.CustomerDeliveryHeader (CustomerId, DriverCustomerTrackId,  ScanType,IsScanned, IsInvoiceGenerated, 
	ScannedBy, IsActive)
	OUTPUT inserted.DeliveryHeaderId INTO @HeaderID(ID)
	Select TOP 1 customerId,driverCustomerTrackId, 'Both',1,0,ScannedBy,1 From @pickupScanTable
	End

	IF EXISTS (Select top 1 DeliveryDetailsId from dbo.CustomerDeliveryDetail with(nolock) where DeliveryHeaderId=(Select TOP 1 ID from @HeaderID))
	BEGIN
	  
	   Delete from dbo.CustomerDeliveryDetail where DeliveryHeaderId=(Select TOP 1 ID from @HeaderID)

	END

	ELSE
	BEGIN

	  Insert into dbo.CustomerDeliveryDetail (DeliveryHeaderId,ProductId, InitialRefHeaderId, Quantity,ScanType, Notes, 
		ScannedBy, IsActive)
		Select  (Select TOP 1 ID from @HeaderID), ProductId,(Select Top 1 DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where 
		CustomerId = customerId and DeliveryHeaderid <> (Select TOP 1 ID from @HeaderID) and (IsInvoiceGenerated is null or IsInvoiceGenerated = 0) order by DeliveryHeaderId desc),1,
		'Pickup','',ScannedBy,1 from @pickupScanTable

	END

	update dbo.DriverCustomerTrack set ActualProductsPicked = (select count(*) from @pickupScanTable) where DriverCustomerTrackId = (Select TOP 1 driverCustomerTrackId From @pickupScanTable)

	--set previous deliver header id for initial ref header for picked up items
	Set @initialHeaderid = (Select Top 1 DeliveryHeaderId from dbo.CustomerDeliveryHeader where 
	CustomerId = customerId and DeliveryHeaderid <> (Select TOP 1 ID from @HeaderID) and 
	(IsInvoiceGenerated is null or IsInvoiceGenerated = 0) order by DeliveryHeaderId desc)

	 Set @DriverCustomerTrackId = (Select top 1 DriverCustomerTrackId from dbo.CustomerDeliveryHeader with(nolock) where DeliveryHeaderId=@initialHeaderid)

	 --If previous visit to store scanned consider current as scanned invoice and sow sold products
	IF ((Select top 1 ScannedStore from dbo.DriverCustomerTrack with(nolock) where DriverCustomerTrackId = @DriverCustomerTrackId) = 1)
	BEGIN
	--Scan for products single scanned and fetch insert them in temp table
	Insert into @PickupProductId
	select cdd.ProductId, count(cdd.ProductId) from dbo.CustomerDeliveryDetail cdd
	where cdd.InitialRefHeaderId=@initialHeaderid and ScanType='Pickup' group by cdd.ProductId


	Insert into @DeliveryProductId
	select cdd.ProductId, count(cdd.ProductId) from dbo.CustomerDeliveryDetail cdd
	where cdd.InitialRefHeaderId=@initialHeaderid and ScanType='Delivery' group by cdd.ProductId

	End
	--else If previous visit to store not scanned consider current as counted invoice
	Else
	BEGIN
	  Set @ActualSoldQuantity = (Select top 1 ActualProductsShipped from dbo.DriverCustomerTrack with(nolock) where DriverCustomerTrackId = @DriverCustomerTrackId) - (select count(*) from @pickupScanTable)
	END
	COMMIT TRANSACTION;

	IF ((Select top 1 ScannedStore from dbo.DriverCustomerTrack with(nolock) where DriverCustomerTrackId = @DriverCustomerTrackId) = 1)
	BEGIN
	--Find sold quantity by substracting count of delivery and pickup
    select (select ID from @HeaderID) as HeaderId,@initialHeaderid as InitialRefHederId, ProductId, ProductSerial, ProductName, ProductPrice,
	((select Pcount from @DeliveryProductId Where ID=ProductId) - (select Pcount from @PickupProductId Where ID=ProductId)) as SoldQuantity
	from dbo.Products where ProductId in 
	(Select dp.ID from @DeliveryProductId dp left join @PickupProductId puid on puid.ID = dp.ID and puid.Pcount <> dp.Pcount)
	End
	ELSE

	BEGIN
	  select ID as HeaderId,@initialHeaderid as InitialRefHederId, 0 as ProductId, '' as ProductSerial, '' as ProductName, 0.00 as ProductPrice,
	  @ActualSoldQuantity as SoldQuantity
	from @HeaderID
	END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[CaptureStoreCount]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Shubham>
-- Create Date: <Create Date, 20-12-2022 , >
-- Description: <Description, used to capture pickup scan, >
-- =============================================
CREATE PROCEDURE [dbo].[CaptureStoreCount]
(
     @UserId int,
     @CustomerId int,
	 @DriverCustomerTrackId int,
	 @PickupCount int,
	 @DeliveryCount int
)
AS
BEGIN

      Declare @ProductsSold int;
      DECLARE @HeaderID TABLE(ID INT); 
	  Declare @PreviousDeliverItems int = 0;
    -- interfering with SELECT statements.
	BEGIN TRY

		BEGIN TRANSACTION;

    IF EXISTS (Select Top 1 DeliveryHeaderId from dbo.CustomerDeliveryHeader where DriverCustomerTrackId = @DriverCustomerTrackId )
	Begin
	Insert into @HeaderID (ID)
	Select DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where DriverCustomerTrackId = @DriverCustomerTrackId
	End

	Else
	Begin

    Insert into dbo.CustomerDeliveryHeader (CustomerId, DriverCustomerTrackId,  ScanType,IsScanned, IsInvoiceGenerated, ScannedBy, IsActive)
	OUTPUT inserted.DeliveryHeaderId INTO @HeaderID(ID)
	Values(@CustomerId,@DriverCustomerTrackId, 'Both',0,0,@UserId,1)

	End

	Set @PreviousDeliverItems =
     (select TOP 1 DCT.ActualProductsShipped from dbo.DriverCustomerTrack DCT with(nolock) INNER JOIN dbo.CustomerDeliveryHeader CDH with(nolock)
	ON CDH.DriverCustomerTrackId=DCT.DriverCustomerTrackId WHERE DCT.CustomerId = @CustomerId and DCT.DriverCustomerTrackId <> @DriverCustomerTrackId
	ORDER BY DCT.DriverCustomerTrackId desc
	)

	Set @ProductsSold = @PreviousDeliverItems - @PickupCount


	 

	COMMIT TRANSACTION;

	Select TOP 1 ID as HeaderId, @ProductsSold as SoldQuantity from @HeaderID

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[ExcelDataUpload]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Shubham>
-- Create Date: <Create Date, 04-01-2023 , >
-- Description: <Description, used to upload and update customers data, >
-- =============================================
CREATE PROCEDURE [dbo].[ExcelDataUpload]
(

    @customerExcelData dbo.CustomerExcelData readonly

)
AS
BEGIN

	BEGIN TRY

	BEGIN TRANSACTION;
    
	       Insert into dbo.Customers(AccountName, ShippingStreet, ShippingCity, ShippingState, ShippingCode, ContactName,
		   ContactPhone, ConsignmentOrBuyer, DeliveryDay, IsActive, Notes, Email, AlternateContact, TotalBoxes)
		   Select  AccountName, ShippingStreet, ShippingCity, ShippingState, ShippingCode, ContactName,
		   ContactPhone, ConsignmentOrBuyer, DeliveryDay, IsActive, Notes, Email, AlternateContact, TotalBoxes
		   From @customerExcelData Where CustomerId is null or CustomerId = 0


		    UPDATE C SET
            C.AccountName = CED.AccountName,
			C.ShippingStreet = CED.ShippingStreet,
			C.ShippingCity = CED.ShippingCity,
			C.ShippingState = CED.ShippingState,
			C.ShippingCode = CED.ShippingCode,
			C.ContactName = CED.ContactName,
			C.ContactPhone = CED.ContactPhone,
			C.ConsignmentOrBuyer = CED.ConsignmentOrBuyer,
			C.DeliveryDay = CED.DeliveryDay,
			C.IsActive = CED.IsActive,
			C.Notes = CED.Notes,
			C.Email = CED.Email,
			C.AlternateContact = CED.AlternateContact,
			C.TotalBoxes = CED.TotalBoxes
			FROM
				dbo.Customers C
			INNER JOIN
				@customerExcelData CED
			ON 
				C.CustomerId = CED.CustomerId

	COMMIT TRANSACTION;
	
	Return 1;

	--return @@TRANCOUNT;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateInvoice]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Shubham>
-- Create Date: <Create Date, 20-12-2022 , >
-- Description: <Description, used to generate invoice, >
-- =============================================
CREATE PROCEDURE [dbo].[GenerateInvoice]
(
   @HeaderId  int,
   @UserId int,
   @CustomerId int,
   @DriverCustomerTrackId int,
   @InvoiceAmount decimal(18,2),
   @InvoiceSerialNo nvarchar(50),
   @ActualInvoiceAmount decimal(18,2),
   @TotalInvoiceAmount decimal(18,2),
   @InvoiceFileName nvarchar(500),
   @InvoiceFilePath nvarchar(1000),
   @DeliveryCount int,
   @PickupCount int,
   @SoldQuantity int


)
AS
BEGIN

      DECLARE @InvoiceHeaderID TABLE(ID INT);
	BEGIN TRY

	BEGIN TRANSACTION;
    
	       Insert into dbo.InvoiceHeader (CustomerId, InvoiceAmount, InvoiceDate, InvoiceSerialNo, TotalInvoiceAmount, ActualInvoiceAmount, InvoiceFileName, InvoiceFilePath, SoldQuantity, UserId, IsActive)
		   OUTPUT inserted.InvoiceHeaderId INTO @InvoiceHeaderID(ID)
		   Values (@CustomerId, @InvoiceAmount, getdate(), @InvoiceSerialNo, @TotalInvoiceAmount, @ActualInvoiceAmount, @InvoiceFileName, @InvoiceFilePath,@SoldQuantity, @UserId, 1);


		   Insert into dbo.InvoiceDetails (DeliveryHeaderId, InvoiceHeaderId, UserId, IsActive)
		   Values (@HeaderId, (Select ID from @InvoiceHeaderID), @UserId, 1)

		   --Dnt set pickup and deliver count here in case of scanning else set it in non scanning mode
		   If (@PickupCount = -1)
		   BEGIN
		      Update dbo.DriverCustomerTrack set IsCompleted = 1 where DriverCustomerTrackId = @DriverCustomerTrackId
		   END
		   ELSE
		   BEGIN
           Update dbo.DriverCustomerTrack set IsCompleted = 1, ActualProductsShipped = @DeliveryCount, ActualProductsPicked=@PickupCount where DriverCustomerTrackId = @DriverCustomerTrackId
		   END

		   Update dbo.CustomerDeliveryHeader set IsInvoiceGenerated=1 where DeliveryHeaderId=(select top 1 DeliveryHeaderId from 
		   dbo.CustomerDeliveryHeader where CustomerId = @CustomerId and DeliveryHeaderId <> @HeaderId and (IsInvoiceGenerated is null
		   or IsInvoiceGenerated = 0) order by DeliveryHeaderId desc)

	COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerHistory]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCustomerHistory]
(
	@CustomerId NUMERIC(18, 0)
)
AS
Select Top 3 C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone, CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer, C.DeliveryDay,
Case When C.DeliveryDay = 0 And C.DeliveryDay IS NULL then '' else FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') End as DeliveryDate,
Case When DCT.ActualDate IS NULL then '' else FORMAT(DCT.ActualDate, 'dd MMM, yyyy') End as LastVisitedDateString,
Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive,C.Notes, IH.InvoiceHeaderId, (Case When EXISTS(Select InvoiceHeaderId From InvoiceHeader 
Where DCT.CustomerId = @CustomerId AND DCT.IsCompleted = 1 AND DCT.IsActive = 1) THEN 1 ELSE 0 End) As IsInvoice
From Customers C with(nolock)
Left Join DriverCustomerTrack DCT with(nolock) ON DCT.CustomerId = C.CustomerId
Left Join CustomerDeliveryHeader CDH with(nolock) ON CDH.DriverCustomerTrackId = DCT.DriverCustomerTrackId
Left Join InvoiceDetails ID with(nolock) ON ID.DeliveryHeaderId = CDH.DeliveryHeaderId
Left Join InvoiceHeader IH with(nolock) ON IH.InvoiceHeaderId = ID.InvoiceHeaderId
Where DCT.CustomerId = @CustomerId AND DCT.IsCompleted = 1 AND DCT.IsActive = 1
Order By IH.InvoiceHeaderId DESC
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerOrders]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----Exec GetCustomerOrders 'Pending', 'Yes'
CREATE PROCEDURE [dbo].[GetCustomerOrders] 
@DeliveryType nvarchar(max)='',
@IsFromDashboard nvarchar(max)=''

AS
BEGIN

	if(@IsFromDashboard = 'Yes')
	
		if (@DeliveryType = 'Monthly')

			Select Top 10 C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone,CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,C.DeliveryDay,
				Case When (DCT.ActualDate Is Null AND C.DeliveryDay IS NULL AND C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive 
				FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId  
				Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1 
				AND ((Month(DCT.ActualDate) =  Month(GetDate()) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL))
				

		Else if (@DeliveryType = 'Tomorrow')
			
			Select Top 10 C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone,CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,C.DeliveryDay,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive 
				FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId
				Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1  
				AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()+1) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL And (Year(Getdate() + 1)+Month(Getdate() + 1)+Day(Getdate() + 1)=Year(GetDate()+1)+Month(GetDate()+1)+C.DeliveryDay)))
				

		Else if (@DeliveryType = 'Yesterday')
			
			Select Top 10 C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone,CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive 
				FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId  
				Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1 
				AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()-1) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL And (Year(Getdate() - 1)+Month(Getdate() - 1)+Day(Getdate() -1)=Year(GetDate()-1)+Month(GetDate()-1)+C.DeliveryDay)))
	
		
		Else if (@DeliveryType = 'InProgress')
			
			SELECT Top 10 C.CustomerId,C.AccountName,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ShippingStreet,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive, 
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				U.UserName
		
				FROM dbo.Customers AS C  with(nolock)
				LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND  DATENAME(month,DCT.ActualDate) = DATENAME(month,GetDate()) AND Year(DCT.ActualDate) = Year(GetDate())
				LEFT OUTER JOIN Users as U with(nolock) on DCT.UserDriverId=U.UserId

				WHERE (DCT.IsCompleted = 0) 
				AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
				AND (C.IsActive = 1)


		Else if (@DeliveryType = 'Completed')

			SELECT Top 10 C.CustomerId,C.AccountName,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ShippingStreet,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				U.UserName
			
				FROM dbo.Customers AS C with(nolock)
				LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND DATENAME(month,DCT.ActualDate) = DATENAME(month,GetDate()) AND Year(DCT.ActualDate) = Year(GetDate())
				LEFT OUTER JOIN Users as U with(nolock) on DCT.UserDriverId=U.UserId

				WHERE (DCT.IsCompleted = 1) 
				AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
				AND (C.IsActive = 1)

			
		Else if (@DeliveryType = 'Pending') 
			
			SELECT Top 10 C.CustomerId,C.AccountName,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ShippingStreet,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate
		
				FROM dbo.Customers AS C with(nolock)
				LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND DATENAME(month,DCT.ActualDate) = DATENAME(month,GetDate()) AND Year(DCT.ActualDate) = Year(GetDate())
		
				WHERE (DCT.ActualDate IS NULL) 
				AND (DCT.IsCompleted IS NULL) AND (DCT.CustomerId IS NULL) 
				AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
				AND (C.IsActive = 1)


		Else 
			
			Select Top 10 C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone,CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,C.DeliveryDay,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive 
				FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
				Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1 
				AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL And (Year(Getdate())+Month(Getdate())+Day(Getdate())=Year(GetDate())+Month(GetDate())+C.DeliveryDay)))
				



	Else

		if (@DeliveryType = 'Monthly')

			Select C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone,CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,C.DeliveryDay,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive 
				FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
				Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1  
				AND ((Month(DCT.ActualDate) =  Month(GetDate()) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL))
				

		Else if (@DeliveryType = 'Tomorrow')
			
			Select C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone,CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,C.DeliveryDay,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive 
				FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
				Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1  
				AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()+1) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL And (Year(Getdate() + 1)+Month(Getdate() + 1)+Day(Getdate() + 1)=Year(GetDate()+1)+Month(GetDate()+1)+C.DeliveryDay)))
				

		Else if (@DeliveryType = 'Yesterday')
			
			Select C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone,CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,C.DeliveryDay,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive 
				FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
				Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1  
				AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()-1) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL And (Year(Getdate() - 1)+Month(Getdate() - 1)+Day(Getdate() -1)=Year(GetDate()-1)+Month(GetDate()-1)+C.DeliveryDay)))
				

		Else 
			
			Select C.CustomerId,C.AccountName,C.ShippingStreet,C.ShippingCity,C.ShippingState,C.ShippingCode,C.ContactName,C.ContactPhone,CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,C.DeliveryDay,
				Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
					 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
					 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
				End as DeliveryDate,
				Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive 
				FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
				Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1  
				AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL And (Year(Getdate())+Month(Getdate())+Day(Getdate())=Year(GetDate())+Month(GetDate())+C.DeliveryDay)))
				
END
GO
/****** Object:  StoredProcedure [dbo].[OrderDeliveryCount]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----Exec OrderDeliveryCount
CREATE PROCEDURE [dbo].[OrderDeliveryCount] 
	
AS
BEGIN

	Select 
		(Select count(C.CustomerId) FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId  
			Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1 
			AND ((Month(DCT.ActualDate) =  Month(GetDate()) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL))) as MonthlyOrderDelivery,

		(Select Count(C.CustomerId) FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
			Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1 
			AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()+1) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL 
			And (Year(Getdate() + 1)+Month(Getdate() + 1)+Day(Getdate() + 1)=Year(GetDate()+1)+Month(GetDate()+1)+C.DeliveryDay)))) as TomorrowOrderDelivery,

		(Select Count(C.CustomerId) FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
			Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1  
			AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()+1) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL 
			And (Year(Getdate() - 1)+Month(Getdate() - 1)+Day(Getdate() -1)=Year(GetDate()-1)+Month(GetDate()-1)+C.DeliveryDay)))) as YesterdayOrderyDelivery,

		(Select Count(C.CustomerId) FROM dbo.Customers C with(nolock) Left JOIN DriverCustomerTrack  DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
			Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') And C.IsActive=1 
			AND ((CONVERT(date,DCT.ActualDate) =  CONVERT(date,GetDate()) And DCT.ActualDate IS Not Null) Or (DCT.ActualDate IS NULL 
			And (Year(Getdate())+Month(Getdate())+Day(Getdate())=Year(GetDate())+Month(GetDate())+C.DeliveryDay)))) as TodayOrderDelivery,


		(SELECT Count(C.CustomerId)
			FROM dbo.Customers AS C  with(nolock)
			LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND  DATENAME(month,DCT.ActualDate) = DATENAME(month,GetDate()) AND Year(DCT.ActualDate) = Year(GetDate()) 
			WHERE DCT.IsCompleted = 0
			AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
			AND C.IsActive = 1) as InProgressStores,

		(SELECT Count(C.CustomerId)
			FROM dbo.Customers AS C with(nolock)
			LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND  DATENAME(month,DCT.ActualDate) = DATENAME(month,GetDate()) AND Year(DCT.ActualDate) = Year(GetDate()) 
			WHERE DCT.IsCompleted = 1
			AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
			AND C.IsActive = 1) as CompletedStores,

		(SELECT Count(C.CustomerId)
			FROM dbo.Customers AS C with(nolock)
			LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND  DATENAME(month,DCT.ActualDate) = DATENAME(month,GetDate()) AND Year(DCT.ActualDate) = Year(GetDate()) 
			WHERE DCT.ActualDate IS NULL 
			AND DCT.IsCompleted IS NULL
			AND DCT.CustomerId IS NULL
			AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
			AND C.IsActive = 1) as PendingStores


END
GO
/****** Object:  StoredProcedure [dbo].[OrderDeliveryTracking]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----Exec OrderDeliveryTracking 'InProgress'
CREATE PROCEDURE [dbo].[OrderDeliveryTracking] 

	@ShipmentStatus nvarchar(max)=''

AS
BEGIN

	if (@ShipmentStatus = 'InProgress')
			
		SELECT C.CustomerId,
			DCT.DriverCustomerTrackId,
			C.AccountName,
			C.ShippingCity,
			C.ShippingState,
			C.ShippingCode,
			C.ShippingStreet,
			C.ContactName,
			C.ContactPhone,
			U.UserName,
			C.DeliveryDay,
			FORMAT (DCT.DriverVisitDate, 'dd MMM, yyyy') as DriverVisitDateString,
			Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
				 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
				 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
			End as ActualDateString,
			CASE WHEN C.ConsignmentOrBuyer = 'B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer = 'C' THEN 'Consignment' ELSE '' END AS ConsignmentOrBuyer, 
			'InProgress' AS ShipmentStatus, 
			FORMAT (DCT.ProposedDate, 'dd MMM, yyyy') as DeliveryDateString
		
			FROM dbo.Customers AS C with(nolock)
			LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND  DATENAME(month,DCT.ActualDate) = DATENAME(month,GETDATE()) AND Year(DCT.ActualDate) =  Year(GETDATE())
			LEFT OUTER JOIN Users as U with(nolock) on DCT.UserDriverId=U.UserId

			WHERE (DCT.IsCompleted = 0) 
			AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
			AND (C.IsActive = 1)

	else if (@ShipmentStatus = 'Completed')

		SELECT C.CustomerId,
			DCT.DriverCustomerTrackId,
			C.AccountName,
			C.ShippingCity,
			C.ShippingState,
			C.ShippingStreet,
			C.ShippingCode,
			C.ContactName,
			C.ContactPhone, 
			U.UserName,
			C.DeliveryDay,
			FORMAT (DCT.DriverVisitDate, 'dd MMM, yyyy') as DriverVisitDateString,
			Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
				 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
				 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
			End as ActualDateString,
			CASE WHEN C.ConsignmentOrBuyer = 'B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer = 'C' THEN 'Consignment' ELSE '' END AS ConsignmentOrBuyer, 
			'Completed' AS ShipmentStatus,
			FORMAT (DCT.ProposedDate, 'dd MMM, yyyy') as DeliveryDateString
			
			FROM dbo.Customers AS C with(nolock)
			LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND DATENAME(month,DCT.ActualDate) = DATENAME(month,GETDATE()) AND Year(DCT.ActualDate) =  Year(GETDATE())
			LEFT OUTER JOIN Users as U with(nolock) on DCT.UserDriverId=U.UserId

			WHERE (DCT.IsCompleted = 1) 
			AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
			AND (C.IsActive = 1)
			
	Else 
			
		SELECT C.CustomerId,
			DCT.DriverCustomerTrackId,
			C.AccountName,
			C.ShippingCity,
			C.ShippingState,
			C.ShippingStreet,
			C.ShippingCode,
			C.ContactName,
			C.ContactPhone,
			C.DeliveryDay,
			FORMAT (DCT.DriverVisitDate, 'dd MMM, yyyy') as DriverVisitDateString,
			Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
				 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
				 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
			End as ActualDateString,
			CASE WHEN C.ConsignmentOrBuyer = 'B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer = 'C' THEN 'Consignment' ELSE '' END AS ConsignmentOrBuyer, 
			'Pending' AS ShipmentStatus,
			FORMAT (DCT.ProposedDate, 'dd MMM, yyyy') as DeliveryDateString
		
			FROM dbo.Customers AS C with(nolock)
			LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND DATENAME(month,DCT.ActualDate) = DATENAME(month,GETDATE()) AND Year(DCT.ActualDate) =  Year(GETDATE())
		
			WHERE (DCT.ActualDate IS NULL) 
			AND (DCT.IsCompleted IS NULL) AND (DCT.CustomerId IS NULL) 
			AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
			AND (C.IsActive = 1)

END

		--Select 
		--Result.CustomerId,
		--Result.AccountName,
		--Result.ShippingCity,
		--Result.ShippingState,
		--Result.ShippingCode,
		--Result.ContactName,
		--Result.ContactPhone,
		--Result.ConsignmentOrBuyer,
		--IsNull(Result.ShipmentStatus,'Pending') as ShipmentStatus,
		--Result.DeliveryDay,
		--Result.IsActive
		--From
		--(Select 
		--C.CustomerId,
		--C.AccountName,
		--C.ShippingCity,
		--C.ShippingState,
		--C.ShippingCode,
		--C.ContactName,
		--C.ContactPhone,
		--CASE WHEN C.ConsignmentOrBuyer='B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer='C' THEN 'Consignment' Else '' END as ConsignmentOrBuyer,

		--(Select Distinct 
		--	CASE WHEN (DATEFROMPARTS (Year(GetDate()), Month(GetDate()), C.DeliveryDay) = FORMAT (DCT2.ActualDate, 'yyyy-MM-dd ') And DCT2.IsCompleted=1) Then 'Completed' 
		--		 WHEN (DATEFROMPARTS (Year(GetDate()), Month(GetDate()), C.DeliveryDay) = FORMAT (DCT2.ActualDate, 'yyyy-MM-dd ') And DCT2.IsCompleted=0) Then 'Inprogress' 
		--		 ELSE 'Pending'
		--	End as ShipmentStatus
		--	From DriverCustomerTrack as DCT2 where C.CustomerId=DCT2.CustomerId) as ShipmentStatus,

		--C.DeliveryDay,
		--Case When C.IsActive=1 Then 'Active' When C.IsActive=0 Then 'InActive' Else '' End as IsActive
		--from Customers as C
		--Where (C.ConsignmentOrBuyer='C' or C.ConsignmentOrBuyer='Consignment') 
		--) As Result

		--Where IsNull(Result.ShipmentStatus,'Pending')=@ShipmentStatus
GO
/****** Object:  StoredProcedure [dbo].[OrderDeliveryTrackingForDriver]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----Exec OrderDeliveryTrackingForDriver 'Pending',15
CREATE PROCEDURE [dbo].[OrderDeliveryTrackingForDriver] 
	@ShipmentStatus nvarchar(max)='',
	@DriverId int = 0

AS
BEGIN

	if (@ShipmentStatus = 'Pending')
			
		SELECT C.CustomerId,
			DCT.DriverCustomerTrackId,
			C.AccountName,
			C.ShippingCity,
			C.ShippingState,
			C.ShippingStreet,
			C.ShippingCode,
			C.ContactName,
			C.ContactPhone,
			Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
				 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
				 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
			End as ActualDateString,
			CASE WHEN C.ConsignmentOrBuyer = 'B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer = 'C' THEN 'Consignment' ELSE '' END AS ConsignmentOrBuyer, 
			'InProgress' AS ShipmentStatus, 
			FORMAT (DCT.ProposedDate, 'dd MMM, yyyy') as DeliveryDateString
		
			FROM dbo.Customers AS C with(nolock)
			LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId AND DATENAME(month,DCT.ActualDate) = DATENAME(month,GETDATE()) AND Year(DCT.ActualDate) =  Year(GETDATE())
		
			WHERE DCT.IsCompleted = 0 
				  AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
				  AND C.IsActive = 1
				  AND DCT.UserDriverId=@DriverId
				  --AND FORMAT (DCT.ActualDate, 'ddMMyyyy') = FORMAT (GETDATE(), 'ddMMyyyy')

	else

		SELECT C.CustomerId,
			DCT.DriverCustomerTrackId,
			C.AccountName,
			C.ShippingCity,
			C.ShippingState,
			C.ShippingStreet,
			C.ShippingCode,
			C.ContactName,
			C.ContactPhone, 
			Case When (DCT.ActualDate Is Null And C.DeliveryDay IS NULL And C.DeliveryDay=0) Then ''
				 When (DCT.ActualDate Is Null And C.DeliveryDay IS Not NULL And C.DeliveryDay <> 0) then FORMAT(DATEFROMPARTS(Year(GetDate()),Month(GetDate()),CAST(C.DeliveryDay as varchar(50))), 'dd MMM, yyyy') 
				 Else FORMAT(DCT.ActualDate,'dd MMM, yyyy') 
			End as ActualDateString,
			CASE WHEN C.ConsignmentOrBuyer = 'B' THEN 'Buyer' WHEN C.ConsignmentOrBuyer = 'C' THEN 'Consignment' ELSE '' END AS ConsignmentOrBuyer, 
			'Completed' AS ShipmentStatus,
			FORMAT (DCT.ProposedDate, 'dd MMM, yyyy') as DeliveryDateString
			
			FROM dbo.Customers AS C with(nolock)
			LEFT OUTER JOIN DriverCustomerTrack AS DCT with(nolock) ON C.CustomerId = DCT.CustomerId 
		
			WHERE DCT.IsCompleted = 1
				  AND (C.ConsignmentOrBuyer = 'C' OR C.ConsignmentOrBuyer = 'Consignment') 
				  AND C.IsActive = 1
				  AND DCT.UserDriverId=@DriverId

			Order by DCT.DriverCustomerTrackId DESC
	
END
GO
/****** Object:  StoredProcedure [dbo].[PickupProductsByStore]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Shubham>
-- Create Date: <Create Date, 20-12-2022 , >
-- Description: <Description, used to generate products from store, >
-- =============================================
-- Exec [dbo].[PickupProductsByStore] 26,42
CREATE PROCEDURE [dbo].[PickupProductsByStore]
(
   
   @CustomerId int,
   @DriverCustomerTrackId int
  
)
AS
BEGIN

      DECLARE @HeaderID int;
	  DECLARE @InitialHeaderID int;
	BEGIN TRY

	BEGIN TRANSACTION;
           
		   Set @HeaderID = (select top 1 DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where DriverCustomerTrackId=@DriverCustomerTrackId )

		   Set @InitialHeaderID =(select top 1 DeliveryHeaderId from 
		   dbo.CustomerDeliveryHeader with(nolock) where CustomerId = @CustomerId and DeliveryHeaderId <> @HeaderId and (IsInvoiceGenerated is null
		   or IsInvoiceGenerated = 0) order by DeliveryHeaderId desc)

		   If (@InitialHeaderID > 0)
		   BEGIN
		   select ProductId, (SELECT top 1 ProductSerial from dbo.Products with(nolock) where ProductId=ProductId) As ProductSerial, (SELECT top 1 ProductName from dbo.Products with(nolock) where ProductId=ProductId) As ProductName, (SELECT top 1 ProductPrice from dbo.Products with(nolock) where ProductId=ProductId) As ProductPrice from dbo.CustomerDeliveryDetail with(nolock) where DeliveryHeaderId = @InitialHeaderID
		   end
		   ELSE
		   BEGIN
		   select 0 As ProductId, '' As ProductSerial, '' As ProductName, 0.00 As ProductPrice
		   END
	COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SaveUserInformation]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----Exec SaveUserInformation 'Yousuf','','Rakib','yousufrakib04@gmail.com','yousuf12','fX09piLdVG2KSdZs5UGih8gb8H+UqOMkQ/4gWg712PQ=','37.111.204.245','',1
CREATE PROCEDURE [dbo].[SaveUserInformation] 
	@FirstName nvarchar(max)='',
	@MiddleName nvarchar(max)='',
	@LastName nvarchar(max)='',
	@EmailId nvarchar(max)='',
	@UserName nvarchar(max)='',
	@Password nvarchar(max)='',
	@IPAddress nvarchar(max)='',
	@CreatedBy nvarchar(max)='',
	@RoleId int=0
AS

	DECLARE @UserId TABLE(Id INT);

BEGIN

	BEGIN TRY

		BEGIN TRANSACTION;

		Insert Into Users 
		(
			FirstName,
			MiddleName,
			LastName,
			EmailId,
			UserName,
			Password,
			IPAddress,
			CreatedBy,
			CreatedDate,
			IsActive
		) 
		OUTPUT inserted.UserId INTO @UserId(Id)
		Values 
		(
			@FirstName,
			@MiddleName,
			@LastName,
			@EmailId,
			@UserName,
			@Password,
			@IPAddress,
			@CreatedBy,
			GetDate(),
			1
		)

		Insert into UserRoles (UserId,RoleId,DateCreated,IsActive) Values((Select Id as UserId from @UserId),@RoleId,GetDate(),1)

		COMMIT TRANSACTION;

		return 1;

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SkipPickupScan]    Script Date: 12-01-2023 20:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Shubham>
-- Create Date: <Create Date, 20-12-2022 , >
-- Description: <Description, used to check if driver tries to skip pickup scan will alert driver same, >
-- =============================================
CREATE PROCEDURE [dbo].[SkipPickupScan]
(
   @CustomerId int,
   @DriverCustomerTrackId int

)
AS
BEGIN

      DECLARE @HeaderId int;
	  DECLARE @initialrefheader int;
	  DECLARE @SoldQuantity int;
	
	BEGIN TRY

	BEGIN TRANSACTION;

	      Set @HeaderId = (select top 1 DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where DriverCustomerTrackId=@DriverCustomerTrackId)
    
	       Set @initialrefheader = (select DeliveryHeaderId from dbo.CustomerDeliveryHeader with(nolock) where DeliveryHeaderId=(select top 1 DeliveryHeaderId from 
		   dbo.CustomerDeliveryHeader with(nolock) where CustomerId = @CustomerId and DeliveryHeaderId <> @HeaderId and (IsInvoiceGenerated is null
		   or IsInvoiceGenerated = 0) order by DeliveryHeaderId desc))

		  

	COMMIT TRANSACTION;

	If (@initialrefheader > 0)
	BEGIN

	 If EXISTS (SELECT 1 from dbo.CustomerDeliveryDetail with(nolock) where DeliveryHeaderId=@initialrefheader)
	 BEGIN
	   Set @SoldQuantity = (SELECT count(*) from dbo.CustomerDeliveryDetail with(nolock) where DeliveryHeaderId=@initialrefheader)
	   Select @HeaderId AS HeaderId, @initialrefheader AS InitialRefHederId, ProductId,(SELECT top 1 ProductSerial from dbo.Products with(nolock) where ProductId=ProductId) AS ProductSerial,(SELECT top 1 ProductName from dbo.Products with(nolock) where ProductId=ProductId) as ProductName,(SELECT top 1 ProductPrice from dbo.Products with(nolock) where ProductId=ProductId) as ProductPrice,@SoldQuantity as SoldQuantity from dbo.CustomerDeliveryDetail with(nolock) where DeliveryHeaderId=@initialrefheader
	  END
     else
	 BEGIN
	 Set @SoldQuantity = (select top 1 ActualProductsShipped from dbo.DriverCustomerTrack DCT WITH(NOLOCK) INNER JOIN dbo.CustomerDeliveryHeader CDH WITH(NOLOCK) ON CDH.DriverCustomerTrackId=DCT.DriverCustomerTrackId WHERE CDH.DeliveryHeaderId=@initialrefheader)
	    select @HeaderId as HeaderId,@initialrefheader as InitialRefHederId, -1 as ProductId, '' as ProductSerial, '' as ProductName, 0.00 as ProductPrice, @SoldQuantity as SoldQuantity
	 END

	END
	ELSE
	BEGIN
	select @HeaderId as HeaderId,@initialrefheader as InitialRefHederId, 0 as ProductId, '' as ProductSerial, '' as ProductName, 0.00 as ProductPrice, 0 as SoldQuantity
	END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH
END
GO
ALTER DATABASE [PosterDelivery_Dev] SET  READ_WRITE 
GO
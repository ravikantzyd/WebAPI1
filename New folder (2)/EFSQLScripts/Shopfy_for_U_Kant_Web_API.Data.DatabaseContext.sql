IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [Credits] (
        [Id] int NOT NULL IDENTITY,
        [VoucherId] nvarchar(max) NOT NULL,
        [CustomerId] int NOT NULL,
        [CreditAmt] real NOT NULL,
        [PaidAmt] real NOT NULL,
        CONSTRAINT [PK_Credits] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [CustomerChanges] (
        [Id] int NOT NULL IDENTITY,
        [CustomerId] int NOT NULL,
        [CreatedCustomerName] nvarchar(50) NULL,
        [OldCustomerName] nvarchar(50) NULL,
        [NewCustomerName] nvarchar(50) NULL,
        [EditStatus] nvarchar(50) NULL,
        CONSTRAINT [PK_CustomerChanges] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [Customers] (
        [Id] int NOT NULL IDENTITY,
        [CustomerName] nvarchar(300) NOT NULL,
        [Phone] nvarchar(15) NULL,
        [Address] nvarchar(1000) NULL,
        CONSTRAINT [PK_Customers] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [ItemChanges] (
        [Id] int NOT NULL IDENTITY,
        [ItemId] int NOT NULL,
        [CreatedItemName] nvarchar(50) NULL,
        [OldItemName] nvarchar(50) NULL,
        [NewItemName] nvarchar(50) NULL,
        [EditStatus] nvarchar(50) NULL,
        CONSTRAINT [PK_ItemChanges] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [Items] (
        [Id] int NOT NULL IDENTITY,
        [ItemName] nvarchar(300) NOT NULL,
        CONSTRAINT [PK_Items] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [Notifies] (
        [Id] int NOT NULL IDENTITY,
        [Message] nvarchar(max) NULL,
        CONSTRAINT [PK_Notifies] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [UnitChanges] (
        [Id] int NOT NULL IDENTITY,
        [UnitId] int NOT NULL,
        [CreatedUnitName] nvarchar(50) NULL,
        [OldUnitName] nvarchar(50) NULL,
        [NewUnitName] nvarchar(50) NULL,
        [EditStatus] nvarchar(50) NULL,
        CONSTRAINT [PK_UnitChanges] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [Units] (
        [Id] int NOT NULL IDENTITY,
        [UnitName] nvarchar(200) NOT NULL,
        CONSTRAINT [PK_Units] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [VoucherNoChanges] (
        [Id] int NOT NULL IDENTITY,
        [VoucherId] nvarchar(50) NULL,
        CONSTRAINT [PK_VoucherNoChanges] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [VoucherNos] (
        [Id] int NOT NULL IDENTITY,
        [Date] nvarchar(30) NOT NULL,
        [Number] int NOT NULL,
        CONSTRAINT [PK_VoucherNos] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [Contains] (
        [Id] int NOT NULL IDENTITY,
        [Date] datetime2 NOT NULL,
        [ItemId] int NOT NULL,
        [UnitId] int NOT NULL,
        [ContainQty] real NOT NULL,
        CONSTRAINT [PK_Contains] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Contains_Items_ItemId] FOREIGN KEY ([ItemId]) REFERENCES [Items] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Contains_Units_UnitId] FOREIGN KEY ([UnitId]) REFERENCES [Units] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [ItemUnits] (
        [ItemId] int NOT NULL,
        [UnitId] int NOT NULL,
        CONSTRAINT [PK_ItemUnits] PRIMARY KEY ([ItemId], [UnitId]),
        CONSTRAINT [FK_ItemUnits_Items_ItemId] FOREIGN KEY ([ItemId]) REFERENCES [Items] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ItemUnits_Units_UnitId] FOREIGN KEY ([UnitId]) REFERENCES [Units] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [PurchasePrices] (
        [Id] int NOT NULL IDENTITY,
        [Date] datetime2 NOT NULL,
        [PurchasePriceAmount] float NOT NULL,
        [ItemId] int NOT NULL,
        [UnitId] int NOT NULL,
        CONSTRAINT [PK_PurchasePrices] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PurchasePrices_Items_ItemId] FOREIGN KEY ([ItemId]) REFERENCES [Items] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_PurchasePrices_Units_UnitId] FOREIGN KEY ([UnitId]) REFERENCES [Units] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [SalePrices] (
        [Id] int NOT NULL IDENTITY,
        [Date] datetime2 NOT NULL,
        [SalePriceAmount] float NOT NULL,
        [ItemId] int NOT NULL,
        [UnitId] int NOT NULL,
        CONSTRAINT [PK_SalePrices] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SalePrices_Items_ItemId] FOREIGN KEY ([ItemId]) REFERENCES [Items] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_SalePrices_Units_UnitId] FOREIGN KEY ([UnitId]) REFERENCES [Units] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [SaleInvoices] (
        [Id] int NOT NULL IDENTITY,
        [Date] datetime2 NOT NULL,
        [VoucherId] nvarchar(30) NOT NULL,
        [CustomerId] int NOT NULL,
        [ItemId] int NOT NULL,
        [UnitId] int NOT NULL,
        [Qty] float NOT NULL,
        [TotalSales] float NOT NULL,
        [SalesStatus] nvarchar(20) NOT NULL,
        [PurchasesPriceId] int NOT NULL,
        [PurchasePricesId] int NULL,
        [SalesPriceId] int NOT NULL,
        [SalePricesId] int NULL,
        [ContainId] int NOT NULL,
        CONSTRAINT [PK_SaleInvoices] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SaleInvoices_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_SaleInvoices_Items_ItemId] FOREIGN KEY ([ItemId]) REFERENCES [Items] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_SaleInvoices_PurchasePrices_PurchasePricesId] FOREIGN KEY ([PurchasePricesId]) REFERENCES [PurchasePrices] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_SaleInvoices_SalePrices_SalePricesId] FOREIGN KEY ([SalePricesId]) REFERENCES [SalePrices] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_SaleInvoices_Units_UnitId] FOREIGN KEY ([UnitId]) REFERENCES [Units] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE TABLE [SIVEditHiss] (
        [Id] int NOT NULL IDENTITY,
        [Date] datetime2 NOT NULL,
        [VoucherId] nvarchar(30) NOT NULL,
        [CustomerId] int NOT NULL,
        [ItemId] int NOT NULL,
        [UnitId] int NOT NULL,
        [Qty] float NOT NULL,
        [TotalSales] float NOT NULL,
        [Status] nvarchar(20) NOT NULL,
        [EditTimes] int NOT NULL,
        [PurchasesPriceId] int NOT NULL,
        [PurchasePricesId] int NULL,
        [SalesPriceId] int NOT NULL,
        [SalePricesId] int NULL,
        [ContainId] int NOT NULL,
        CONSTRAINT [PK_SIVEditHiss] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SIVEditHiss_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_SIVEditHiss_Items_ItemId] FOREIGN KEY ([ItemId]) REFERENCES [Items] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_SIVEditHiss_PurchasePrices_PurchasePricesId] FOREIGN KEY ([PurchasePricesId]) REFERENCES [PurchasePrices] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_SIVEditHiss_SalePrices_SalePricesId] FOREIGN KEY ([SalePricesId]) REFERENCES [SalePrices] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_SIVEditHiss_Units_UnitId] FOREIGN KEY ([UnitId]) REFERENCES [Units] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedCustomerName', N'CustomerId', N'EditStatus', N'NewCustomerName', N'OldCustomerName') AND [object_id] = OBJECT_ID(N'[CustomerChanges]'))
        SET IDENTITY_INSERT [CustomerChanges] ON;
    EXEC(N'INSERT INTO [CustomerChanges] ([Id], [CreatedCustomerName], [CustomerId], [EditStatus], [NewCustomerName], [OldCustomerName])
    VALUES (1, N'''', 0, N'''', N'''', N'''')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedCustomerName', N'CustomerId', N'EditStatus', N'NewCustomerName', N'OldCustomerName') AND [object_id] = OBJECT_ID(N'[CustomerChanges]'))
        SET IDENTITY_INSERT [CustomerChanges] OFF;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedItemName', N'EditStatus', N'ItemId', N'NewItemName', N'OldItemName') AND [object_id] = OBJECT_ID(N'[ItemChanges]'))
        SET IDENTITY_INSERT [ItemChanges] ON;
    EXEC(N'INSERT INTO [ItemChanges] ([Id], [CreatedItemName], [EditStatus], [ItemId], [NewItemName], [OldItemName])
    VALUES (1, N'''', N'''', 0, N'''', N'''')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedItemName', N'EditStatus', N'ItemId', N'NewItemName', N'OldItemName') AND [object_id] = OBJECT_ID(N'[ItemChanges]'))
        SET IDENTITY_INSERT [ItemChanges] OFF;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Message') AND [object_id] = OBJECT_ID(N'[Notifies]'))
        SET IDENTITY_INSERT [Notifies] ON;
    EXEC(N'INSERT INTO [Notifies] ([Id], [Message])
    VALUES (1, N'''')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Message') AND [object_id] = OBJECT_ID(N'[Notifies]'))
        SET IDENTITY_INSERT [Notifies] OFF;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedUnitName', N'EditStatus', N'NewUnitName', N'OldUnitName', N'UnitId') AND [object_id] = OBJECT_ID(N'[UnitChanges]'))
        SET IDENTITY_INSERT [UnitChanges] ON;
    EXEC(N'INSERT INTO [UnitChanges] ([Id], [CreatedUnitName], [EditStatus], [NewUnitName], [OldUnitName], [UnitId])
    VALUES (1, N'''', N'''', N'''', N'''', 0)');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedUnitName', N'EditStatus', N'NewUnitName', N'OldUnitName', N'UnitId') AND [object_id] = OBJECT_ID(N'[UnitChanges]'))
        SET IDENTITY_INSERT [UnitChanges] OFF;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'VoucherId') AND [object_id] = OBJECT_ID(N'[VoucherNoChanges]'))
        SET IDENTITY_INSERT [VoucherNoChanges] ON;
    EXEC(N'INSERT INTO [VoucherNoChanges] ([Id], [VoucherId])
    VALUES (1, N'''')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'VoucherId') AND [object_id] = OBJECT_ID(N'[VoucherNoChanges]'))
        SET IDENTITY_INSERT [VoucherNoChanges] OFF;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_Contains_ItemId] ON [Contains] ([ItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_Contains_UnitId] ON [Contains] ([UnitId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_ItemUnits_UnitId] ON [ItemUnits] ([UnitId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_PurchasePrices_ItemId] ON [PurchasePrices] ([ItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_PurchasePrices_UnitId] ON [PurchasePrices] ([UnitId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SaleInvoices_CustomerId] ON [SaleInvoices] ([CustomerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SaleInvoices_ItemId] ON [SaleInvoices] ([ItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SaleInvoices_PurchasePricesId] ON [SaleInvoices] ([PurchasePricesId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SaleInvoices_SalePricesId] ON [SaleInvoices] ([SalePricesId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SaleInvoices_UnitId] ON [SaleInvoices] ([UnitId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SalePrices_ItemId] ON [SalePrices] ([ItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SalePrices_UnitId] ON [SalePrices] ([UnitId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SIVEditHiss_CustomerId] ON [SIVEditHiss] ([CustomerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SIVEditHiss_ItemId] ON [SIVEditHiss] ([ItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SIVEditHiss_PurchasePricesId] ON [SIVEditHiss] ([PurchasePricesId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SIVEditHiss_SalePricesId] ON [SIVEditHiss] ([SalePricesId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    CREATE INDEX [IX_SIVEditHiss_UnitId] ON [SIVEditHiss] ([UnitId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211103182238_createDatabase1')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20211103182238_createDatabase1', N'5.0.10');
END;
GO

COMMIT;
GO


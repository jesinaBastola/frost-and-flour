-- ============================================
-- FROST AND FLOUR - Online Bakery Ordering System
-- DATABASE SCHEMA
-- Run this in SQL Server Management Studio (SSMS)
-- ============================================

CREATE DATABASE FrostAndFlour;
GO

USE FrostAndFlour;
GO

-- 1. USERS TABLE
CREATE TABLE Users (
    UserID      INT IDENTITY(1,1) PRIMARY KEY,
    FullName    NVARCHAR(100) NOT NULL,
    Email       NVARCHAR(150) NOT NULL UNIQUE,
    Password    NVARCHAR(255) NOT NULL,  -- store hashed
    Phone       NVARCHAR(20),
    Address     NVARCHAR(300),
    Role        NVARCHAR(20) NOT NULL DEFAULT 'Customer', -- 'Customer' or 'Admin'
    CreatedAt   DATETIME DEFAULT GETDATE()
);

-- 2. CATEGORIES TABLE
CREATE TABLE Categories (
    CategoryID   INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description  NVARCHAR(300)
);

-- 3. PRODUCTS TABLE
CREATE TABLE Products (
    ProductID    INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID   INT FOREIGN KEY REFERENCES Categories(CategoryID),
    ProductName  NVARCHAR(150) NOT NULL,
    Description  NVARCHAR(500),
    Price        DECIMAL(10,2) NOT NULL,
    ImageURL     NVARCHAR(300),
    Stock        INT NOT NULL DEFAULT 0,
    IsAvailable  BIT DEFAULT 1,
    CreatedAt    DATETIME DEFAULT GETDATE()
);

-- 4. ORDERS TABLE
CREATE TABLE Orders (
    OrderID         INT IDENTITY(1,1) PRIMARY KEY,
    UserID          INT FOREIGN KEY REFERENCES Users(UserID),
    TotalAmount     DECIMAL(10,2) NOT NULL,
    Status          NVARCHAR(50) DEFAULT 'Pending',
    -- Status: Pending, Confirmed, Preparing, Out for Delivery, Delivered, Cancelled
    DeliveryAddress NVARCHAR(300),
    OrderDate       DATETIME DEFAULT GETDATE(),
    DeliveryDate    DATETIME,
    Notes           NVARCHAR(500)   -- custom cake instructions
);

-- 5. ORDER ITEMS TABLE
CREATE TABLE OrderItems (
    OrderItemID     INT IDENTITY(1,1) PRIMARY KEY,
    OrderID         INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID       INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity        INT NOT NULL,
    UnitPrice       DECIMAL(10,2) NOT NULL,
    CustomMessage   NVARCHAR(300),  -- e.g. "Happy Birthday John!"
    CustomFlavor    NVARCHAR(100),
    CustomSize      NVARCHAR(50)
);

-- 6. PAYMENTS TABLE
CREATE TABLE Payments (
    PaymentID       INT IDENTITY(1,1) PRIMARY KEY,
    OrderID         INT FOREIGN KEY REFERENCES Orders(OrderID),
    Amount          DECIMAL(10,2) NOT NULL,
    Method          NVARCHAR(50),   -- e.g. Card, PayPal, Cash on Delivery
    Status          NVARCHAR(50) DEFAULT 'Pending',  -- Pending, Completed, Failed
    TransactionRef  NVARCHAR(200),
    PaymentDate     DATETIME DEFAULT GETDATE()
);

-- 7. CART TABLE (session cart stored in DB)
CREATE TABLE Cart (
    CartID          INT IDENTITY(1,1) PRIMARY KEY,
    UserID          INT FOREIGN KEY REFERENCES Users(UserID),
    ProductID       INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity        INT NOT NULL DEFAULT 1,
    CustomMessage   NVARCHAR(300),
    CustomFlavor    NVARCHAR(100),
    CustomSize      NVARCHAR(50),
    AddedAt         DATETIME DEFAULT GETDATE()
);

-- 8. REVIEWS TABLE
CREATE TABLE Reviews (
    ReviewID    INT IDENTITY(1,1) PRIMARY KEY,
    ProductID   INT FOREIGN KEY REFERENCES Products(ProductID),
    UserID      INT FOREIGN KEY REFERENCES Users(UserID),
    Rating      INT CHECK(Rating BETWEEN 1 AND 5),
    Comment     NVARCHAR(500),
    ReviewDate  DATETIME DEFAULT GETDATE()
);

-- 9. INVENTORY TABLE
CREATE TABLE Inventory (
    InventoryID     INT IDENTITY(1,1) PRIMARY KEY,
    ProductID       INT FOREIGN KEY REFERENCES Products(ProductID),
    QuantityAdded   INT,
    Note            NVARCHAR(300),
    UpdatedAt       DATETIME DEFAULT GETDATE()
);

-- ============================================
-- SAMPLE DATA
-- ============================================

-- Admin User (Password: Admin@123 - you should hash this in real app)
INSERT INTO Users (FullName, Email, Password, Phone, Role)
VALUES ('Admin', 'admin@frostandflour.com', 'Admin@123', '0000000000', 'Admin');

-- Sample Customer
INSERT INTO Users (FullName, Email, Password, Phone, Address, Role)
VALUES ('Shiksha Nepali', 'shiksha@email.com', 'Pass@123', '9800000000', 'Kathmandu, Nepal', 'Customer');

-- Categories
INSERT INTO Categories (CategoryName, Description) VALUES ('Cakes', 'Custom and ready-made cakes');
INSERT INTO Categories (CategoryName, Description) VALUES ('Pastries', 'Croissants, danishes and more');
INSERT INTO Categories (CategoryName, Description) VALUES ('Cookies', 'Freshly baked cookies');
INSERT INTO Categories (CategoryName, Description) VALUES ('Bread', 'Artisan breads');
INSERT INTO Categories (CategoryName, Description) VALUES ('Cupcakes', 'Decorated cupcakes');
INSERT INTO Categories (CategoryName, Description) VALUES ('Desserts', 'Specialty desserts');

-- Sample Products
INSERT INTO Products (CategoryID, ProductName, Description, Price, Stock)
VALUES
(1, 'Chocolate Truffle Cake', 'Rich dark chocolate layers with ganache', 1200.00, 10),
(1, 'Vanilla Birthday Cake', 'Classic vanilla with buttercream frosting', 900.00, 15),
(1, 'Red Velvet Cake', 'Moist red velvet with cream cheese frosting', 1100.00, 8),
(2, 'Butter Croissant', 'Flaky golden croissant', 150.00, 30),
(3, 'Choco Chip Cookies', 'Classic chocolate chip cookies (6 pcs)', 250.00, 50),
(4, 'Sourdough Bread', 'Traditional sourdough loaf', 300.00, 20),
(5, 'Red Velvet Cupcake', 'Mini red velvet cupcakes (4 pcs)', 400.00, 25),
(6, 'Cheesecake Slice', 'New York style cheesecake', 350.00, 15);

GO

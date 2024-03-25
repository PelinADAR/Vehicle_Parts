Create database Vehicle_Parts
Go
use Vehicle_Parts
Go
Create table Product
(
    ProductId int identity(1,1) Primary Key,
    Product_Name nvarchar (100) not null,
    Product_Description nvarchar (300),
	CategoryId int not null,
	SupplierId int not null,
	Stock_Quantity int not null,
	Price decimal(18,2) not null,
	CreationDate Datetime not null DEFAULT GETDATE(),
	Update_Date Datetime ,
	Oem_Number nvarchar(50) unique not null 

);

create table Categories
(
CategoryId int identity(1,1) Primary Key,
Category_Name nvarchar(100) not null,
Category_Description nvarchar(300)
);


create table Suppliers
(
SupplierId int identity(1,1) Primary Key,
Supplier_Name nvarchar(100) not null,
Adress nvarchar(300),
Contact_Information  varchar(20) unique,
CONSTRAINT CHK_PhoneNumber CHECK (Contact_Information LIKE '[0-9]%' AND LEN(Contact_Information) >= 10 AND LEN(Contact_Information) <= 15),

City nvarchar(15) not null,
Country nvarchar(30) Default ('Türkiye')
);

create table Customers
(
CustomerId int identity(1,1) Primary Key,
Customer_FullName nvarchar(50) not null,
Adress nvarchar(300),
Contact_Information varchar(20) unique,

);

create table Orders
(
OrderId  int  identity(1,1) Primary Key,
CustomerId int  Foreign Key references Customers(CustomerId),
Order_Date Datetime not null  DEFAULT GETDATE(),
Total_Amount decimal(18,2),

);

create table Order_Detail
(
    OrderDetailId int  identity(1,1) Primary Key,
    OrderId int  Foreign Key references Orders(OrderId),
    ProductId int  Foreign Key references Product(ProductId),
    Quantity int not null, 
    Price decimal not null, 
    CONSTRAINT CHK_Quantity CHECK (Quantity > 0) 
);

create table  Product_Categories_Products
(
 ProductId int references Product(ProductId) not null,
 PRIMARY KEY (ProductId, CategoryId),
 CategoryId int  references Categories(CategoryId) not null,
   
);


create table Supplier_Product (
    Supplier_id int references Suppliers(SupplierId) not null,
    Product_id int references Product(ProductId) not null,
    Primary key (Supplier_id, Product_id)
);


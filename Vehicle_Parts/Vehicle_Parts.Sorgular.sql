--Product tablosunu tüm sütunlarýyla getirir.

select *  from Product

---------------------------------------------------------------------------------------------------------------------------------------------------------

--Product ve Categories tablolarýný birleþtirip istediðimiz sütunlarý çekmiþ olduk.

Select
    p.ProductId, p.Product_Name, p.Product_Description, p.CategoryId, c.Category_Name
From  
    Product p
Inner join
    Categories c on p.CategoryId = c.CategoryId;

---------------------------------------------------------------------------------------------------------------------------------------------------------

--Kategori adý 'Tires and Rimes' olan ürünleri listeler.

Select
    p.ProductId, p.Product_Name, p.Product_Description, c.Category_Name
From
    Product p
Inner join Categories c On p.CategoryId = c.CategoryId
Where
    c.Category_Name = 'Tires and Rims';

---------------------------------------------------------------------------------------------------------------------------------------------------------
--Supplier-Name i AutoAccessories Shop olanlarý getirdik.

Select 
    p.ProductId, p.Product_Name, p.Product_Description, s.Supplier_Name
From  
    Product p
Inner join 
    Suppliers s on p.SupplierId = s.SupplierId
Where  
    s.Supplier_Name = 'AutoAccessories Shop';

---------------------------------------------------------------------------------------------------------------------------------------------------------

--Fiyat için aralýk verip o ürünleri getirdik.

Select 
    p.ProductId, p.Product_Name, p.Product_Description, p.Price
From
    Product p
Where
    p.Price BETWEEN 100.00 AND 200.00;

---------------------------------------------------------------------------------------------------------------------------------------------------------

--Stok miktarý 50 den az olanlarý getirdik.

Select
    p.ProductId, p.Product_Name, p.Product_Description, p.Stock_Quantity
From  
    Product p
Where
    p.Stock_Quantity < 50;

---------------------------------------------------------------------------------------------------------------------------------------------------------
--VÝEW OLUÞTURDUK

Create view vw_ProductDetails
as
Select
    ProductId,Product_Name,Product_Description,c.Category_Name,Stock_Quantity,Price,CreationDate,Update_Date,Oem_Number,Supplier_Name 
From  
    Product as p
Inner join 
    Categories as c on c.CategoryId=p.CategoryId
Inner join  
	Suppliers as s on s.SupplierId=p.SupplierId


Select * from vw_ProductDetails

----------------------------------------------------------------------------------------------------------------------------------------------------------

--FONKSÝYON OLUÞTURDUK

go
Create Function KdvFiyat(@fiyat MONEY)
Returns Money
As
Begin
    Declare @kdvliFiyat MONEY;
    Set @kdvliFiyat = @fiyat * 1.18;
    Return @kdvliFiyat;
End;
go 

Select
    p.Product_Name,
    c.Category_Name,
    p.Price,
	dbo.KdvFiyat(p.Price) as KdvliFiyat
From
    Product as p
Join
    Categories as c on c.CategoryId = p.CategoryId
Join
    Order_Detail as o on o.ProductId = p.ProductId;


--------------------------------------------------------------------------------------------------------------------------------------------------------

Select
    P.ProductId,
    P.Product_Name,
    Sum(PD.Quantity) as Total_Quantity,
    Sum(PD.Price) as Total_Price
From
    Product as P
Inner join
    Order_Detail as PD on P.ProductId = PD.ProductId
Group by 
    P.ProductId, P.Product_Name;

-------------------------------------------------------------------------------------------------------------------------------------------------------

Select 
   Product_Name,c.Category_Name,CreationDate,Stock_Quantity,Oem_Number 
From
   Product as p
Inner join
   Categories as c on c.CategoryId=p.CategoryId
Where 
    c.Category_Name='Exterior Covering Parts' and Oem_Number LIKE '%8'
Order by
    Stock_Quantity desc


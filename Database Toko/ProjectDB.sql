CREATE DATABASE bEJIBUN
GO
USE bEJIBUN
GO
----------------------------B
CREATE TABLE Staff(
	StaffId CHAR (5)PRIMARY KEY CHECK(StaffId LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(255) NOT NULL,
	StaffGender CHAR (6) CHECK (StaffGender IN('Female','Male')) NOT NULL,
	StaffPhone VARCHAR(20)NOT NULL,
	StaffSalary INT CHECK (StaffSalary>0) NOT NULL
)
CREATE TABLE Customer(
	CustomerId CHAR(5)PRIMARY KEY CHECK (CustomerId LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(255) NOT NULL,
	CustomerGender CHAR(6)CHECK(CustomerGender IN('Female','Male')) NOT NULL,
	CustomerPhone VARCHAR(20)NOT NULL,
	CustomerDateOfBirth DATE CHECK(CustomerDateOfBirth BETWEEN '1990-01-01' AND GETDATE()) NOT NULL
) 
CREATE TABLE ItemType(
	ItemTypeId CHAR (5) PRIMARY KEY CHECK (ItemTypeId LIKE'IP[0-9][0-9][0-9]'),
	ItemTypeName VARCHAR(255) CHECK(LEN(ItemTypeName)>=4) NOT NULL
)
CREATE TABLE Vendor(
	VendorId CHAR(5)PRIMARY KEY CHECK(VendorId LIKE 'VE[0-9][0-9][0-9]'),
	VendorName VARCHAR(255) NOT NULL,
	VendorPhone VARCHAR (20) NOT NULL,
	VendorAddress VARCHAR(255)CHECK(VendorAddress LIKE '%Street') NOT NULL,
	VendorEmail VARCHAR(255)CHECK (VendorEmail LIKE '%@%'AND VendorEmail LIKE '%.com' AND CHARINDEX('@',VendorEmail)!=1 AND RIGHT(VendorEmail,5)NOT LIKE'@.com') NOT NULL
)
CREATE TABLE TransactionHeader(
	TransactionId CHAR(5) PRIMARY KEY CHECK (TransactionId LIKE 'SA[0-9][0-9][0-9]'),
	CustomerId CHAR(5)FOREIGN KEY REFERENCES Customer(CustomerId)ON UPDATE CASCADE ON DELETE CASCADE,
	StaffId CHAR(5)FOREIGN KEY REFERENCES Staff(StaffId)ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE NOT NULL
)
CREATE Table PurchaseHeader(
	PurchaseId CHAR (5) PRIMARY KEY CHECK(PurchaseId LIKE 'PH[0-9][0-9][0-9]'),
	VendorId CHAR (5)FOREIGN KEY REFERENCES Vendor(VendorId)ON UPDATE CASCADE ON DELETE CASCADE,
	StaffId CHAR(5)FOREIGN KEY REFERENCES Staff(StaffId)ON UPDATE CASCADE ON DELETE CASCADE,
	PurchasingDate DATE NOT NULL,
	ArrivalDate DATE 
)
CREATE TABLE Items(
	ItemId CHAR(5) PRIMARY KEY CHECK (ItemId LIKE 'IT[0-9][0-9][0-9]'),
	ItemTypeId CHAR(5) FOREIGN KEY REFERENCES ItemType(ItemTypeId) ON UPDATE CASCADE ON DELETE CASCADE,
	ItemName VARCHAR(255) NOT NULL,
	ItemPrice INT NOT NULL CHECK(ItemPrice>0),
	MinimumPurchaseItem INT NOT NULL,
	StockItem INT NOT NULL
)
CREATE TABLE PurchaseDetails(
	PurchaseId CHAR (5) FOREIGN KEY REFERENCES PurchaseHeader(PurchaseId)ON UPDATE CASCADE ON DELETE CASCADE,
	ItemId CHAR(5) FOREIGN KEY REFERENCES Items(ItemId)ON UPDATE CASCADE ON DELETE CASCADE,
	PurchaseItemQTY INT NOT NULL
	PRIMARY KEY (PurchaseId,ItemId)
)
CREATE TABLE TransactionDetails(
	TransactionId CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
	ItemId CHAR (5) FOREIGN KEY REFERENCES Items(ItemId)ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionItemQTY INT NOT NULL
)
----------------------------B

----------------------------C
INSERT INTO	Customer VALUES
	('CU001','Yehuda Levy','Male','0878555302','2002-12-07'),
	('CU002','Emma-Louise Brandt','Female','0853555534','2001-11-25'),
	('CU003','Cora Armitage','Female','0853555451','2000-01-23'),
	('CU004','Agus Supriyadi','Male','0878882731','1999-05-13'),
	('CU005','Sammy Sesame','Female','0877154322','1999-11-01'),
	('CU006','Susi Supriadi','Female','0877757301','1998-07-08'),
	('CU007','Sugus Supugus','Male','0874312787','1998-06-04'),
	('CU008','Gadis Beralis','Female','0854312599','1991-08-17'),
	('CU009','Suwi Suwardi','Male','0878555302','1998-07-12'),
	('CU010','Lamusa Sumasi','Male','0827635201','1990-01-31'),
	('CU011','Luar Dora','Male','0876553210','1992-02-26')
INSERT INTO ItemType VALUES
	('IP001','Drink'),
	('IP002','Food'),
	('IP003','Canned Food'),
	('IP004','Baking Goods'),
	('IP005','Frozen Food'),
	('IP006','Meat'),
	('IP007','Vegetables'),
	('IP008','Cleaners'),
	('IP009','Paper Goods'),
	('IP010','Electronic'),
	('IP011','Gadgets')
INSERT INTO Vendor VALUES
	('VE001','Toko Bagus','0878555301','Food Street','initokobagus@gmail.com'),
	('VE002','Toko Jelek','0853555533','Jelek Street','initokojelek@gmail.com'),
	('VE003','Toko Luar','0853555450','Food123 Street','initokoluar@hotmail.com'),
	('VE004','Toko Dalam','0853552441','Dalam Street','initokodalam@yahoo.com'),
	('VE005','Toko Celana','0898732151','Celana Street','initokocelana@yxnmaq.com'),
	('VE006','Toko Bibi','0876521389','Bibi Street','initokobibi@yummy.com'),
	('VE007','Toko Paman','0843139486','Paman Street','initokopaman@sebelah.com'),
	('VE008','Toko Sebelah','0812087641','Sebelah Street','initokosudirman@titik.com'),
	('VE009','Toko Didepan','0813278098','Didepan Street','initokodidepan@koma.com'),
	('VE010','Toko Samping','0815426932','Samping Street','initokosamping@titikkoma.com'),
	('VE011','Toko Aja','0894212753','Food Street','yainitoko@aja.com')
INSERT INTO Staff VALUES
	('ST001','Suri Supriyadi','Male','0814561289',20000),
	('ST002','Susi Susianti','Female','0811456627',15000),
	('ST003','Joko Wilamar','Male','0811095432',15500),
	('ST004','Ashley Menanti','Female','084290983',25000),
	('ST005','Santo Menanto','Male','0897771234',30000),
	('ST006','Budi Melanjo','Male','0890096243',17000),
	('ST007','Santo Menanto','Male','0897771234',30000),
	('ST008','Sally Sour','Female','0860780763',5000),
	('ST009','Ciki Suwir','Female','0881256894',16000),
	('ST010','Bella Bello','Female','0888045678',12000),
	('ST011','Mamang Supriyadi','Male','0876542976',13000)
INSERT INTO TransactionHeader VALUES 
	('SA001','CU001','ST002','2019-02-27'),
	('SA002','CU007','ST006','2020-08-15'),
	('SA003','CU011','ST009','2018-09-30'),
	('SA004','CU010','ST007','2020-03-11'),
	('SA005','CU001','ST005','2021-01-13'),
	('SA006','CU004','ST008','2020-12-15'),
	('SA007','CU002','ST001','2020-03-18'),
	('SA008','CU005','ST011','2021-03-05'),
	('SA009','CU009','ST010','2019-07-15'),
	('SA010','CU008','ST004','2021-01-16'),
	('SA011','CU003','ST005','2020-10-31'),
	('SA012','CU006','ST003','2021-04-01'),
	('SA013','CU007','ST009','2020-09-12'),
	('SA014','CU003','ST006','2020-02-19'),
	('SA015','CU001','ST008','2021-04-30'),
	('SA016','CU010','ST003','2021-08-01')
INSERT INTO Items VALUES
	('IT001','IP001','Oko Jelly Drink',500,2,44),
	('IT002','IP002','Rosaria Roasted Chicken',1500,10,56),
	('IT003','IP003','Bibi Canned Beans',500,5,280),
	('IT004','IP004','Choccy Pie',500,1,75),
	('IT005','IP005','Frozen McNuggets',2000,4,440),
	('IT006','IP006','Sausage McSausage',2500,2,500),
	('IT007','IP007','Baba Buncis',100,4,461),
	('IT008','IP008','BabayClean',200,1,30),
	('IT009','IP009','Paint Brushes',300,7,9),
	('IT010','IP010','Solar Lamp',300,3,39),
	('IT011','IP011','Sumsang Phone',400,6,200),
	('IT012','IP001','Hour Made Pulpy Juice',100,5,52),
	('IT013','IP002','Cheeseburger',600,16,28),
	('IT014','IP003','Papa Canned Meat',300,3,26),
	('IT015','IP004','Donny Donuts',100,6,262),
	('IT016','IP005','Good Ice Cream',100,5,13)
INSERT INTO PurchaseHeader VALUES
	('PH001','VE001','ST008','2019-09-26','2019-10-27'),
	('PH002','VE007','ST011','2020-04-25','2020-05-27'),
	('PH003','VE011','ST004','2018-09-03','2018-12-13'),
	('PH004','VE010','ST006','2020-02-23','2020-05-25'),
	('PH005','VE001','ST010','2021-03-26',NULL),
	('PH006','VE004','ST004','2020-11-06','2020-12-08'),
	('PH007','VE002','ST005','2020-05-20','2020-05-22'),
	('PH008','VE005','ST001','2021-09-17',NULL),
	('PH009','VE009','ST002','2019-11-29','2020-01-01'),
	('PH010','VE008','ST009','2021-05-18',NULL),
	('PH011','VE003','ST003','2020-07-05','2020-10-12'),
	('PH012','VE006','ST010','2021-06-02','2021-09-12'),
	('PH013','VE007','ST001','2020-04-13','2020-05-21'),
	('PH014','VE003','ST002','2020-05-26','2021-01-21'),
	('PH015','VE001','ST003','2021-08-05','2021-09-06'),
	('PH016','VE010','ST007','2021-10-30','2021-11-05')
INSERT INTO PurchaseDetails VALUES
	('PH001','IT001',44),
	('PH001','IT007',26),
	('PH001','IT008',30),
	('PH002','IT016',13),
	('PH002','IT005',90),
	('PH002','IT011',200),
	('PH003','IT009',9),
	('PH004','IT010',4),
	('PH005','IT013',20),
	('PH005','IT006',75),
	('PH006','IT002',56),
	('PH007','IT005',200),
	('PH008','IT012',10),
	('PH009','IT003',23),
	('PH010','IT004',2),
	('PH010','IT013',8),
	('PH010','IT005',12),
	('PH010','IT008',88),
	('PH011','IT010',35),
	('PH012','IT005',50),
	('PH012','IT002',56),
	('PH013','IT005',100),
	('PH013','IT004',75),
	('PH014','IT003',27),
	('PH015','IT007',150),
	('PH016','IT006',500),
	('PH016','IT007',200),
	('PH005','IT003',230),
	('PH002','IT007',235)
INSERT INTO TransactionDetails VALUES
	('SA001','IT006',11),
	('SA001','IT005',23),
	('SA001','IT004',27),
	('SA002','IT008',20),
	('SA002','IT006',25),
	('SA002','IT008',22),
	('SA003','IT015',9),
	('SA004','IT004',4),
	('SA005','IT007',33),
	('SA005','IT008',43),
	('SA006','IT012',78),
	('SA007','IT013',214),
	('SA008','IT014',78),
	('SA009','IT010',242),
	('SA010','IT008',12),
	('SA010','IT012',27),
	('SA010','IT010',9),
	('SA010','IT012',14),
	('SA011','IT009',50),
	('SA012','IT005',45),
	('SA013','IT004',100),
	('SA014','IT001',27),
	('SA015','IT002',111),
	('SA016','IT002',126),
	('SA005','IT015',145),
	('SA002','IT014',239)
----------------------------C


----------------------------D
--Misal jika ada transaction sales baru yang masuk
INSERT INTO TransactionHeader VALUES('SA017','CU010','ST007','2021-10-08')
INSERT INTO TransactionDetails VALUES
	('SA017','IT004',12),
	('SA017','IT007',50)

--Mengupdate total stock dari IT004
UPDATE Items
SET StockItem = StockItem - 12
WHERE ItemId LIKE 'IT004'

--Mengupdate total stock dari IT007
UPDATE Items
SET StockItem = StockItem - 50
WHERE ItemId LIKE 'IT007'



--Misal jika ada Purchase transaction baru yang masuk
INSERT INTO PurchaseHeader VALUES('PH017','VE005','ST010','2021-07-08','2021-07-12')
INSERT INTO PurchaseDetails VALUES
	('PH017','IT002',200),
	('PH017','IT001',305)

--Mengupdate total stock item dari IT002
UPDATE Items
SET StockItem = StockItem+200
WHERE ItemId ='IT002'

--Mengupdate total stock item dari IT001
UPDATE Items
SET StockItem = StockItem+305
WHERE ItemId ='IT001'
----------------------------D


----------------------------E
--1
SELECT ItemName,ItemPrice,[ItemTotal]=SUM(PurchaseItemQTY)FROM Items i, PurchaseHeader ph, PurchaseDetails pd
WHERE i.ItemId=pd.ItemId AND PD.PurchaseId=ph.PurchaseId AND ArrivalDate IS NULL
GROUP BY ItemName,ItemPrice
HAVING SUM(PurchaseItemQTY)>100
ORDER BY [ItemTotal]DESC

--2
SELECT VendorName,[Domain Name]=RIGHT(VendorEmail,LEN(VendorEmail)-CHARINDEX('@',VendorEmail)),[Average Purchased Item] = AVG (PurchaseItemQTY)
	FROM Vendor v, PurchaseHeader ph, PurchaseDetails pd
	WHERE v.VendorId=ph.VendorId AND ph.PurchaseId=pd.PurchaseId 
	AND RIGHT(VendorEmail,LEN(VendorEmail)-CHARINDEX('@',VendorEmail)) NOT LIKE 'gmail.com'
	AND VendorAddress LIKE 'Food Street'
	GROUP BY VendorName, VendorEmail
--3
SELECT [Month]=MONTH(TransactionDate),[Minimum Quantity Sold]=MIN(TransactionItemQTY), [Maximum Quantity Sold]= MAX(TransactionItemQTY)FROM TransactionHeader th, TransactionDetails td, Items i,ItemType it
WHERE th.TransactionId=td.TransactionId AND td.ItemId=i.ItemId AND i.ItemTypeId=it.ItemTypeId AND YEAR(TransactionDate)=2019 AND it.ItemTypeName NOT IN('Food','Drink')
GROUP BY MONTH(TransactionDate)

--4
SELECT [Staff Number]=STUFF(s.StaffId,1,2,'Staff '),StaffName,[Salary]=CONCAT('Rp. ',StaffSalary), [Sales Count]=COUNT(td.TransactionId),[Average Sales Quantity]= AVG(TransactionItemQTY) FROM Staff s, TransactionHeader th, Customer c,TransactionDetails td
WHERE th.StaffId=s.StaffId and c.CustomerId=th.CustomerId AND th.TransactionId=td.TransactionId AND CustomerGender!=StaffGender AND MONTH(TransactionDate)=2
GROUP BY s.StaffId, StaffSalary,CustomerGender,StaffGender,StaffName

--5
SELECT [Customer Initial]=LEFT(CustomerName,1)+RIGHT(CustomerName,1),[Transaction Date]=FORMAT(TransactionDate,'MM dd, yyyy'),[Quantity]=TransactionItemQTY
FROM Customer c JOIN TransactionHeader th ON c.CustomerId=th.CustomerId
JOIN TransactionDetails td ON th.TransactionId=td.TransactionId,(
	SELECT [AverageQuantity]=AVG(TransactionItemQTY)FROM TransactionDetails
	)x
WHERE CustomerGender LIKE 'Female' AND TransactionItemQTY > x.AverageQuantity

--6
SELECT [ID]=LOWER(v.VendorId), VendorName,[Phone Number]=STUFF(VendorPhone,1,1,'+62')
FROM Vendor v JOIN PurchaseHeader ph ON v.VendorId=ph.VendorId
JOIN PurchaseDetails pd ON pd.PurchaseId=ph.PurchaseId,(
	SELECT [MinimumQuantity]=MIN(pd.PurchaseItemQTY)FROM 
		PurchaseDetails pd	
)x
WHERE PurchaseItemQTY>x.MinimumQuantity AND CONVERT(INT,RIGHT(pd.ItemId,3))%2!=0
GROUP BY v.VendorId,VendorPhone,VendorName,pd.ItemId,x.MinimumQuantity

--7
SELECT StaffName,VendorName,ph.PurchaseId,[Total Purchased Quantity]=SUM(PurchaseItemQTY),[Ordered Day]=CONCAT(DATEDIFF(DAY,PurchasingDate,GETDATE()),' Days ago')
FROM Staff s JOIN PurchaseHeader ph ON s.StaffId=ph.StaffId
JOIN PurchaseDetails pd on pd.PurchaseId=ph.PurchaseId 
JOIN Vendor v on v.VendorId=ph.VendorId,(
	SELECT[MaximumQuantity]=MAX(PurchaseItemQTY) FROM PurchaseDetails
	)x
WHERE DATEDIFF(DAY,PurchasingDate,ArrivalDate)<7 
GROUP BY StaffName,VendorName,ph.PurchaseId,DATEDIFF(DAY,PurchasingDate,GETDATE()),x.MaximumQuantity
HAVING SUM(PurchaseItemQTY)>x.MaximumQuantity

--8
SELECT TOP 2[Day]=DATENAME(WEEKDAY,TransactionDate),[Item Sales Amount]= COUNT(td.ItemId)
FROM TransactionHeader th JOIN TransactionDetails td ON th.TransactionId=td.TransactionId
JOIN Items i ON td.ItemId=i.ItemId
JOIN ItemType it ON I.ItemTypeId=it.ItemTypeId,(
	SELECT[AveragePriceOfItems]=AVG(ItemPrice)FROM Items i, ItemType it
	WHERE it.ItemTypeId=i.ItemTypeId
)x
WHERE ItemTypeName IN('Electronic','Gadgets')
GROUP BY DATENAME(WEEKDAY,TransactionDate),i.ItemPrice ,x.AveragePriceOfItems
HAVING i.ItemPrice<x.AveragePriceOfItems
ORDER BY COUNT(td.ItemId) ASC

--9
CREATE VIEW [Customer Statistic by Gender]
AS 
SELECT CustomerGender,[Maximum Sales]=MAX(TransactionItemQTY), [Minimum Sales]=MIN(TransactionItemQTY)FROM Customer c, TransactionHeader th, TransactionDetails td
WHERE c.CustomerId=th.CustomerId AND th.TransactionId=td.TransactionId AND TransactionItemQTY BETWEEN 10 AND 50 AND YEAR(CustomerDateOfBirth)BETWEEN 1998 AND 1999
GROUP BY CustomerGender

--10
CREATE VIEW [Item Type Statistic]
AS
SELECT [Item Type]=UPPER(ItemTypeName), [Average Price]= AVG(ItemPrice), [Number of Item Variety]=COUNT(ItemId) FROM ItemType it, Items i
WHERE it.ItemTypeId=i.ItemTypeId AND ItemTypeName LIKE 'F%' AND MinimumPurchaseItem>5
GROUP BY UPPER(ItemTypeName)
----------------------------E

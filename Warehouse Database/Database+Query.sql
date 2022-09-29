CREATE DATABASE MMPDB
GO
USE MMPDB
CREATE TABLE Staff(
	StaffID CHAR(5) PRIMARY KEY CHECK(StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(255) NOT NULL
)
CREATE TABLE CompanyInfo(
	ClientCompanyID CHAR(6) PRIMARY KEY CHECK (ClientCompanyID LIKE 'CCI[0-9][0-9][0-9]'),
	ClientCompanyName VARCHAR(255) NOT NULL,
	NPWP CHAR(20) CHECK(NPWP LIKE '[0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9]-[0-9][0-9][0-9].[0-9][0-9][0-9]')NOT NULL
)
CREATE TABLE ClientName(
	ClientID CHAR(5) PRIMARY KEY CHECK(ClientID like'CI[0-9][0-9][0-9]'),
	ClientName VARCHAR(255) NOT NULL
)
CREATE TABLE PalletInfo(
	PalletID CHAR(5) PRIMARY KEY CHECK (PalletID LIKE 'PI[0-9][0-9][0-9]'),
	PalletType VARCHAR(10) CHECK (PalletType IN ('Regular','Sealed','Freezer','Chiller'))NOT NULL,
)
CREATE TABLE LotInfo(
	LotID CHAR (5) PRIMARY KEY CHECK (LotID LIKE'LI[0-9][0-9][0-9]'),
	WarehouseName VARCHAR(255)NOT NULL
)
CREATE TABLE ItemInfo(
	ItemID CHAR (5) PRIMARY KEY CHECK(ItemID LIKE 'II[0-9][0-9][0-9]'),
	ItemName VARCHAR(255) NOT NULL
)
CREATE TABLE Item(
	PalletID CHAR(5) FOREIGN KEY REFERENCES PalletInfo(PalletID) ON UPDATE CASCADE ON DELETE CASCADE,
	ItemID CHAR(5) FOREIGN KEY REFERENCES ItemInfo(ItemID) ON UPDATE CASCADE ON DELETE CASCADE,
	Stock INT NOT NULL
	PRIMARY KEY(PalletID,ItemID)
)
CREATE TABLE Lot(
	PalletID CHAR(5) FOREIGN KEY REFERENCES PalletInfo(PalletID)ON UPDATE CASCADE ON DELETE CASCADE,
	LotID CHAR(5) FOREIGN KEY REFERENCES LotInfo(LotID)ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (PalletID,LotID)
)
CREATE TABLE TransactionHeader(
	TransactionID CHAR (5)PRIMARY KEY CHECK(TransactionID LIKE'TI[0-9][0-9][0-9]'),
	TransactionDate DATE NOT NULL,
	TransactionType CHAR (8)CHECK(TransactionType IN('INBOUND','OUTBOUND'))NOT NULL,
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID)ON UPDATE CASCADE ON DELETE CASCADE
)
CREATE TABLE TransactionDetail(
	PalletID CHAR(5),
	ItemID CHAR(5),
	Quantity INT NOT NULL,
	TransactionID CHAR (5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID)NOT NULL,
	FOREIGN KEY (PalletID, ItemID) REFERENCES Item(PalletID, ItemID)ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(PalletID,ItemID,TransactionId)
)
CREATE TABLE ClientCompany(
	ClientCompanyID CHAR (6)FOREIGN KEY REFERENCES CompanyInfo(ClientCompanyID)ON UPDATE CASCADE ON DELETE CASCADE,
	ClientID CHAR(5)FOREIGN KEY REFERENCES ClientName(ClientID)ON UPDATE CASCADE ON DELETE CASCADE,
	LotID CHAR(5)FOREIGN KEY REFERENCES LotInfo(LotID)ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(ClientCompanyID)
)
INSERT INTO CompanyInfo VALUES
('CCI001','SidoKeluar','08.178.554.2-123.321'),
('CCI002','Saripalsu','07.162.235.1-209.170'),
('CCI003','Sisimaju','21.313.892.7-621.912'),
('CCI004','Sasamundur','76.921.876.5-129.931'),
('CCI005','Orang Muda','12.121.123.2-119.807')

INSERT INTO ClientName VALUES
('CI001','Indra Daniswiri'),
('CI002','Lemina Tewi'),
('CI003','Ria Richoco'),
('CI004','Tukul Perairan'),
('CI005','Tutu Matiti')

INSERT INTO LotInfo VALUES
('LI001','MMP Jakarta'),
('LI002','MMP Jakarta'),
('LI003','MMP Jakarta'),
('LI004','MMP Cikarang'),
('LI005','MMP Cilengsi'),
('LI006','MMP Bogor'),
('LI007','MMP Depok'),
('LI008','MMP Surabaya')

INSERT INTO ClientCompany VALUES
('CCI001','CI001','LI001'),
('CCI002','CI002','LI002'),
('CCI003','CI003','LI003'),
('CCI004','CI004','LI004'),
('CCI005','CI005','LI005')

INSERT INTO Staff VALUES
('ST001','Budi Suwaringsih'),
('ST002','Siti Semiriwih'),
('ST003','Agus Sudarsono'),
('ST005','Sani Susanto'),
('ST004','Ivan Gunalos')

INSERT INTO PalletInfo VALUES
('PI001','Regular'),
('PI002','Sealed'),
('PI003','Freezer'),
('PI004','Chiller'),
('PI005','Regular'),
('PI006','Regular'),
('PI007','Sealed'),
('PI008','Freezer'),
('PI009','Chiller'),
('PI010','Regular'),
('PI011','Regular'),
('PI012','Sealed'),
('PI013','Freezer'),
('PI014','Chiller'),
('PI015','Regular'),
('PI016','Regular'),
('PI017','Sealed'),
('PI018','Freezer'),
('PI019','Chiller'),
('PI020','Regular')

INSERT INTO Lot VALUES
('PI001','LI001'),
('PI002','LI001'),
('PI003','LI001'),
('PI004','LI001'),
('PI005','LI002'),
('PI006','LI002'),
('PI007','LI002'),
('PI008','LI002'),
('PI009','LI003'),
('PI010','LI003'),
('PI011','LI003'),
('PI012','LI003'),
('PI013','LI004'),
('PI014','LI004'),
('PI015','LI004'),
('PI016','LI004'),
('PI017','LI005'),
('PI018','LI005'),
('PI019','LI005'),
('PI020','LI005')

INSERT INTO ItemInfo VALUES
('II001','Orea Choco Cookies'),
('II002','Sosis not So Nice'),
('II003','Larutan Cap Kaki Ibu'),
('II004','Bolu Goreng Tepung'),
('II005','Bika Medan'),
('II006','Cuka Tukang Baso'),
('II007','Celana Cool Pants'),
('II008','Masker Stimuli'),
('II009','Kantong Ajaib Orang Muda'),
('II010','Pedang Mainan Stemolo'),
('II011','A Week Made Pulpy Jeruk'),
('II012','Kamera Mainan Logitektek'),
('II013','Mie Instan 10 Jam Kenyang'),
('II014','Fiestiti Turkey Nugget'),
('II015','Kacamata Kuda Lumpingsi'),
('II016','Air Gunung Fujiternak'),
('II017','Mouse Gaming Kacangan'),
('II018','Keyboard MediaTV'),
('II019','Handphone Nokibaba'),
('II020','Speaker LGB Lightswork')


INSERT INTO Item VALUES
('PI001','II001',200),
('PI002','II002',150),
('PI003','II003',220),
('PI004','II004',110),
('PI005','II005',125),
('PI006','II006',200),
('PI007','II007',150),
('PI008','II008',220),
('PI009','II009',110),
('PI010','II010',125),
('PI011','II011',200),
('PI012','II012',150),
('PI013','II013',220),
('PI014','II014',110),
('PI015','II015',125),
('PI016','II016',200),
('PI017','II017',150),
('PI018','II018',220),
('PI019','II019',110),
('PI020','II020',125)

INSERT INTO TransactionHeader VALUES
('TI001','2021-07-21','INBOUND','ST004'),
('TI002','2021-09-16','OUTBOUND','ST005'),
('TI003','2021-06-09','INBOUND','ST003'),
('TI004','2021-10-25','OUTBOUND','ST002'),
('TI005','2021-05-28','INBOUND','ST003'),
('TI006','2021-10-06','OUTBOUND','ST001'),
('TI007','2021-07-20','INBOUND','ST002'),
('TI008','2021-09-14','OUTBOUND','ST004'),
('TI009','2021-09-22','INBOUND','ST005'),
('TI010','2021-12-11','OUTBOUND','ST001')

INSERT INTO TransactionDetail VALUES
('PI001','II001',230,'TI001'),
('PI002','II002',175,'TI001'),
('PI003','II003',270,'TI001'),
('PI004','II004',260,'TI001'),
('PI001','II001',30,'TI002'),
('PI002','II002',25,'TI002'),
('PI003','II003',50,'TI002'),
('PI004','II004',150,'TI002'),
('PI005','II005',1027,'TI003'),
('PI006','II006',865,'TI003'),
('PI007','II007',585,'TI003'),
('PI008','II008',900,'TI003'),
('PI005','II005',902,'TI004'),
('PI006','II006',665,'TI004'),
('PI007','II007',435,'TI004'),
('PI008','II008',680,'TI004'),
('PI009','II009',375,'TI005'),
('PI010','II010',250,'TI005'),
('PI011','II011',550,'TI005'),
('PI012','II012',650,'TI005'),
('PI009','II009',265,'TI006'),
('PI010','II010',125,'TI006'),
('PI011','II011',350,'TI006'),
('PI012','II012',500,'TI006'),
('PI013','II013',530,'TI007'),
('PI014','II014',780,'TI007'),
('PI015','II015',630,'TI007'),
('PI016','II016',1278,'TI007'),
('PI013','II013',310,'TI008'),
('PI014','II014',670,'TI008'),
('PI015','II015',505,'TI008'),
('PI016','II016',1078,'TI008'),
('PI017','II017',300,'TI009'),
('PI018','II018',540,'TI009'),
('PI019','II019',1024,'TI009'),
('PI020','II020',789,'TI009'),
('PI017','II017',150,'TI010'),
('PI018','II018',320,'TI010'),
('PI019','II019',914,'TI010'),
('PI020','II020',664,'TI010')

--1 Tunjukkan semua info client yang dalam MMP
SELECT * FROM ClientCompany

--2 Tunjukkan semua transaksi yang ada
SELECT * FROM TransactionHeader

--3 Tunjukkan semua item yang ada dalam MMP
SELECT * FROM ItemInfo

--4 Tunjukkan semua lot yang ada dalam MMP
SELECT * FROM LotInfo

--5 Tunjukkan staff yang pernah menghandle Pallet PI001 berserta tanggal transaksi dan jenis transaksi
SELECT PalletID,StaffName,TransactionType,TransactionDate
FROM Staff S JOIN TransactionHeader TH ON S.StaffID=TH.StaffID
JOIN TransactionDetail TD ON TD.TransactionID=TH.TransactionID
WHERE PalletID='PI001'

--6 Tunjukkan semua item yang berada pada Lot LI001
SELECT LotID,L.PalletID,PalletType,ItemName
FROM Lot L JOIN PalletInfo PALI ON L.PalletID=PALI.PalletID 
JOIN Item I ON I.PalletID=L.PalletID
JOIN ItemInfo II  ON I.ItemID=II.ItemID 
WHERE LotID='LI001'

--7 List semua item punya company CCI002
SELECT ItemName,ClientCompanyName,CI.ClientCompanyID
FROM CompanyInfo CI JOIN ClientCompany CC ON CI.ClientCompanyID=CC.ClientCompanyID
JOIN LotInfo LI ON CC.LotID=LI.LotID
JOIN Lot L ON L.LotID=LI.LotID
JOIN PalletInfo PALI ON L.PalletID=PALI.PalletID 
JOIN Item I ON I.PalletID=L.PalletID
JOIN ItemInfo II  ON I.ItemID=II.ItemID 
WHERE CI.ClientCompanyID='CCI002'

--8 Tunjukkan nama company, nama staff, dan tanggal transaksi dari semua transaksi outbound sorting dari tanggal terbaru
SELECT DISTINCT ClientCompanyName, StaffName, TransactionDate
FROM CompanyInfo CI JOIN ClientCompany CC ON CI.ClientCompanyID=CC.ClientCompanyID
JOIN LotInfo LI ON CC.LotID=LI.LotID
JOIN Lot L ON L.LotID=LI.LotID	
JOIN PalletInfo PALI ON L.PalletID=PALI.PalletID
JOIN Item I ON I.PalletID=PALI.PalletID
JOIN TransactionDetail TD ON I.ItemID=TD.ItemID AND I.PalletID=TD.PalletID
JOIN TransactionHeader TH ON TH.TransactionID=TD.TransactionID
JOIN Staff S ON S.StaffID=TH.StaffID
WHERE TransactionType LIKE 'OUTBOUND'
ORDER BY TransactionDate DESC

--9 Tunjukkan nama item, stock, dan company pemilik dari semua item yang disimpan di pallet reguler 
SELECT DISTINCT ItemName,Stock,ClientCompanyName
FROM CompanyInfo CI JOIN ClientCompany CC ON CI.ClientCompanyID=CC.ClientCompanyID
JOIN LotInfo LI ON CC.LotID=LI.LotID
JOIN Lot L ON L.LotID=LI.LotID
JOIN PalletInfo PALI ON L.PalletID=PALI.PalletID
JOIN Item I ON I.PalletID=PALI.PalletID
JOIN ItemInfo II  ON II.ItemID=I.ItemID

--10 List semua id pallet yang memiliki tipe Freezer
SELECT *
FROM PalletInfo
WHERE PalletType LIKE 'Freezer'
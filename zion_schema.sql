create database zionRecruit
GO
use zionRecruit
GO

CREATE TABLE [User](
	UserId INT NOT NULL PRIMARY KEY,
	UserName VARCHAR(50) NOT NULL,
	Email VARCHAR(30) NULL,
	[Password] VARCHAR(50) NOT NULL,
	MobileNumber VARCHAR(20) NULL,
	Qualification VARCHAR(30) NOT NULL,
	IsCvUploaded BIT NOT NULL
)
GO

CREATE TABLE Company(
	CompanyId INT NOT NULL PRIMARY KEY,
	CompanyName VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NULL,
	[Password] VARCHAR(50) NOT NULL,
	Website VARCHAR(50) NULL,
	MobileNumber VARCHAR(20) NULL,
	CurrentStatus BIT NOT NULL
)
GO

CREATE TABLE JobDetail(
	JobId INT NOT NULL PRIMARY KEY,
	Title VARCHAR(50) NOT NULL,
	CompanyId INT NOT NULL FOREIGN KEY REFERENCES Company(CompanyId) ON DELETE CASCADE ON UPDATE CASCADE,
	[Location] VARCHAR(20) NULL,
	RequiredQualification VARCHAR(30) NOT NULL,
	RequiredExperience VARCHAR(30) NOT NULL,
	ContractTimeSpan VARCHAR(30) NULL,
	Skills VARCHAR(50) NULL,
	StartingDate date NULL
)
GO

CREATE TABLE UserAppliedDetail(
	JobId INT NOT NULL FOREIGN KEY REFERENCES JobDetail(JobId) ON DELETE CASCADE ON UPDATE CASCADE,
	UserId INT NOT NULL FOREIGN KEY REFERENCES [User](UserId) ON DELETE CASCADE ON UPDATE CASCADE,
	AppliedDate date NULL,
	PRIMARY KEY (JobId,UserId)
)
GO

CREATE TABLE [Admin](
	AdminId INT NOT NULL PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	Email VARCHAR(30) NULL,
	[Password] VARCHAR(50) NOT NULL,
	MobileNumber VARCHAR(20) NULL
)
GO

CREATE TABLE Complaints(
	ComplaintId INT NOT NULL PRIMARY KEY,
	UserId INT NOT NULL FOREIGN KEY REFERENCES [User](UserId) ON DELETE CASCADE ON UPDATE CASCADE
)
GO

CREATE TABLE Ratings(
	UserId INT NOT NULL FOREIGN KEY REFERENCES [User](UserId) ON DELETE CASCADE ON UPDATE CASCADE,
	CompanyId INT NOT NULL FOREIGN KEY REFERENCES Company(companyId) ON DELETE CASCADE ON UPDATE CASCADE,
	Stars INT NOT NULL,
	Review VARCHAR(100) NULL,
	PRIMARY KEY (UserId, CompanyId)
)
GO

CREATE TABLE CompanyChats(
	SenderId INT NOT NULL FOREIGN KEY REFERENCES Company(companyId) ON DELETE CASCADE ON UPDATE CASCADE,
	SendToId INT NOT NULL FOREIGN KEY REFERENCES [User](UserId) ON DELETE CASCADE ON UPDATE CASCADE,
	[Message] VARCHAR(100) NULL,
	[Time] time NOT NULL,
	PRIMARY KEY (SenderId, SendToId)
)
GO

CREATE TABLE UserChats(
	SenderId INT NOT NULL FOREIGN KEY REFERENCES [User](UserId) ON DELETE CASCADE ON UPDATE CASCADE,
	SendToId INT NOT NULL FOREIGN KEY REFERENCES Company(companyId) ON DELETE CASCADE ON UPDATE CASCADE,
	[Message] VARCHAR(100) NULL,
	[Time] time NOT NULL,
	PRIMARY KEY (SenderId, SendToId)
)

CREATE TABLE [validation](
Email  varchar(30) primary key,
[Password] nvarchar(20) NULL,
Usertype char 
)
GO

INSERT INTO [USER]
VALUES
(1, 'Usama Yousaf', 'usamayousaf@gmail.com','123456','0333-1324356','BSCS',0),
(2,'Hasnat Raza','hasnatraza@gmail.com','123567','0333-1434543','BSCS',1),
(3,'Isha Amir','ishaamir@gmail.com','567123','0331-4354654','BSCS',1)
GO

INSERT INTO Company
VALUES
(1,'Educative','info@educative.com','12345678','www.educative.com','0337-1653567',0),
(2,'TechHub','info@techhub.com','12344','www.techhub.com','0333-7898567',1),
(3,'Tinypiece','info@tinypiece.com','1234321','www.tinypiece.com','0323-5645456',1)
GO

INSERT INTO JobDetail
VALUES
(1,'Software Engineer',1,'Lahore','BSCS','3years','3years','Git,Python,PHP','5-22-2021'),
(2,'Project Manager',2,'Islamabad','MSCS','5years','5years','Git,Python,Managemnet','6-1-2021'),
(3,'Intern',3,'Lahore','BSCS','Fresh','3months','OOP,Algorithms','6-5-2021')
GO

INSERT INTO UserAppliedDetail
VALUES
(3,1,'5-25-2021'),
(1,2,'5-15-2021')
GO

INSERT INTO [Admin]
VALUES
(1,'Usama Shabir','usamashabir@gmail.com','123@123','0337-1978678')
GO

INSERT INTO Complaints
VALUES
(1,1)
GO

INSERT INTO Ratings
VALUES
(1,3,5,'Great professional and learning enviornment for work')
GO

INSERT INTO CompanyChats
VALUES
(1,2,NULL,'12:23:04')
GO

INSERT INTO UserChats
VALUES
(2,1,NULL,'12:24:09')

GO
SELECT *FROM [User]
SELECT *FROM Company
SELECT *FROM JobDetail
SELECT *FROM UserAppliedDetail
SELECT *FROM [Admin]
SELECT *FROM Complaints
SELECT *FROM Ratings
SELECT *FROM CompanyChats
SELECT *FROM UserChats


-----------------------------------------------------------------------------------------------------------
----------------------------------Stored Procedures for Login and Signup-----------------------------------


GO
--Login
drop procedure if exists dbo.[login]
go
create procedure [login]
 @email varchar(40),
 @password varchar(15)
 as
 begin 
  if(@email in (select Users.Email  from [Users]) )
  begin
  if(@password in (select [Users].Password from [Users] where Users.Email = @email))
  begin
  Select* from Users where Users.Password=@password and Users.Email=@email
  end 
  end
  end
  go
  
 
--Signup
drop procedure if exists dbo.signup
go
create procedure signup
 @firstname varchar(15),
 @lastname varchar(15),
 @cnic varchar(15),
 @email varchar(40),
 @password varchar(15),
 @status int output
 as
 begin 
  if(@email not in (select Users.Email  from [Users]) )
  begin
  if(@cnic not in (select Users.CNIC from [Users] where Users.CNIC = @cnic))
  begin
  set @status =1
  Insert Into Users
  Values
  (@firstname,@lastname,@cnic,@email,@password)
  end
  else
  begin 
  set @status =0
  end 
  end
  else
  begin
  set @status =0
  end
  end
  go


USE [$(database)]
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'$(user)') DROP USER [$(user)] 
CREATE USER [$(user)] FOR LOGIN [$(user)]
USE [$(database)]
EXEC sp_addrolemember N'db_datawriter', N'$(user)'
EXEC sp_addrolemember N'db_datareader', N'$(user)'
GO

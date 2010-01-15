USE [master]
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'$(user)')
DROP LOGIN [$(user)]
CREATE LOGIN [$(user)] WITH PASSWORD='$(password)', DEFAULT_DATABASE=[$(database)], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GRANT CONNECT SQL TO [$(user)]
GO

USE [$(database)]
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'$(user)')
DROP USER [$(user)]
CREATE USER [$(user)] FOR LOGIN [$(user)] WITH DEFAULT_SCHEMA=[$(database)]
EXEC sp_addrolemember N'db_datareader', N'$(user)'
EXEC sp_addrolemember N'db_datawriter', N'$(user)'
GO

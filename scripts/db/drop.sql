USE [master]
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'$(database)')
DROP DATABASE [$(database)]
GO

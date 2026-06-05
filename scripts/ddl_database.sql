/*
==============================================================================================================================
This SQL Query drops the database named DataWarehouse and recreates it and build bronze, silver, gold schemas inside it.
CAUTION:	Becareful before executing this query and make sure you have a backup for your database DataWarehouse cause it will
be deleted permanently.
==============================================================================================================================
*/
USE master; -- Switchs to master Database
GO
IF DB_ID('DataWarehouse') IS NOT NULL --Checks if DataWarehouse Database already exists
BEGIN
	DROP DATABASE DataWarehouse; -- Drops the Database DataWarehouse
END
GO

CREATE DATABASE DataWarehouse; -- Creates Database DataWarehouse
GO

USE DataWarehouse; -- Switchs to DataWarehouse Database
GO

CREATE SCHEMA bronze; -- Creates The Schema bronze
GO

CREATE SCHEMA silver; -- Creates The Schema silver
GO

CREATE SCHEMA gold; -- Creates The Schema gold


/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'OlistDWH' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will drop the entire 'OlistDWH' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'OlistDWH' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'OlistDWH')
BEGIN
    ALTER DATABASE OlistDWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE OlistDWH;
END;
GO

-- Create the 'OlistDWH' database
CREATE DATABASE OlistDWH;
GO

USE OlistDWH;
GO

-- Create Schemas for Medallion Architecture
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

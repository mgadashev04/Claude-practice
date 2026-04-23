/*
=======================================================
Create Database
=======================================================
Script Purpose:
    This script creates a new database named 'EcomPractice' after checking if it already exists.
    If the database exists, it is dropped and recreated. 
WARNING:
    Running this script will drop the entire 'EcomPractice' database if it exists.
    All data in the database will be permanently deleted. Procees with caution
    and ensure you have proper backups before running this script
*/

USE master;
GO

  -- Drop and recreate 'EcomPractice' Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'EcomPractice')
BEGIN 
	ALTER DATABASE EcomPractice SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE EcomPractice;
	END;
	GO
  -- Create the Database
	CREATE DATABASE EcomPractice;
	GO
	USE EcomPractice
	GO


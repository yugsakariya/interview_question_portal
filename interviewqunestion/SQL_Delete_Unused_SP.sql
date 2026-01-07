-- ===========================================
-- SQL Script to Delete Unused Stored Procedures
-- Run this in SQL Server Management Studio
-- ===========================================

-- 1. Delete sp_AdminLogin (not used - login uses sp_GetUserByEmail with BCrypt)
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_AdminLogin')
BEGIN
    DROP PROCEDURE [dbo].[sp_AdminLogin];
    PRINT 'Dropped sp_AdminLogin';
END

-- 2. Delete sp_Login (not used - login uses sp_GetUserByEmail with BCrypt)
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_Login')
BEGIN
    DROP PROCEDURE [dbo].[sp_Login];
    PRINT 'Dropped sp_Login';
END

-- 3. Delete sp_RegisterUser (not used - registration uses sp_UserRegister instead)
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_RegisterUser')
BEGIN
    DROP PROCEDURE [dbo].[sp_RegisterUser];
    PRINT 'Dropped sp_RegisterUser';
END

-- 4. Delete sp_GetActiveTests_ForUser (not used - code uses sp_GetTestsWithStatus_ForUser)
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetActiveTests_ForUser')
BEGIN
    DROP PROCEDURE [dbo].[sp_GetActiveTests_ForUser];
    PRINT 'Dropped sp_GetActiveTests_ForUser';
END

-- 5. Delete sp_GetAll_Admins (not used anywhere in the codebase)
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetAll_Admins')
BEGIN
    DROP PROCEDURE [dbo].[sp_GetAll_Admins];
    PRINT 'Dropped sp_GetAll_Admins';
END

-- 6. Delete sp_GetAll_Users (not used anywhere in the codebase)
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetAll_Users')
BEGIN
    DROP PROCEDURE [dbo].[sp_GetAll_Users];
    PRINT 'Dropped sp_GetAll_Users';
END

-- 7. Delete sp_Delete_User (not used anywhere in the codebase)
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_Delete_User')
BEGIN
    DROP PROCEDURE [dbo].[sp_Delete_User];
    PRINT 'Dropped sp_Delete_User';
END

PRINT '';
PRINT '===========================================';
PRINT 'Cleanup complete! 7 unused SPs have been removed.';
PRINT '===========================================';

-- ===========================================
-- Stored Procedure: sp_UpdateUserPassword
-- Updates user password by Email (for Forgot Password)
-- Run this in SQL Server Management Studio
-- ===========================================

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_UpdateUserPassword')
    DROP PROCEDURE sp_UpdateUserPassword;
GO

CREATE PROCEDURE [dbo].[sp_UpdateUserPassword]
    @p_Email NVARCHAR(255),
    @p_NewPassword NVARCHAR(256)
AS
BEGIN
    -- Update password using email (User_EmailID is the column name in Users table)
    UPDATE Users 
    SET User_Password = @p_NewPassword 
    WHERE User_EmailID = @p_Email;
    
    -- Delete OTP after password reset
    DELETE FROM PasswordResetOTP WHERE Email = @p_Email;
END
GO

PRINT 'Created sp_UpdateUserPassword procedure';

-- ===========================================
-- Also create sp_UpdateUserPasswordByID for ChangePassword feature
-- ===========================================

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_UpdateUserPasswordByID')
    DROP PROCEDURE sp_UpdateUserPasswordByID;
GO

CREATE PROCEDURE [dbo].[sp_UpdateUserPasswordByID]
    @p_User_ID INT,
    @p_NewPassword NVARCHAR(256)
AS
BEGIN
    UPDATE Users 
    SET User_Password = @p_NewPassword 
    WHERE User_ID = @p_User_ID;
END
GO

PRINT 'Created sp_UpdateUserPasswordByID procedure';

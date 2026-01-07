-- ===========================================
-- SQL Script for Email Verification during Registration
-- Run this in SQL Server Management Studio
-- ===========================================

-- 1. Create EmailVerificationOTP table (similar to PasswordResetOTP)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='EmailVerificationOTP' AND xtype='U')
BEGIN
    CREATE TABLE EmailVerificationOTP (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Email NVARCHAR(255) NOT NULL,
        OTP NVARCHAR(6) NOT NULL,
        ExpiryTime DATETIME NOT NULL,
        CreatedAt DATETIME DEFAULT GETDATE()
    );
    PRINT 'Created EmailVerificationOTP table';
END
GO

-- 2. Create stored procedure to store verification OTP
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_StoreEmailVerificationOTP')
    DROP PROCEDURE sp_StoreEmailVerificationOTP;
GO

CREATE PROCEDURE sp_StoreEmailVerificationOTP
    @p_Email NVARCHAR(255),
    @p_OTP NVARCHAR(6),
    @p_ExpiryTime DATETIME
AS
BEGIN
    -- Delete any existing OTP for this email
    DELETE FROM EmailVerificationOTP WHERE Email = @p_Email;
    
    -- Insert new OTP
    INSERT INTO EmailVerificationOTP (Email, OTP, ExpiryTime, CreatedAt)
    VALUES (@p_Email, @p_OTP, @p_ExpiryTime, GETDATE());
    
    -- Return success
    SELECT 1 AS Success;
END
GO
PRINT 'Created sp_StoreEmailVerificationOTP procedure';

-- 3. Create stored procedure to verify OTP
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_VerifyEmailOTP')
    DROP PROCEDURE sp_VerifyEmailOTP;
GO

CREATE PROCEDURE sp_VerifyEmailOTP
    @p_Email NVARCHAR(255),
    @p_OTP NVARCHAR(6)
AS
BEGIN
    SELECT * FROM EmailVerificationOTP 
    WHERE Email = @p_Email 
    AND OTP = @p_OTP 
    AND ExpiryTime > GETDATE();
END
GO
PRINT 'Created sp_VerifyEmailOTP procedure';

-- 4. Create stored procedure to delete OTP after successful verification
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_DeleteEmailVerificationOTP')
    DROP PROCEDURE sp_DeleteEmailVerificationOTP;
GO

CREATE PROCEDURE sp_DeleteEmailVerificationOTP
    @p_Email NVARCHAR(255)
AS
BEGIN
    DELETE FROM EmailVerificationOTP WHERE Email = @p_Email;
END
GO
PRINT 'Created sp_DeleteEmailVerificationOTP procedure';

-- ===========================================
-- DONE! Run this script before testing the registration
-- ===========================================

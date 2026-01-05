-- ===========================================
-- SQL Script for Password Reset with OTP
-- Run this in SQL Server Management Studio
-- ===========================================

-- 1. Create AppSettings table for SMTP configuration
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AppSettings' AND xtype='U')
BEGIN
    CREATE TABLE AppSettings (
        SettingKey NVARCHAR(50) PRIMARY KEY,
        SettingValue NVARCHAR(255)
    );
    PRINT 'Created AppSettings table';
END

-- 2. Insert SMTP settings (REPLACE WITH YOUR ACTUAL VALUES)
-- Delete existing if any
DELETE FROM AppSettings WHERE SettingKey IN ('SmtpHost', 'SmtpPort', 'SmtpEmail', 'SmtpPassword');

-- Insert new values - REPLACE THESE WITH YOUR CREDENTIALS
INSERT INTO AppSettings (SettingKey, SettingValue) VALUES ('SmtpHost', 'smtp.gmail.com');
INSERT INTO AppSettings (SettingKey, SettingValue) VALUES ('SmtpPort', '587');
INSERT INTO AppSettings (SettingKey, SettingValue) VALUES ('SmtpEmail', 'YOUR_GMAIL_HERE@gmail.com');
INSERT INTO AppSettings (SettingKey, SettingValue) VALUES ('SmtpPassword', 'YOUR_APP_PASSWORD_HERE');
PRINT 'Inserted SMTP settings - REMEMBER TO UPDATE WITH YOUR ACTUAL CREDENTIALS';

-- 3. Create PasswordResetOTP table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='PasswordResetOTP' AND xtype='U')
BEGIN
    CREATE TABLE PasswordResetOTP (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Email NVARCHAR(255) NOT NULL,
        OTP NVARCHAR(6) NOT NULL,
        ExpiryTime DATETIME NOT NULL,
        CreatedAt DATETIME DEFAULT GETDATE()
    );
    PRINT 'Created PasswordResetOTP table';
END

-- 4. Create stored procedure to get app setting
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetAppSetting')
    DROP PROCEDURE sp_GetAppSetting;
GO

CREATE PROCEDURE sp_GetAppSetting
    @p_Key NVARCHAR(50)
AS
BEGIN
    SELECT SettingValue FROM AppSettings WHERE SettingKey = @p_Key;
END
GO
PRINT 'Created sp_GetAppSetting procedure';

-- 5. Create stored procedure to store OTP
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_StorePasswordResetOTP')
    DROP PROCEDURE sp_StorePasswordResetOTP;
GO

CREATE PROCEDURE sp_StorePasswordResetOTP
    @p_Email NVARCHAR(255),
    @p_OTP NVARCHAR(6),
    @p_ExpiryTime DATETIME
AS
BEGIN
    -- Delete any existing OTP for this email
    DELETE FROM PasswordResetOTP WHERE Email = @p_Email;
    
    -- Insert new OTP
    INSERT INTO PasswordResetOTP (Email, OTP, ExpiryTime, CreatedAt)
    VALUES (@p_Email, @p_OTP, @p_ExpiryTime, GETDATE());
END
GO
PRINT 'Created sp_StorePasswordResetOTP procedure';

-- 6. Create stored procedure to verify OTP
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_VerifyPasswordResetOTP')
    DROP PROCEDURE sp_VerifyPasswordResetOTP;
GO

CREATE PROCEDURE sp_VerifyPasswordResetOTP
    @p_Email NVARCHAR(255),
    @p_OTP NVARCHAR(6)
AS
BEGIN
    SELECT * FROM PasswordResetOTP 
    WHERE Email = @p_Email 
    AND OTP = @p_OTP 
    AND ExpiryTime > GETDATE();
END
GO
PRINT 'Created sp_VerifyPasswordResetOTP procedure';

-- 7. Create stored procedure to update user password
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_UpdateUserPassword')
    DROP PROCEDURE sp_UpdateUserPassword;
GO

CREATE PROCEDURE sp_UpdateUserPassword
    @p_Email NVARCHAR(255),
    @p_NewPassword NVARCHAR(255)
AS
BEGIN
    UPDATE Users SET User_Password = @p_NewPassword WHERE User_Email = @p_Email;
    DELETE FROM PasswordResetOTP WHERE Email = @p_Email;
END
GO
PRINT 'Created sp_UpdateUserPassword procedure';

-- ===========================================
-- DONE! Remember to update the SMTP settings
-- with your actual Gmail and App Password
-- ===========================================

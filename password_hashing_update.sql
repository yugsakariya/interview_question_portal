-- =====================================================
-- PASSWORD HASHING IMPLEMENTATION
-- Run this script in SQL Server Management Studio
-- =====================================================

-- Step 1: Increase password column size to accommodate BCrypt hashes
ALTER TABLE Users ALTER COLUMN User_Password NVARCHAR(256) NOT NULL;
GO

-- Step 2: Create stored procedure to get user by email (for login - returns any user regardless of role)
IF OBJECT_ID('sp_GetUserByEmail', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetUserByEmail;
GO

CREATE PROCEDURE sp_GetUserByEmail
    @p_Email NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Users WHERE User_EmailID = @p_Email;
END
GO

-- Step 3: Create stored procedure to check if user exists (for registration)
IF OBJECT_ID('sp_Check_User_Exists', 'P') IS NOT NULL
    DROP PROCEDURE sp_Check_User_Exists;
GO

CREATE PROCEDURE sp_Check_User_Exists
    @p_Email NVARCHAR(100)
AS
BEGIN
    SELECT User_ID FROM Users WHERE User_EmailID = @p_Email;
END
GO

-- Step 4: Create stored procedure for user registration
IF OBJECT_ID('sp_UserRegister', 'P') IS NOT NULL
    DROP PROCEDURE sp_UserRegister;
GO

CREATE PROCEDURE sp_UserRegister
    @p_FirstName NVARCHAR(50),
    @p_LastName NVARCHAR(50),
    @p_EmailID NVARCHAR(100),
    @p_Password NVARCHAR(256)
AS
BEGIN
    INSERT INTO Users (User_FirstName, User_LastName, User_EmailID, User_Password, User_Role)
    VALUES (@p_FirstName, @p_LastName, @p_EmailID, @p_Password, 'User');
    
    SELECT * FROM Users WHERE User_ID = SCOPE_IDENTITY();
END
GO

-- Step 5: Update existing passwords to BCrypt hashed versions
-- These are pre-computed BCrypt hashes for the existing passwords:
-- admin@123 -> $2a$11$rBLDn4pZyX.U0/mPIY7okuoqZvvXm7GWb5P0J5p0P5QW1xv.uWvYu
-- test@12345 -> $2a$11$8oYjFvBJ2k4EJfxzCn0h9.HVTxWEcvVEP7wZQu7g9GgQA1D5g.O6G

UPDATE Users 
SET User_Password = '$2a$11$rBLDn4pZyX.U0/mPIY7okuoqZvvXm7GWb5P0J5p0P5QW1xv.uWvYu'
WHERE User_EmailID = 'admin@gmail.com';

UPDATE Users 
SET User_Password = '$2a$11$8oYjFvBJ2k4EJfxzCn0h9.HVTxWEcvVEP7wZQu7g9GgQA1D5g.O6G'
WHERE User_EmailID = 'testuser@gmail.com';

GO

PRINT 'Password hashing implementation complete!';
PRINT 'Existing users can login with: admin@123 (Admin) and test@12345 (User)';

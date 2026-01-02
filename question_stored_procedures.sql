USE [InterviewPortal]
GO

-- =============================================
-- MISSING STORED PROCEDURES FOR QUESTIONS MANAGEMENT
-- Run this script on your InterviewPortal database
-- Date: 01-01-2026
-- =============================================

-- 1. sp_Insert_Question - Insert a new question
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_Insert_Question')
    DROP PROCEDURE sp_Insert_Question
GO

CREATE PROCEDURE [dbo].[sp_Insert_Question]
    @p_Category_ID INT,
    @p_Company_ID INT,
    @p_Question_Text NVARCHAR(255),
    @p_OptionA NVARCHAR(255),
    @p_OptionB NVARCHAR(255),
    @p_OptionC NVARCHAR(255),
    @p_OptionD NVARCHAR(255),
    @p_CorrectOption CHAR(1)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Questions (Category_ID, Company_ID, Question_Text, OptionA, OptionB, OptionC, OptionD, CorrectOption)
    VALUES (@p_Category_ID, @p_Company_ID, @p_Question_Text, @p_OptionA, @p_OptionB, @p_OptionC, @p_OptionD, @p_CorrectOption);
    
    SELECT SCOPE_IDENTITY() AS Question_ID;
END
GO

-- 2. sp_Update_Question - Update an existing question
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_Update_Question')
    DROP PROCEDURE sp_Update_Question
GO

CREATE PROCEDURE [dbo].[sp_Update_Question]
    @p_Question_ID INT,
    @p_Category_ID INT,
    @p_Company_ID INT,
    @p_Question_Text NVARCHAR(255),
    @p_OptionA NVARCHAR(255),
    @p_OptionB NVARCHAR(255),
    @p_OptionC NVARCHAR(255),
    @p_OptionD NVARCHAR(255),
    @p_CorrectOption CHAR(1)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Questions
    SET Category_ID = @p_Category_ID,
        Company_ID = @p_Company_ID,
        Question_Text = @p_Question_Text,
        OptionA = @p_OptionA,
        OptionB = @p_OptionB,
        OptionC = @p_OptionC,
        OptionD = @p_OptionD,
        CorrectOption = @p_CorrectOption
    WHERE Question_ID = @p_Question_ID;
END
GO

-- 3. sp_Delete_Question - Delete a question
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_Delete_Question')
    DROP PROCEDURE sp_Delete_Question
GO

CREATE PROCEDURE [dbo].[sp_Delete_Question]
    @p_Question_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    -- First delete related records in Test_Questions
    DELETE FROM Test_Questions WHERE Question_ID = @p_Question_ID;
    
    -- Then delete related bookmarks
    DELETE FROM Bookmarks WHERE Question_ID = @p_Question_ID;
    
    -- Finally delete the question
    DELETE FROM Questions WHERE Question_ID = @p_Question_ID;
END
GO

-- 4. sp_GetByID_Question - Get a question by its ID
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetByID_Question')
    DROP PROCEDURE sp_GetByID_Question
GO

CREATE PROCEDURE [dbo].[sp_GetByID_Question]
    @p_Question_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT q.Question_ID, 
           q.Category_ID, 
           q.Company_ID, 
           q.Question_Text, 
           q.OptionA, 
           q.OptionB, 
           q.OptionC, 
           q.OptionD, 
           q.CorrectOption,
           c.Category_Name,
           co.Company_Name
    FROM Questions q
    INNER JOIN Categories c ON q.Category_ID = c.Category_ID
    INNER JOIN Companies co ON q.Company_ID = co.Company_ID
    WHERE q.Question_ID = @p_Question_ID;
END
GO

PRINT '==========================================='
PRINT 'All 4 stored procedures created successfully!'
PRINT '  - sp_Insert_Question'
PRINT '  - sp_Update_Question'
PRINT '  - sp_Delete_Question'
PRINT '  - sp_GetByID_Question'
PRINT '==========================================='

-- =============================================
-- USER SIDE STORED PROCEDURES
-- Run this script in SQL Server Management Studio
-- =============================================

USE [InterviewPortal]
GO

-- =============================================
-- 1. Get Test Results for a specific User
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetTestResults_ByUserID')
    DROP PROCEDURE sp_GetTestResults_ByUserID
GO

CREATE PROCEDURE [dbo].[sp_GetTestResults_ByUserID]
    @p_User_ID INT
AS
BEGIN
    SELECT r.Result_ID, 
           t.Test_Name, 
           r.Result_Score,
           r.Total_Questions,
           r.CorrectAnswers,
           r.WrongAnswers
    FROM TestResults r
    INNER JOIN Tests t ON r.Test_ID = t.Test_ID
    WHERE r.User_ID = @p_User_ID
    ORDER BY r.Result_ID DESC;
END
GO

-- =============================================
-- 2. Get Bookmarks for a specific User
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetBookmarks_ByUserID')
    DROP PROCEDURE sp_GetBookmarks_ByUserID
GO

CREATE PROCEDURE [dbo].[sp_GetBookmarks_ByUserID]
    @p_User_ID INT
AS
BEGIN
    SELECT b.Bookmark_ID, 
           q.Question_ID,
           q.Question_Text, 
           c.Category_Name, 
           co.Company_Name,
           b.Saved_Date
    FROM Bookmarks b
    INNER JOIN Questions q ON b.Question_ID = q.Question_ID
    INNER JOIN Categories c ON q.Category_ID = c.Category_ID
    INNER JOIN Companies co ON q.Company_ID = co.Company_ID
    WHERE b.User_ID = @p_User_ID
    ORDER BY b.Saved_Date DESC;
END
GO

-- =============================================
-- 3. Delete a Bookmark
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_Delete_Bookmark')
    DROP PROCEDURE sp_Delete_Bookmark
GO

CREATE PROCEDURE [dbo].[sp_Delete_Bookmark]
    @p_Bookmark_ID INT
AS
BEGIN
    DELETE FROM Bookmarks WHERE Bookmark_ID = @p_Bookmark_ID;
END
GO

-- =============================================
-- 4. Insert a Bookmark (if not exists)
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_Insert_Bookmark')
    DROP PROCEDURE sp_Insert_Bookmark
GO

CREATE PROCEDURE [dbo].[sp_Insert_Bookmark]
    @p_User_ID INT,
    @p_Question_ID INT
AS
BEGIN
    -- Check if bookmark already exists
    IF NOT EXISTS (SELECT 1 FROM Bookmarks WHERE User_ID = @p_User_ID AND Question_ID = @p_Question_ID)
    BEGIN
        INSERT INTO Bookmarks (User_ID, Question_ID, Saved_Date)
        VALUES (@p_User_ID, @p_Question_ID, GETDATE());
    END
END
GO

-- =============================================
-- 5. Get Questions by Test ID (for quiz attempt)
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetQuestionsByTestID')
    DROP PROCEDURE sp_GetQuestionsByTestID
GO

CREATE PROCEDURE [dbo].[sp_GetQuestionsByTestID]
    @p_Test_ID INT
AS
BEGIN
    SELECT q.Question_ID, 
           q.Question_Text, 
           q.OptionA, 
           q.OptionB, 
           q.OptionC, 
           q.OptionD,
           q.CorrectOption
    FROM Questions q
    INNER JOIN Test_Questions tq ON q.Question_ID = tq.Question_ID
    WHERE tq.Test_ID = @p_Test_ID
    ORDER BY q.Question_ID;
END
GO

-- =============================================
-- 6. Insert Test Result
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_InsertTestResult')
    DROP PROCEDURE sp_InsertTestResult
GO

CREATE PROCEDURE [dbo].[sp_InsertTestResult]
    @p_Test_ID INT,
    @p_User_ID INT,
    @p_Score INT,
    @p_TotalQuestions INT,
    @p_CorrectAnswers INT,
    @p_WrongAnswers INT
AS
BEGIN
    INSERT INTO TestResults (Test_ID, User_ID, Result_Score, Total_Questions, CorrectAnswers, WrongAnswers)
    VALUES (@p_Test_ID, @p_User_ID, @p_Score, @p_TotalQuestions, @p_CorrectAnswers, @p_WrongAnswers);
    
    SELECT SCOPE_IDENTITY() AS Result_ID;
END
GO

-- =============================================
-- 7. Get User Test Attempt Count
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetUserTestAttemptCount')
    DROP PROCEDURE sp_GetUserTestAttemptCount
GO

CREATE PROCEDURE [dbo].[sp_GetUserTestAttemptCount]
    @p_User_ID INT
AS
BEGIN
    SELECT COUNT(*) AS TestCount FROM TestResults WHERE User_ID = @p_User_ID;
END
GO

-- =============================================
-- 8. Get User Bookmark Count
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetUserBookmarkCount')
    DROP PROCEDURE sp_GetUserBookmarkCount
GO

CREATE PROCEDURE [dbo].[sp_GetUserBookmarkCount]
    @p_User_ID INT
AS
BEGIN
    SELECT COUNT(*) AS BookmarkCount FROM Bookmarks WHERE User_ID = @p_User_ID;
END
GO

-- =============================================
-- 9. Get Active Tests for User (with question count)
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetActiveTests_ForUser')
    DROP PROCEDURE sp_GetActiveTests_ForUser
GO

CREATE PROCEDURE [dbo].[sp_GetActiveTests_ForUser]
AS
BEGIN
    SELECT t.Test_ID, 
           t.Test_Name, 
           c.Category_Name, 
           t.TotalMarks,
           t.Duration_Minutes AS DurationMinutes,
           (SELECT COUNT(*) FROM Test_Questions WHERE Test_ID = t.Test_ID) AS QuestionCount
    FROM Tests t
    INNER JOIN Categories c ON t.Category_ID = c.Category_ID
    ORDER BY t.Test_Name;
END
GO

-- =============================================
-- 10. Check if user has completed a specific test
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_CheckTestCompleted')
    DROP PROCEDURE sp_CheckTestCompleted
GO

CREATE PROCEDURE [dbo].[sp_CheckTestCompleted]
    @p_User_ID INT,
    @p_Test_ID INT
AS
BEGIN
    SELECT COUNT(*) AS IsCompleted 
    FROM TestResults 
    WHERE User_ID = @p_User_ID AND Test_ID = @p_Test_ID;
END
GO

-- =============================================
-- 11. Get Active Tests with Completion Status for User
-- =============================================
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_GetTestsWithStatus_ForUser')
    DROP PROCEDURE sp_GetTestsWithStatus_ForUser
GO

CREATE PROCEDURE [dbo].[sp_GetTestsWithStatus_ForUser]
    @p_User_ID INT
AS
BEGIN
    SELECT t.Test_ID, 
           t.Test_Name, 
           c.Category_Name, 
           t.TotalMarks,
           t.Duration_Minutes AS DurationMinutes,
           (SELECT COUNT(*) FROM Test_Questions WHERE Test_ID = t.Test_ID) AS QuestionCount,
           CASE WHEN EXISTS (SELECT 1 FROM TestResults WHERE Test_ID = t.Test_ID AND User_ID = @p_User_ID) 
                THEN 1 ELSE 0 END AS IsCompleted
    FROM Tests t
    INNER JOIN Categories c ON t.Category_ID = c.Category_ID
    ORDER BY t.Test_Name;
END
GO

PRINT 'All User stored procedures created successfully!'
GO

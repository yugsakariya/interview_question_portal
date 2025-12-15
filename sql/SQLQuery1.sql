USE [master]
GO
/****** Object:  Database [InterviewPortal]    Script Date: 12/12/2025 8:26:54 PM ******/
CREATE DATABASE [InterviewPortal]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InterviewPortal', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\InterviewPortal.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'InterviewPortal_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\InterviewPortal_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [InterviewPortal] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InterviewPortal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InterviewPortal] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InterviewPortal] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InterviewPortal] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InterviewPortal] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InterviewPortal] SET ARITHABORT OFF 
GO
ALTER DATABASE [InterviewPortal] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [InterviewPortal] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InterviewPortal] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InterviewPortal] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InterviewPortal] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InterviewPortal] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InterviewPortal] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InterviewPortal] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InterviewPortal] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InterviewPortal] SET  ENABLE_BROKER 
GO
ALTER DATABASE [InterviewPortal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InterviewPortal] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InterviewPortal] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InterviewPortal] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InterviewPortal] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InterviewPortal] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InterviewPortal] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InterviewPortal] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [InterviewPortal] SET  MULTI_USER 
GO
ALTER DATABASE [InterviewPortal] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InterviewPortal] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InterviewPortal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InterviewPortal] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [InterviewPortal] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [InterviewPortal] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [InterviewPortal] SET QUERY_STORE = ON
GO
ALTER DATABASE [InterviewPortal] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [InterviewPortal]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 12/12/2025 8:26:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[Admin_ID] [int] IDENTITY(1,1) NOT NULL,
	[Admin_Name] [nvarchar](50) NOT NULL,
	[Admin_EmailID] [nvarchar](50) NOT NULL,
	[Admin_Password] [nvarchar](50) NOT NULL,
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK__Admins__4A3001174198696D] PRIMARY KEY CLUSTERED 
(
	[Admin_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__Admins__42EB977A7C625505] UNIQUE NONCLUSTERED 
(
	[Admin_EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bookmarks]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookmarks](
	[Bookmark_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
	[Saved_Date] [datetime] NOT NULL,
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK__Bookmark__6869B5A89339F278] PRIMARY KEY CLUSTERED 
(
	[Bookmark_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Category_ID] [int] IDENTITY(1,1) NOT NULL,
	[Category_Name] [nvarchar](50) NOT NULL,
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK__Categori__6DB38D4E38E66758] PRIMARY KEY CLUSTERED 
(
	[Category_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__Categori__B35EB419AC2F1CAE] UNIQUE NONCLUSTERED 
(
	[Category_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[Company_ID] [int] IDENTITY(1,1) NOT NULL,
	[Company_Name] [nvarchar](50) NOT NULL,
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK__Companie__5F5D19320C142735] PRIMARY KEY CLUSTERED 
(
	[Company_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__Companie__F32A5ED9D0CB0EA3] UNIQUE NONCLUSTERED 
(
	[Company_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Question_ID] [int] IDENTITY(1,1) NOT NULL,
	[Category_ID] [int] NOT NULL,
	[Company_ID] [int] NOT NULL,
	[Question_Text] [nvarchar](255) NOT NULL,
	[OptionA] [nvarchar](100) NOT NULL,
	[OptionB] [nvarchar](100) NOT NULL,
	[OptionC] [nvarchar](100) NOT NULL,
	[OptionD] [nvarchar](100) NOT NULL,
	[CorrectOption] [nvarchar](max) NOT NULL,
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK__Question__B0B2E4C6D61C4756] PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test_Questions]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test_Questions](
	[TQ_ID] [int] IDENTITY(1,1) NOT NULL,
	[Test_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK__Test_Que__8ABE8CDF870CD3C8] PRIMARY KEY CLUSTERED 
(
	[TQ_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestResults]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestResults](
	[Result_ID] [int] IDENTITY(1,1) NOT NULL,
	[Test_ID] [int] NULL,
	[User_ID] [int] NULL,
	[Result_Score] [int] NOT NULL,
	[Total_Questions] [int] NOT NULL,
	[CorrectAnswers] [int] NOT NULL,
	[WrongAnswers] [int] NOT NULL,
	[Remark] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Result_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tests]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tests](
	[Test_ID] [int] IDENTITY(1,1) NOT NULL,
	[Test_Name] [nvarchar](50) NOT NULL,
	[Category_ID] [int] NOT NULL,
	[TotalMarks] [int] NOT NULL,
	[Duration_Minutes] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Created_Date] [datetime] NOT NULL,
	[Remark] [nvarchar](max) NULL,
	[User_ID] [int] NOT NULL,
 CONSTRAINT [PK__Tests__B502D002580328C2] PRIMARY KEY CLUSTERED 
(
	[Test_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[User_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_FirstName] [nvarchar](50) NOT NULL,
	[User_LastName] [nvarchar](50) NOT NULL,
	[User_EmailID] [nvarchar](50) NOT NULL,
	[User_Password] [nvarchar](50) NOT NULL,
	[Remark] [nvarchar](max) NULL,
	[User_RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK__Users__206D919009A6D7E5] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__Users__EAE6F70F0E4018A0] UNIQUE NONCLUSTERED 
(
	[User_EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bookmarks] ADD  CONSTRAINT [DF__Bookmarks__Saved__656C112C]  DEFAULT (getdate()) FOR [Saved_Date]
GO
ALTER TABLE [dbo].[Tests] ADD  CONSTRAINT [DF__Tests__Created_D__59063A47]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [User_RegisteredDate]
GO
ALTER TABLE [dbo].[Bookmarks]  WITH CHECK ADD  CONSTRAINT [FK__Bookmarks__Quest__6754599E] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Questions] ([Question_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bookmarks] CHECK CONSTRAINT [FK__Bookmarks__Quest__6754599E]
GO
ALTER TABLE [dbo].[Bookmarks]  WITH CHECK ADD  CONSTRAINT [FK__Bookmarks__User___66603565] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Users] ([User_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bookmarks] CHECK CONSTRAINT [FK__Bookmarks__User___66603565]
GO
ALTER TABLE [dbo].[Test_Questions]  WITH CHECK ADD  CONSTRAINT [FK__Test_Ques__Quest__5EBF139D] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Questions] ([Question_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Test_Questions] CHECK CONSTRAINT [FK__Test_Ques__Quest__5EBF139D]
GO
ALTER TABLE [dbo].[Test_Questions]  WITH CHECK ADD  CONSTRAINT [FK__Test_Ques__Test___5DCAEF64] FOREIGN KEY([Test_ID])
REFERENCES [dbo].[Tests] ([Test_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Test_Questions] CHECK CONSTRAINT [FK__Test_Ques__Test___5DCAEF64]
GO
ALTER TABLE [dbo].[TestResults]  WITH CHECK ADD  CONSTRAINT [FK__TestResul__Test___619B8048] FOREIGN KEY([Test_ID])
REFERENCES [dbo].[Tests] ([Test_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TestResults] CHECK CONSTRAINT [FK__TestResul__Test___619B8048]
GO
ALTER TABLE [dbo].[Tests]  WITH CHECK ADD  CONSTRAINT [FK_Tests_Users] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Users] ([User_ID])
GO
ALTER TABLE [dbo].[Tests] CHECK CONSTRAINT [FK_Tests_Users]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddQuestion]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_AddQuestion]
    @p_CategoryID INT,
    @p_CompanyID INT,
    @p_QuestionText NVARCHAR(255),
    @p_OptionA NVARCHAR(100),
    @p_OptionB NVARCHAR(100),
    @p_OptionC NVARCHAR(100),
    @p_OptionD NVARCHAR(100),
    @p_CorrectOption NVARCHAR(5)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Questions (Category_ID, Company_ID, Question_Text, OptionA, OptionB, OptionC, OptionD, CorrectOption)
    VALUES (@p_CategoryID, @p_CompanyID, @p_QuestionText, @p_OptionA, @p_OptionB, @p_OptionC, @p_OptionD, @p_CorrectOption);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AdminLogin]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AdminLogin]
    @p_Email    NVARCHAR(256),
    @p_Password NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    -- Adjust table/column names below if your Admin table is named differently
    SELECT
        Admin_ID,
        Admin_Name,
        Admin_EmailID  -- optional, remove if not present
    FROM Admins -- replace with actual table name if different (e.g. dbo.Admins)
    WHERE Admin_EmailID = @p_Email
      AND Admin_Password = @p_Password;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BookmarkQuestion]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_BookmarkQuestion]
    @p_UserID INT,
    @p_QuestionID INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Check if already bookmarked to avoid duplicates
    IF NOT EXISTS (SELECT 1 FROM Bookmarks WHERE User_ID = @p_UserID AND Question_ID = @p_QuestionID)
    BEGIN
        INSERT INTO Bookmarks (User_ID, Question_ID)
        VALUES (@p_UserID, @p_QuestionID);
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Check_User_Exists]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Check_User_Exists]
    @p_Email NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        User_ID,
        User_EmailID
    FROM 
        Users
    WHERE 
        User_EmailID = @p_Email;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateTest]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateTest]
    @p_TestName NVARCHAR(50),
    @p_CategoryID INT,
    @p_TotalMarks INT,
    @p_Duration INT,
    @p_CreatedBy INT,
    @p_TestID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Tests (Test_Name, Category_ID, TotalMarks, Duration_Minutes, CreatedBy)
    VALUES (@p_TestName, @p_CategoryID, @p_TotalMarks, @p_Duration, @p_CreatedBy);
    
    SET @p_TestID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Admin]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_Admin] @p_Admin_ID INT
AS
BEGIN
    DELETE FROM Admins WHERE Admin_ID = @p_Admin_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Bookmark]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_Bookmark] @p_Bookmark_ID INT
AS
BEGIN
    DELETE FROM Bookmarks WHERE Bookmark_ID = @p_Bookmark_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Category]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_Category] @p_Category_ID INT
AS
BEGIN
    DELETE FROM Categories WHERE Category_ID = @p_Category_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Company]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_Company] @p_Company_ID INT
AS
BEGIN
    DELETE FROM Companies WHERE Company_ID = @p_Company_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Question]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_Question] @p_Question_ID INT
AS
BEGIN
    DELETE FROM Questions WHERE Question_ID = @p_Question_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Test]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_Test] @p_Test_ID INT
AS
BEGIN
    DELETE FROM Tests WHERE Test_ID = @p_Test_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_TestQuestion]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_TestQuestion] @p_TQ_ID INT
AS
BEGIN
    DELETE FROM Test_Questions WHERE TQ_ID = @p_TQ_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_TestResult]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_TestResult] @p_Result_ID INT
AS
BEGIN
    DELETE FROM TestResults WHERE Result_ID = @p_Result_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_User]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_User] @p_User_ID INT
AS
BEGIN
    DELETE FROM Users WHERE User_ID = @p_User_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Admin_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Admin_ByID] @p_Admin_ID INT
AS
BEGIN
    SELECT * FROM Admins WHERE Admin_ID = @p_Admin_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Bookmark_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Bookmark_ByID] @p_Bookmark_ID INT
AS
BEGIN
    SELECT * FROM Bookmarks WHERE Bookmark_ID = @p_Bookmark_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Category_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Category_ByID] @p_Category_ID INT
AS
BEGIN
    SELECT * FROM Categories WHERE Category_ID = @p_Category_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Company_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Company_ByID] @p_Company_ID INT
AS
BEGIN
    SELECT * FROM Companies WHERE Company_ID = @p_Company_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Question_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Question_ByID] @p_Question_ID INT
AS
BEGIN
    SELECT * FROM Questions WHERE Question_ID = @p_Question_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Test_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Test_ByID] @p_Test_ID INT
AS
BEGIN
    SELECT * FROM Tests WHERE Test_ID = @p_Test_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_TestQuestion_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_TestQuestion_ByID] @p_TQ_ID INT
AS
BEGIN
    SELECT * FROM Test_Questions WHERE TQ_ID = @p_TQ_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_TestResult_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_TestResult_ByID] @p_Result_ID INT
AS
BEGIN
    SELECT * FROM TestResults WHERE Result_ID = @p_Result_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_User_ByID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_User_ByID] @p_User_ID INT
AS
BEGIN
    SELECT * FROM Users WHERE User_ID = @p_User_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Admins]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Admins]
AS
BEGIN
    SELECT * FROM Admins;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Bookmarks]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Bookmarks]
AS
BEGIN
    SELECT * FROM Bookmarks;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Bookmarks_BY_UserID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Bookmarks_BY_UserID]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        Bookmark_ID,
        User_ID,
        Question_ID,
        Saved_Date
    FROM 
        Bookmarks
    WHERE 
        User_ID = @UserID
    ORDER BY 
        Saved_Date DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Categories]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Categories]
AS
BEGIN
    SELECT * FROM Categories;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Companies]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Companies]
AS
BEGIN
    SELECT * FROM Companies;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Questions]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Questions]
AS
BEGIN
    SELECT * FROM Questions;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_TestQuestions]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_TestQuestions]
AS
BEGIN
    SELECT * FROM Test_Questions;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_TestResults]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_TestResults]
AS
BEGIN
    SELECT * FROM TestResults;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Tests]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Tests]
AS
BEGIN
    SELECT * FROM Tests;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Tests_BY_USER_ID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Tests_BY_USER_ID]
    @USER_ID INT
AS
BEGIN
    SELECT *
    FROM Tests
    WHERE User_ID = @USER_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAll_Users]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAll_Users]
AS
BEGIN
    SELECT * FROM Users;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetQuestionsByCategory]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetQuestionsByCategory]
    @p_CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM Questions WHERE Category_ID = @p_CategoryID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserProfileByUserID]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserProfileByUserID]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        User_ID,
        User_FirstName,
        User_LastName,
        User_EmailID,
        User_RegisteredDate
    FROM 
        Users
    WHERE 
        User_ID = @UserID;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Admin]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_Admin]
    @p_Admin_Name NVARCHAR(50),
    @p_Admin_EmailID NVARCHAR(50),
    @p_Admin_Password NVARCHAR(50),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO Admins (Admin_Name, Admin_EmailID, Admin_Password, Remark)
    VALUES (@p_Admin_Name, @p_Admin_EmailID, @p_Admin_Password, @p_Remark);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Bookmark]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_Bookmark]
    @p_User_ID INT,
    @p_Question_ID INT,
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Bookmarks WHERE User_ID = @p_User_ID AND Question_ID = @p_Question_ID)
    BEGIN
        INSERT INTO Bookmarks (User_ID, Question_ID, Remark)
        VALUES (@p_User_ID, @p_Question_ID, @p_Remark);
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Category]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_Category]
    @p_Category_Name NVARCHAR(50),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO Categories (Category_Name, Remark) VALUES (@p_Category_Name, @p_Remark);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Company]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_Company]
    @p_Company_Name NVARCHAR(50),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO Companies (Company_Name, Remark) VALUES (@p_Company_Name, @p_Remark);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Question]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_Question]
    @p_Category_ID INT,
    @p_Company_ID INT,
    @p_Question_Text NVARCHAR(255),
    @p_OptionA NVARCHAR(100),
    @p_OptionB NVARCHAR(100),
    @p_OptionC NVARCHAR(100),
    @p_OptionD NVARCHAR(100),
    @p_CorrectOption NVARCHAR(5),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO Questions (Category_ID, Company_ID, Question_Text, OptionA, OptionB, OptionC, OptionD, CorrectOption, Remark)
    VALUES (@p_Category_ID, @p_Company_ID, @p_Question_Text, @p_OptionA, @p_OptionB, @p_OptionC, @p_OptionD, @p_CorrectOption, @p_Remark);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Test]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_Test]
    @p_Test_Name NVARCHAR(50),
    @p_Category_ID INT,
    @p_TotalMarks INT,
    @p_Duration_Minutes INT,
    @p_CreatedBy INT,
    @p_Remark NVARCHAR(MAX) = NULL,
    @p_Test_ID INT OUTPUT
AS
BEGIN
    INSERT INTO Tests (Test_Name, Category_ID, TotalMarks, Duration_Minutes, CreatedBy, Remark)
    VALUES (@p_Test_Name, @p_Category_ID, @p_TotalMarks, @p_Duration_Minutes, @p_CreatedBy, @p_Remark);
    
    SET @p_Test_ID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_TestQuestion]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_TestQuestion]
    @p_Test_ID INT,
    @p_Question_ID INT,
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO Test_Questions (Test_ID, Question_ID, Remark) VALUES (@p_Test_ID, @p_Question_ID, @p_Remark);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_TestResult]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_TestResult]
    @p_Test_ID INT,
    @p_User_ID INT,
    @p_Result_Score INT,
    @p_Total_Questions INT,
    @p_CorrectAnswers INT,
    @p_WrongAnswers INT,
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO TestResults (Test_ID, User_ID, Result_Score, Total_Questions, CorrectAnswers, WrongAnswers, Remark)
    VALUES (@p_Test_ID, @p_User_ID, @p_Result_Score, @p_Total_Questions, @p_CorrectAnswers, @p_WrongAnswers, @p_Remark);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_User]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_User]
    @User_FirstName NVARCHAR(50),
    @User_LastName NVARCHAR(50),
    @User_EmailID NVARCHAR(100),
    @User_Password NVARCHAR(100),
    @User_RegisteredDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Users (User_FirstName, User_LastName, User_EmailID,User_Password, User_RegisteredDate)
    VALUES (@User_FirstName, @User_LastName, @User_EmailID,@User_Password, ISNULL(@User_RegisteredDate, GETDATE()));
    
    SELECT SCOPE_IDENTITY() AS User_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RegisterUser]
    @p_FirstName NVARCHAR(50),
    @p_LastName NVARCHAR(50),
    @p_Email NVARCHAR(50),
    @p_Password NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Users (User_FirstName, User_LastName, User_EmailID, User_Password)
    VALUES (@p_FirstName, @p_LastName, @p_Email, @p_Password);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveTestResult]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_SaveTestResult]
    @p_TestID INT,
    @p_UserID INT,
    @p_Score INT,
    @p_TotalQuestions INT,
    @p_CorrectAnswers INT,
    @p_WrongAnswers INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO TestResults (Test_ID, User_ID, Result_Score, Total_Questions, CorrectAnswers, WrongAnswers)
    VALUES (@p_TestID, @p_UserID, @p_Score, @p_TotalQuestions, @p_CorrectAnswers, @p_WrongAnswers);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Admin]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_Admin]
    @p_Admin_ID INT,
    @p_Admin_Name NVARCHAR(50),
    @p_Admin_EmailID NVARCHAR(50),
    @p_Admin_Password NVARCHAR(50),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE Admins
    SET Admin_Name = @p_Admin_Name,
        Admin_EmailID = @p_Admin_EmailID,
        Admin_Password = @p_Admin_Password,
        Remark = @p_Remark
    WHERE Admin_ID = @p_Admin_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Bookmark]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_Bookmark]
    @p_Bookmark_ID INT,
    @p_Remark NVARCHAR(MAX)
AS
BEGIN
    UPDATE Bookmarks SET Remark = @p_Remark WHERE Bookmark_ID = @p_Bookmark_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Category]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_Category]
    @p_Category_ID INT,
    @p_Category_Name NVARCHAR(50),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE Categories SET Category_Name = @p_Category_Name, Remark = @p_Remark WHERE Category_ID = @p_Category_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Company]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_Company]
    @p_Company_ID INT,
    @p_Company_Name NVARCHAR(50),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE Companies SET Company_Name = @p_Company_Name, Remark = @p_Remark WHERE Company_ID = @p_Company_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Question]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_Question]
    @p_Question_ID INT,
    @p_Category_ID INT,
    @p_Company_ID INT,
    @p_Question_Text NVARCHAR(255),
    @p_OptionA NVARCHAR(100),
    @p_OptionB NVARCHAR(100),
    @p_OptionC NVARCHAR(100),
    @p_OptionD NVARCHAR(100),
    @p_CorrectOption NVARCHAR(5),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE Questions
    SET Category_ID = @p_Category_ID,
        Company_ID = @p_Company_ID,
        Question_Text = @p_Question_Text,
        OptionA = @p_OptionA,
        OptionB = @p_OptionB,
        OptionC = @p_OptionC,
        OptionD = @p_OptionD,
        CorrectOption = @p_CorrectOption,
        Remark = @p_Remark
    WHERE Question_ID = @p_Question_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Test]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_Test]
    @p_Test_ID INT,
    @p_Test_Name NVARCHAR(50),
    @p_Category_ID INT,
    @p_TotalMarks INT,
    @p_Duration_Minutes INT,
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE Tests
    SET Test_Name = @p_Test_Name,
        Category_ID = @p_Category_ID,
        TotalMarks = @p_TotalMarks,
        Duration_Minutes = @p_Duration_Minutes,
        Remark = @p_Remark
    WHERE Test_ID = @p_Test_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_TestQuestion]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_TestQuestion]
    @p_TQ_ID INT,
    @p_Test_ID INT,
    @p_Question_ID INT,
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE Test_Questions
    SET Test_ID = @p_Test_ID,
        Question_ID = @p_Question_ID,
        Remark = @p_Remark
    WHERE TQ_ID = @p_TQ_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_TestResult]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_TestResult]
    @p_Result_ID INT,
    @p_Test_ID INT,
    @p_User_ID INT,
    @p_Result_Score INT,
    @p_Total_Questions INT,
    @p_CorrectAnswers INT,
    @p_WrongAnswers INT,
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE TestResults
    SET Test_ID = @p_Test_ID,
        User_ID = @p_User_ID,
        Result_Score = @p_Result_Score,
        Total_Questions = @p_Total_Questions,
        CorrectAnswers = @p_CorrectAnswers,
        WrongAnswers = @p_WrongAnswers,
        Remark = @p_Remark
    WHERE Result_ID = @p_Result_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_User]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_User]
    @p_User_ID INT,
    @p_User_FirstName NVARCHAR(50),
    @p_User_LastName NVARCHAR(50),
    @p_User_EmailID NVARCHAR(50),
    @p_User_Password NVARCHAR(50),
    @p_Remark NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE Users
    SET User_FirstName = @p_User_FirstName,
        User_LastName = @p_User_LastName,
        User_EmailID = @p_User_EmailID,
        User_Password = @p_User_Password,
        Remark = @p_Remark
    WHERE User_ID = @p_User_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserLogin]    Script Date: 12/12/2025 8:26:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UserLogin]
    @p_Email NVARCHAR(50),
    @p_Password NVARCHAR(50)
AS
BEGIN
    SELECT User_ID, User_FirstName, User_LastName 
    FROM Users 
    WHERE User_EmailID = @p_Email AND User_Password = @p_Password;
END
GO
USE [master]
GO
ALTER DATABASE [InterviewPortal] SET  READ_WRITE 
GO

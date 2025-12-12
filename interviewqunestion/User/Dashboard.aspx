    <%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/User/Site.Master"
    AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs"
    Inherits="interview_questions.User.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
   <link href="../Styles/Style.css" accesskey="stylesheet" rel="stylesheet" />

    
    <div class="dashboard-header">
        <h1 class="dashboard-title">
            Welcome back, <asp:Label ID="lblUser" runat="server" />
        </h1>
        <p class="dashboard-subtitle">Here's what's happening with your learning today</p>
    </div>

    
    <div class="stats-grid">
        
        
        <!--<div class="stat-card primary">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-question-circle"></i>
                </div>
            </div>
            <div class="stat-label">Total Questions</div>
            <div class="stat-value">
                <asp:Label ID="lblQ" runat="server" />
            </div>
            <div class="stat-footer">
                <i class="fas fa-arrow-up"></i>
                <span>Available to practice</span>
            </div>
        </div> -->

        
        <div class="stat-card success">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-clipboard-check"></i>
                </div>
            </div>
            <div class="stat-label">Tests Attempted</div>
            <div class="stat-value">
                <asp:Label ID="lblTests" runat="server" />
            </div>
            <div class="stat-footer">
                <i class="fas fa-chart-line"></i>
                <span>Keep up the progress!</span>
            </div>
        </div>

        
        <div class="stat-card warning">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-bookmark"></i>
                </div>
            </div>
            <div class="stat-label">Bookmarks</div>
            <div class="stat-value">
                <asp:Label ID="lblBookmarks" runat="server" Text="0" />
            </div>
            <div class="stat-footer">
                <i class="fas fa-star"></i>
                <span>Saved for later</span>
            </div>
        </div>

    </div>

    
    <div class="quick-actions">
        <h2 class="section-title">Quick Actions</h2>
        <div class="action-grid">
            
            <a href="Questions.aspx" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-book-open"></i>
                </div>
                <div class="action-title">Browse Questions</div>
                <div class="action-description">Explore interview questions</div>
            </a>

            <a href="QuizList.aspx" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-play-circle"></i>
                </div>
                <div class="action-title">Take a Quiz</div>
                <div class="action-description">Test your knowledge</div>
            </a>

            <a href="Bookmarks.aspx" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-heart"></i>
                </div>
                <div class="action-title">My Bookmarks</div>
                <div class="action-description">Review saved items</div>
            </a>

        </div>
    </div>

</asp:Content>
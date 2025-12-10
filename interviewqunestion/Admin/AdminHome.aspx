<%@ Page Title="Admin Home" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs"
    Inherits="interview_questions.Admin.AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <link href="~/Styles/Admin.css" rel="stylesheet" />

    <div class="dashboard-header">
        <h1 class="dashboard-title">Welcome to Admin Dashboard</h1>
        <p class="dashboard-subtitle">Here's what's happening with your portal today</p>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card primary">
            <div class="stat-card-header">
                <div class="stat-content">
                    <div class="stat-title">Total Users</div>
                    <h2 class="stat-value">
                        <asp:Label ID="lblUsers" runat="server" Text="0" />
                    </h2>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up"></i> Active learners
                    </div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
            </div>
            <div class="stat-card-bg">
                <i class="fas fa-users"></i>
            </div>
        </div>

        <div class="stat-card success">
            <div class="stat-card-header">
                <div class="stat-content">
                    <div class="stat-title">Total Questions</div>
                    <h2 class="stat-value">
                        <asp:Label ID="lblQuestions" runat="server" Text="0" />
                    </h2>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up"></i> In database
                    </div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-question-circle"></i>
                </div>
            </div>
            <div class="stat-card-bg">
                <i class="fas fa-question-circle"></i>
            </div>
        </div>

        <div class="stat-card warning">
            <div class="stat-card-header">
                <div class="stat-content">
                    <div class="stat-title">Total Tests</div>
                    <h2 class="stat-value">
                        <asp:Label ID="lblTests" runat="server" Text="0" />
                    </h2>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up"></i> Available now
                    </div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-clipboard-list"></i>
                </div>
            </div>
            <div class="stat-card-bg">
                <i class="fas fa-clipboard-list"></i>
            </div>
        </div>

        <div class="stat-card danger">
            <div class="stat-card-header">
                <div class="stat-content">
                    <div class="stat-title">Total Attempts</div>
                    <h2 class="stat-value">
                        <asp:Label ID="lblAttempts" runat="server" Text="0" />
                    </h2>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up"></i> This month
                    </div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
            </div>
            <div class="stat-card-bg">
                <i class="fas fa-chart-line"></i>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <h2 class="section-title">Quick Actions</h2>
        <div class="actions-grid">
            <asp:HyperLink runat="server" NavigateUrl="~/Admin/ManageCategories.aspx" CssClass="action-card">
                <div class="action-icon">
                    <i class="fas fa-folder-plus"></i>
                </div>
                <div class="action-title">Add Category</div>
                <div class="action-desc">Create new category</div>
            </asp:HyperLink>

            <asp:HyperLink runat="server" NavigateUrl="~/Admin/ManageCompanies.aspx" CssClass="action-card">
                <div class="action-icon">
                    <i class="fas fa-building"></i>
                </div>
                <div class="action-title">Add Company</div>
                <div class="action-desc">Register new company</div>
            </asp:HyperLink>

            <asp:HyperLink runat="server" NavigateUrl="~/Admin/ManageQuestions.aspx" CssClass="action-card">
                <div class="action-icon">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <div class="action-title">Add Question</div>
                <div class="action-desc">Create new question</div>
            </asp:HyperLink>

            <asp:HyperLink runat="server" NavigateUrl="~/Admin/ManageTests.aspx" CssClass="action-card">
                <div class="action-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="action-title">Create Test</div>
                <div class="action-desc">Setup new test</div>
            </asp:HyperLink>

            <asp:HyperLink runat="server" NavigateUrl="~/Admin/AssignQuestions.aspx" CssClass="action-card">
                <div class="action-icon">
                    <i class="fas fa-link"></i>
                </div>
                <div class="action-title">Assign Questions</div>
                <div class="action-desc">Link to tests</div>
            </asp:HyperLink>

            <asp:HyperLink runat="server" NavigateUrl="~/Admin/ViewTestResults.aspx" CssClass="action-card">
                <div class="action-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <div class="action-title">View Results</div>
                <div class="action-desc">Check performance</div>
            </asp:HyperLink>
        </div>
    </div>
</asp:Content>
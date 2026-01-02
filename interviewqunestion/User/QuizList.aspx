<%@ Page Title="Quizzes" Language="C#" MasterPageFile="~/User/Site.Master"
    AutoEventWireup="true" CodeBehind="QuizList.aspx.cs"
    Inherits="interview_questions.User.QuizList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <link href="../Styles/Style.css" accesskey="stylesheet" rel="stylesheet" />

    <!-- Page Header -->
    <div class="page-header">
        <div class="page-title-wrapper">
            <i class="fas fa-clipboard-list"></i>
            <h1>Available Tests</h1>
        </div>
        <div class="tests-count">
            <asp:Label ID="lblTestCount" runat="server" Text="0 Tests Available" />
        </div>
    </div>

    <!-- Tests Grid -->
    <div class="tests-grid">
        <asp:Repeater ID="rptTests" runat="server">
            <ItemTemplate>
                <div class="test-card">
                    <div class="test-header">
                        <div class="test-name">
                            <i class="fas fa-file-alt"></i>
                            <%# Eval("Test_Name") %>
                        </div>
                        <span class="test-category">
                            <i class="fas fa-folder"></i>
                            <%# Eval("Category_Name") %>
                        </span>
                    </div>

                    <div class="test-meta">
                        <div class="meta-item">
                            <span class="meta-label">Total Marks</span>
                            <span class="meta-value">
                                <i class="fas fa-star"></i>
                                <%# Eval("TotalMarks") %>
                            </span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">Duration</span>
                            <span class="meta-value">
                                <i class="fas fa-clock"></i>
                                <%# Eval("DurationMinutes") %> min
                            </span>
                        </div>
                    </div>

                    <div class="test-footer">
                        <%# Convert.ToInt32(Eval("IsCompleted")) == 1 ? 
                            "<div class='test-info completed'><i class='fas fa-check-circle' style='color:#10b981;'></i><span style='color:#10b981;font-weight:600;'>Completed</span></div><span class='btn-completed' style='background:#d1d5db;color:#6b7280;cursor:not-allowed;padding:0.5rem 1rem;border-radius:0.5rem;'><i class='fas fa-lock'></i> Completed</span>" :
                            "<div class='test-info'><i class='fas fa-info-circle'></i><span>Ready to begin</span></div><a href='QuizAttempt.aspx?testId=" + Eval("Test_ID") + "' class='btn-start'><i class='fas fa-play'></i> Start Test</a>"
                        %>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>



</asp:Content>
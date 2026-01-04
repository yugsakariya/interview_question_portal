<%@ Page Title="View Test Results" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ViewTestResults.aspx.cs"
    Inherits="interview_questions.Admin.ViewTestResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Styles/Admin.css" rel="stylesheet" />

    <div class="page-header">
        <h1 class="page-title">Test Results Dashboard</h1>
        <p class="page-subtitle">View and analyze all test attempt results</p>
    </div>

    
    <div class="stats-summary">
        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-clipboard-check"></i>
            </div>
            <div class="summary-content">
                <div class="summary-label">Total Attempts</div>
                <div class="summary-value">
                    <asp:Label ID="lblTotalAttempts" runat="server" Text="0" />
                </div>
            </div>
        </div>
        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="summary-content">
                <div class="summary-label">Avg Score</div>
                <div class="summary-value">
                    <asp:Label ID="lblAvgScore" runat="server" Text="0%" />
                </div>
            </div>
        </div>
        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-users"></i>
            </div>
            <div class="summary-content">
                <div class="summary-label">Unique Users</div>
                <div class="summary-value">
                    <asp:Label ID="lblUniqueUsers" runat="server" Text="0" />
                </div>
            </div>
        </div>
    </div>

    <div class="table-card">
        <div class="table-header">
            <h2 class="table-title">
                <i class="fas fa-table"></i>
                All Test Results
            </h2>
        </div>

        <div class="table-wrapper">
            <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False"
                CssClass="table"
                GridLines="None"
                ShowHeaderWhenEmpty="True">
                <Columns>
                    
                    <asp:BoundField DataField="Test_Name" HeaderText="Test Name">
                        <ItemStyle CssClass="col-test" />
                    </asp:BoundField>
                    <asp:BoundField DataField="UserName" HeaderText="User">
                        <ItemStyle CssClass="col-user" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Score">
                        <ItemTemplate>
                            <span class='<%# GetScoreClass(Eval("Result_Score"), Eval("TotalQuestions")) %>'>
                                <%# Eval("Result_Score") %> / <%# Eval("TotalQuestions") %>
                                (<%# GetScorePercentage(Eval("Result_Score"), Eval("TotalQuestions")) %>%)
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Correct">
                        <ItemTemplate>
                            <span class="stat-indicator stat-correct">
                                <i class="fas fa-check"></i>
                                <%# Eval("CorrectAnswers") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Wrong">
                        <ItemTemplate>
                            <span class="stat-indicator stat-wrong">
                                <i class="fas fa-times"></i>
                                <%# Eval("WrongAnswers") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <i class="fas fa-chart-bar"></i>
                        <div class="empty-state-title">No Test Results Yet</div>
                        <p>Results will appear here once users complete tests</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <script>
        // Add smooth scroll animation
        window.addEventListener('load', function() {
            const cards = document.querySelectorAll('.summary-card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</asp:Content>
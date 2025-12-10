<%@ Page Title="Quizzes" Language="C#" MasterPageFile="~/Site.Master"
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
                        <div class="test-info">
                            <i class="fas fa-info-circle"></i>
                            <span>Ready to begin</span>
                        </div>
                        <asp:HyperLink runat="server"
                            NavigateUrl='<%# "~/QuizAttempt.aspx?testId=" + Eval("Test_ID") %>'
                            CssClass="btn-start">
                            <i class="fas fa-play"></i>
                            Start Test
                        </asp:HyperLink>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Fallback GridView (if needed) -->
    <div class="table-wrapper">
        <asp:GridView ID="gvTests" runat="server" 
            AutoGenerateColumns="False"
            CssClass="table" 
            DataKeyNames="Test_ID"
            ShowHeaderWhenEmpty="True"
            EmptyDataText="">
            <Columns>
                <asp:TemplateField HeaderText="Test Name">
                    <ItemTemplate>
                        <div style="font-weight: 600; color: #1f2937;">
                            <%# Eval("Test_Name") %>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Category">
                    <ItemTemplate>
                        <span class="test-category">
                            <i class="fas fa-folder"></i>
                            <%# Eval("Category_Name") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="TotalMarks" HeaderText="Marks" />
                <asp:BoundField DataField="DurationMinutes" HeaderText="Duration (min)" />

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:HyperLink runat="server"
                            NavigateUrl='<%# "~/QuizAttempt.aspx?testId=" + Eval("Test_ID") %>'
                            CssClass="btn-start">
                            <i class="fas fa-play"></i>
                            Start
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <EmptyDataTemplate>
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h3>No tests available</h3>
                    <p>Check back later for new tests</p>
                </div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>

</asp:Content>
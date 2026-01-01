
<%@ Page Title="Questions" Language="C#" MasterPageFile="~/User/Site.Master"
    AutoEventWireup="true" CodeBehind="Questions.aspx.cs"
    Inherits="interviewquestion.User.Questions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Styles/Style.css" rel="stylesheet" />

    <div class="questions-page">

        
        <div class="page-header">
            <i class="fas fa-question-circle"></i>
            <h1>Interview Questions</h1>
        </div>

        
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert-message alert-success">
            <i class="fas fa-check-circle"></i>
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </asp:Panel>

        
        <div class="filter-section">
            <div class="filter-title">
                <i class="fas fa-filter"></i>
                Filter Questions
            </div>

            <div class="filter-grid">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-folder"></i> Category
                    </label>
                    <asp:DropDownList ID="ddlCategory" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="FilterChanged">
                        <asp:ListItem Selected="True" Text="All" Value="All"></asp:ListItem>

                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-building"></i> Company
                    </label>
                    <asp:DropDownList ID="ddlCompany" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="FilterChanged">
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <asp:LinkButton ID="btnClear" runat="server"
                        CssClass="btn-clear"
                        OnClick="btnClear_Click">
                        <i class="fas fa-times-circle"></i>
                        <span>Clear Filters</span>
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        
        <div class="table-wrapper">
            <asp:GridView ID="gvQuestions" runat="server"
                CssClass="questions-grid"
                AutoGenerateColumns="False"
                DataKeyNames="Question_ID"
                OnRowCommand="gvQuestions_RowCommand"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="">
                
                <HeaderStyle BackColor="#6366f1" ForeColor="White" Font-Bold="True" />
                <RowStyle BackColor="#1f2937" ForeColor="#e5e7eb" />
                <AlternatingRowStyle BackColor="#374151" ForeColor="#e5e7eb" />
                
                <Columns>
                    <asp:TemplateField HeaderText="Question">
                        <ItemTemplate>
                            <div class="question-text">
                                <%# Eval("Question_Text") %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Category">
                        <ItemTemplate>
                            <span class="badge-category">
                                <i class="fas fa-folder"></i>
                                <%# Eval("Category_Name") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Company">
                        <ItemTemplate>
                            <span class="badge-company">
                                <i class="fas fa-building"></i>
                                <%# Eval("Company_Name") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnBookmark" runat="server"
                                CssClass="btn-bookmark"
                                CommandName="Bookmark"
                                CommandArgument='<%# Eval("Question_ID") %>'>
                                <i class="fas fa-bookmark"></i>
                                <span>Bookmark</span>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <EmptyDataTemplate>
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h3>No questions found</h3>
                        <p>Try adjusting your filters to see more results</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>

    </div>

    <style>
        .questions-grid {
            width: 100%;
            border-collapse: collapse;
            background: #1f2937;
            border-radius: 12px;
            overflow: hidden;
        }
        .questions-grid th {
            padding: 1rem 1.5rem !important;
            text-align: left !important;
            font-weight: 600 !important;
            background: linear-gradient(135deg, #6366f1, #8b5cf6) !important;
            color: #fff !important;
        }
        .questions-grid td {
            padding: 1rem 1.5rem !important;
            border-bottom: 1px solid #374151 !important;
            color: #e5e7eb !important;
            background: #1f2937 !important;
        }
        .questions-grid tr:nth-child(even) td {
            background: #374151 !important;
        }
        .questions-grid tr:hover td {
            background: #4b5563 !important;
        }
        .question-text {
            color: #e5e7eb;
            line-height: 1.5;
        }
        .badge-category, .badge-company {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.375rem 0.75rem;
            background: rgba(99, 102, 241, 0.2);
            color: #a5b4fc;
            border-radius: 6px;
            font-size: 0.875rem;
        }
        .badge-company {
            background: rgba(16, 185, 129, 0.2);
            color: #6ee7b7;
        }
        .btn-bookmark {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: #6366f1;
            color: #fff !important;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.875rem;
            border: none;
            cursor: pointer;
        }
        .btn-bookmark:hover {
            background: #4f46e5;
        }
    </style>

</asp:Content>

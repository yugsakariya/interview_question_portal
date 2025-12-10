
<%@ Page Title="Questions" Language="C#" MasterPageFile="~/Site.Master"
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
                CssClass="table questions-table"
                AutoGenerateColumns="False"
                DataKeyNames="Question_ID"
                OnRowCommand="gvQuestions_RowCommand"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="">
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

</asp:Content>

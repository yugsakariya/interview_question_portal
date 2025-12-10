<%@ Page Title="Bookmarks" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Bookmarks.aspx.cs"
    Inherits="interview_questions.User.Bookmarks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
   <link href="../Styles/Style.css" accesskey="stylesheet" rel="stylesheet" />

    <!-- Page Header -->
    <div class="page-header">
        <div class="page-title">
            <i class="fas fa-bookmark"></i>
            <h1>Saved Questions</h1>
        </div>
        <div class="bookmark-count">
            <asp:Label ID="lblBookmarkCount" runat="server" Text="0 Bookmarks" />
        </div>
    </div>

    <!-- Bookmarks Table -->
    <div class="custom-table-wrapper">
        <asp:GridView ID="gvBookmarks" runat="server" 
            CssClass="table"
            AutoGenerateColumns="False" 
            DataKeyNames="Bookmark_ID"
            OnRowCommand="gvBookmarks_RowCommand"
            ShowHeaderWhenEmpty="True"
            EmptyDataText="">
            <Columns>
                <asp:TemplateField HeaderText="Question">
                    <ItemTemplate>
                        <div class="question-cell">
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
                        <asp:Button ID="btnRemove" runat="server" 
                            CssClass="btn-remove"
                            CommandName="Remove" 
                            CommandArgument='<%# Eval("Bookmark_ID") %>'
                            OnClientClick="return confirm('Are you sure you want to remove this bookmark?');"
                            Text="Remove" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <EmptyDataTemplate>
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-bookmark"></i>
                    </div>
                    <h3>No bookmarks yet</h3>
                    <p>Start saving questions you want to revisit later</p>
                    <a href="Questions.aspx" class="btn-primary-custom">
                        <i class="fas fa-search"></i>
                        Browse Questions
                    </a>
                </div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>

</asp:Content>
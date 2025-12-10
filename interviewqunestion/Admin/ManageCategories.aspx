<%@ Page Title="Manage Categories" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageCategories.aspx.cs"
    Inherits="interview_questions.Admin.ManageCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Styles/Admin.css" rel="stylesheet" />

    <div class="page-header">
        <h1 class="page-title">Manage Categories</h1>
    </div>

    <div class="form-card">
        <label class="form-label">Category Name</label>
        <div class="input-group">
            <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control"
                Placeholder="Enter category name"></asp:TextBox>
            <asp:HiddenField ID="hfCategoryId" runat="server" />
            <asp:Button ID="btnSave" runat="server" Text="Save"
                CssClass="btn btn-primary" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                CssClass="btn btn-secondary" OnClick="btnCancel_Click" />
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>

    <div class="table-card">
        <div class="table-header">
            <h2 class="table-title">All Categories</h2>
        </div>

        <div class="table-wrapper">
            <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False"
                CssClass="table" DataKeyNames="Category_ID"
                OnRowCommand="gvCategories_RowCommand"
                GridLines="None"
                ShowHeaderWhenEmpty="True">
                <Columns>
                    <asp:BoundField DataField="Category_ID" HeaderText="ID">
                        <ItemStyle CssClass="col-id" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Category_Name" HeaderText="Category Name">
                        <ItemStyle CssClass="col-name" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="action-buttons">
                                <asp:Button ID="btnEdit" runat="server" Text="Edit"
                                    CommandName="EditRow" CommandArgument='<%# Eval("Category_ID") %>'
                                    CssClass="btn btn-sm btn-warning" />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CommandName="DeleteRow" CommandArgument='<%# Eval("Category_ID") %>'
                                    CssClass="btn btn-sm btn-danger"
                                    OnClientClick="return confirm('Are you sure you want to delete this category?');" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <i class="fas fa-folder-open"></i>
                        <div class="empty-state-title">No Categories Found</div>
                        <p>Start by adding your first category above</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <script>
        // Show message and auto-hide after 3 seconds
        window.onload = function() {
            var lblMsg = document.getElementById('<%= lblMsg.ClientID %>');
            if (lblMsg && lblMsg.innerText.trim() !== '') {
                lblMsg.style.display = 'flex';
                setTimeout(function() {
                    lblMsg.style.opacity = '0';
                    setTimeout(function() {
                        lblMsg.style.display = 'none';
                        lblMsg.style.opacity = '1';
                    }, 300);
                }, 3000);
            }
        };
    </script>
</asp:Content>
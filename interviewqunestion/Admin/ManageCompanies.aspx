<%@ Page Title="Manage Companies" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageCompanies.aspx.cs"
    Inherits="interview_questions.Admin.ManageCompanies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <link href="~/Styles/Admin.css" rel="stylesheet" />

    <div class="page-header">
        <h1 class="page-title">Manage Companies</h1>
    </div>

    <div class="form-card">
        <label class="form-label">Company Name</label>
        <div class="input-group">
            <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control"
                Placeholder="Enter company name"></asp:TextBox>
            <asp:HiddenField ID="hfCompanyId" runat="server" />
            <asp:Button ID="btnSave" runat="server" Text="Save"
                CssClass="btn btn-primary" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                CssClass="btn btn-secondary" OnClick="btnCancel_Click" />
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>

    <div class="table-card">
        <div class="table-header">
            <h2 class="table-title">All Companies</h2>
        </div>

        <div class="table-wrapper">
            <asp:GridView ID="gvCompanies" runat="server" AutoGenerateColumns="False"
                CssClass="table" DataKeyNames="Company_ID"
                OnRowCommand="gvCompanies_RowCommand"
                GridLines="None"
                ShowHeaderWhenEmpty="True">
                <Columns>
                    <asp:BoundField DataField="Company_ID" HeaderText="ID">
                        <ItemStyle CssClass="col-id" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Company_Name" HeaderText="Company Name">
                        <ItemStyle CssClass="col-name" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="action-buttons">
                                <asp:Button ID="btnEdit" runat="server" Text="Edit"
                                    CommandName="EditRow" CommandArgument='<%# Eval("Company_ID") %>'
                                    CssClass="btn btn-sm btn-warning" />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CommandName="DeleteRow" CommandArgument='<%# Eval("Company_ID") %>'
                                    CssClass="btn btn-sm btn-danger"
                                    OnClientClick="return confirm('Are you sure you want to delete this company?');" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <i class="fas fa-building"></i>
                        <div class="empty-state-title">No Companies Found</div>
                        <p>Start by adding your first company above</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <script>
        
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
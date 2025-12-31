<%@ Page Title="Manage Tests" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageTests.aspx.cs"
    Inherits="interview_questions.Admin.ManageTests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Styles/Admin.css" rel="stylesheet" />

    <div class="page-header">
        <h1 class="page-title">Manage Tests</h1>
    </div>

    <div class="form-card">
        <div class="form-card-header">Add / Edit Test</div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Test Name</label>
                <asp:TextBox ID="txtTestName" runat="server" CssClass="form-control" 
                    Placeholder="Enter test name" />
            </div>
            <div class="form-group">
                <label class="form-label">Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Total Marks</label>
                <asp:TextBox ID="txtTotalMarks" runat="server" CssClass="form-control" 
                    TextMode="Number" Placeholder="e.g., 100" />
            </div>
            <div class="form-group">
                <label class="form-label">Duration (Minutes)</label>
                <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" 
                    TextMode="Number" Placeholder="e.g., 60" />
            </div>
            <div class="form-group">
                <label class="form-label">Created By</label>
                <asp:TextBox ID="txtCreatedBy" runat="server" CssClass="form-control" 
                    Placeholder="Admin name" />
            </div>
        </div>

        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>

        <div class="form-actions">
            <asp:HiddenField ID="hfTestId" runat="server" />
            <asp:Button ID="btnSave" runat="server" Text="Save Test"
                CssClass="btn btn-primary" OnClick="btnSave_Click" />
            <asp:Button ID="btnClear" runat="server" Text="Clear"
                CssClass="btn btn-secondary" OnClick="btnClear_Click" />
        </div>
    </div>

    <div class="table-card">
        <div class="table-header">
            <h2 class="table-title">All Tests</h2>
        </div>

        <div class="table-wrapper">
            <asp:GridView ID="gvTests" runat="server" AutoGenerateColumns="False"
                CssClass="table" DataKeyNames="Test_ID"
                OnRowCommand="gvTests_RowCommand"
                GridLines="None"
                ShowHeaderWhenEmpty="True">
                <Columns>
                    <asp:BoundField DataField="Test_ID" HeaderText="ID">
                        <ItemStyle CssClass="col-id" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Test_Name" HeaderText="Test Name">
                        <ItemStyle CssClass="col-name" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Category_Name" HeaderText="Category">
                        <ItemStyle CssClass="col-category" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TotalMarks" HeaderText="Marks">
                        <ItemStyle CssClass="col-marks" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Duration_Minutes" HeaderText="Duration (Min)">
                        <ItemStyle CssClass="col-duration" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="action-buttons">
                                <asp:Button ID="btnEdit" runat="server" Text="Edit"
                                    CommandName="EditT" CommandArgument='<%# Eval("Test_ID") %>'
                                    CssClass="btn btn-sm btn-warning" />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CommandName="DeleteT" CommandArgument='<%# Eval("Test_ID") %>'
                                    CssClass="btn btn-sm btn-danger"
                                    OnClientClick="return confirm('Are you sure you want to delete this test?');" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <i class="fas fa-clipboard-list"></i>
                        <div class="empty-state-title">No Tests Found</div>
                        <p>Start by creating your first test above</p>
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
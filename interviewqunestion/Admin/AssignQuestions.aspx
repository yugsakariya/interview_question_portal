<%@ Page Title="Assign Questions" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="AssignQuestions.aspx.cs"
    Inherits="interview_questions.Admin.AssignQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Styles/Admin.css" rel="stylesheet" />

    <div class="page-header">
        <h1 class="page-title">Assign Questions to Tests</h1>
        <p class="page-subtitle">Link questions to specific tests for assessment creation</p>
    </div>

    <div class="selector-card">
        <div class="form-group">
            <label class="form-label">Select Test</label>
            <asp:DropDownList ID="ddlTest" runat="server" CssClass="form-select"
                AutoPostBack="true" OnSelectedIndexChanged="ddlTest_SelectedIndexChanged"></asp:DropDownList>
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>

    <!-- All Questions Section -->
    <div class="table-card">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-list"></i>
                All Questions
            </h2>
        </div>

        <div class="table-wrapper">
            <asp:GridView ID="gvAllQuestions" runat="server" AutoGenerateColumns="False"
                CssClass="table" DataKeyNames="Question_ID"
                OnRowCommand="gvAllQuestions_RowCommand"
                GridLines="None"
                ShowHeaderWhenEmpty="True">
                <Columns>
                    
                    <asp:BoundField DataField="Question_Text" HeaderText="Question">
                        <ItemStyle CssClass="col-question" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnAssign" runat="server" Text="Assign"
                                CommandName="Assign" CommandArgument='<%# Eval("Question_ID") %>'
                                CssClass="btn btn-primary" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <div class="empty-state-title">No Questions Available</div>
                        <p>Add questions first to assign them to tests</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <div class="divider"></div>

    <!-- Assigned Questions Section -->
    <div class="table-card">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-check-circle"></i>
                Assigned Questions
            </h2>
        </div>

        <div class="table-wrapper">
            <asp:GridView ID="gvAssigned" runat="server" AutoGenerateColumns="False"
                CssClass="table" DataKeyNames="TQ_ID"
                OnRowCommand="gvAssigned_RowCommand"
                GridLines="None"
                ShowHeaderWhenEmpty="True">
                <Columns>
                    
                    
                    <asp:BoundField DataField="Question_Text" HeaderText="Question">
                        <ItemStyle CssClass="col-question" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnRemove" runat="server" Text="Remove"
                                CommandName="Remove" CommandArgument='<%# Eval("TQ_ID") %>'
                                CssClass="btn btn-danger"
                                OnClientClick="return confirm('Are you sure you want to remove this question from the test?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <i class="fas fa-clipboard-check"></i>
                        <div class="empty-state-title">No Questions Assigned</div>
                        <p>Select a test and assign questions from the list above</p>
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
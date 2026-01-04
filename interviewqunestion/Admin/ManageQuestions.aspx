<%@ Page Title="Manage Questions" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageQuestions.aspx.cs"
    Inherits="interview_questions.Admin.ManageQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <link href="~/Styles/Admin.css" rel="stylesheet" />

    <div class="page-header">
        <h1 class="page-title">Manage Questions</h1>
    </div>

    <div class="form-card">
        <div class="form-card-header">Add / Edit Question</div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label class="form-label">Company</label>
                <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group full-width">
                <label class="form-label">Question Text</label>
                <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control" 
                    TextMode="MultiLine" Rows="3" Placeholder="Enter your question here..." />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Option A</label>
                <asp:TextBox ID="txtA" runat="server" CssClass="form-control" 
                    Placeholder="Enter option A" />
            </div>
            <div class="form-group">
                <label class="form-label">Option B</label>
                <asp:TextBox ID="txtB" runat="server" CssClass="form-control" 
                    Placeholder="Enter option B" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Option C</label>
                <asp:TextBox ID="txtC" runat="server" CssClass="form-control" 
                    Placeholder="Enter option C" />
            </div>
            <div class="form-group">
                <label class="form-label">Option D</label>
                <asp:TextBox ID="txtD" runat="server" CssClass="form-control" 
                    Placeholder="Enter option D" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Correct Option</label>
                <asp:DropDownList ID="ddlCorrectOption" runat="server" CssClass="form-select">
                    <asp:ListItem Text="A" Value="A" />
                    <asp:ListItem Text="B" Value="B" />
                    <asp:ListItem Text="C" Value="C" />
                    <asp:ListItem Text="D" Value="D" />
                </asp:DropDownList>
            </div>
        </div>

        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>

        <div class="form-actions">
            <asp:HiddenField ID="hfQuestionId" runat="server" />
            <asp:Button ID="btnSave" runat="server" Text="Save Question"
                CssClass="btn btn-primary" OnClick="btnSave_Click" />
            <asp:Button ID="btnClear" runat="server" Text="Clear"
                CssClass="btn btn-secondary" OnClick="btnClear_Click" />
        </div>
    </div>

    <div class="form-card">
        <div class="form-card-header">Bulk Upload Questions</div>
        
        <div class="upload-section">
            <div class="upload-info">
                <i class="fas fa-info-circle"></i>
                <div>
                    <strong>Upload CSV File Format:</strong>
                    <p>Category, Company, Question, OptionA, OptionB, OptionC, OptionD, CorrectOption</p>
                    <p class="upload-note">Note: CorrectOption should be A, B, C, or D</p>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group full-width">
                    <label class="form-label">Select CSV File</label>
                    <asp:FileUpload ID="fuQuestions" runat="server" />
                </div>
            </div>

            <asp:Label ID="lblUploadMsg" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>

            <div class="form-actions">
                <asp:Button ID="btnUpload" runat="server" Text="Upload Questions"
                    CssClass="btn btn-success" OnClick="btnUpload_Click" />
                <asp:Button ID="btnDownloadTemplate" runat="server" Text="Download Template"
                    CssClass="btn btn-info" OnClick="btnDownloadTemplate_Click" />
            </div>
        </div>
    </div>

    <div class="table-card">
        <div class="table-header">
            <h2 class="table-title">All Questions</h2>
        </div>

        <div class="table-wrapper">
            <asp:GridView ID="gvQuestions" runat="server" AutoGenerateColumns="False"
                CssClass="table" DataKeyNames="Question_ID"
                OnRowCommand="gvQuestions_RowCommand"
                GridLines="None"
                ShowHeaderWhenEmpty="True">
                <Columns>
                   
                    <asp:BoundField DataField="Question_Text" HeaderText="Question">
                        <ItemStyle CssClass="col-question" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Category_Name" HeaderText="Category">
                        <ItemStyle CssClass="col-category" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Company_Name" HeaderText="Company">
                        <ItemStyle CssClass="col-company" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CorrectOption" HeaderText="Answer">
                        <ItemStyle CssClass="col-answer" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="action-buttons">
                                <asp:Button ID="btnEdit" runat="server" Text="Edit"
                                    CssClass="btn btn-sm btn-warning"
                                    CommandName="EditQ" CommandArgument='<%# Eval("Question_ID") %>' />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CssClass="btn btn-sm btn-danger"
                                    CommandName="DeleteQ" CommandArgument='<%# Eval("Question_ID") %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this question?');" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <i class="fas fa-question-circle"></i>
                        <div class="empty-state-title">No Questions Found</div>
                        <p>Start by adding your first question above</p>
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
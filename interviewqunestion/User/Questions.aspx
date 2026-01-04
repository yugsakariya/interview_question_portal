<%@ Page Title="Questions" Language="C#" MasterPageFile="~/User/Site.Master" AutoEventWireup="true"
    CodeBehind="Questions.aspx.cs" Inherits="interviewquestion.User.Questions" %>

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
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select" AutoPostBack="true"
                            OnSelectedIndexChanged="FilterChanged">
                            <asp:ListItem Selected="True" Text="All" Value="All"></asp:ListItem>

                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-building"></i> Company
                        </label>
                        <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-select" AutoPostBack="true"
                            OnSelectedIndexChanged="FilterChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <asp:LinkButton ID="btnClear" runat="server" CssClass="btn-clear" OnClick="btnClear_Click">
                            <i class="fas fa-times-circle"></i>
                            <span>Clear Filters</span>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>


            <div class="table-wrapper">
                <asp:GridView ID="gvQuestions" runat="server" CssClass="questions-grid" AutoGenerateColumns="False"
                    DataKeyNames="Question_ID" OnRowCommand="gvQuestions_RowCommand" ShowHeaderWhenEmpty="True"
                    EmptyDataText="">

                    <HeaderStyle BackColor="#6366f1" ForeColor="White" Font-Bold="True" />
                    <RowStyle BackColor="#1f2937" ForeColor="#e5e7eb" />
                    <AlternatingRowStyle BackColor="#374151" ForeColor="#e5e7eb" />

                    <Columns>
                        <asp:TemplateField HeaderText="Question">
                            <ItemTemplate>
                                <div class="question-container">
                                    <div class="question-text clickable" onclick="toggleAnswer(this)">
                                        <i class="fas fa-chevron-right expand-icon"></i>
                                        <%# Eval("Question_Text") %>
                                    </div>
                                    <div class="answer-section" style="display: none;">
                                        <div class="answer-label">
                                            <i class="fas fa-lightbulb"></i>
                                            Answer:
                                        </div>
                                        <div class="answer-text">
                                            <%# Eval("CorrectOption") %>
                                        </div>
                                    </div>
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
                                <asp:LinkButton ID="btnBookmark" runat="server" CssClass="btn-bookmark"
                                    CommandName="Bookmark" CommandArgument='<%# Eval("Question_ID") %>'>
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

            /* ================= QUESTION/ANSWER CONTAINER ================= */
            .question-container {
                width: 100%;
            }

            .question-text {
                color: #e5e7eb;
                line-height: 1.6;
                font-weight: 500;
            }

            .question-text.clickable {
                cursor: pointer;
                display: flex;
                align-items: flex-start;
                gap: 0.75rem;
                padding: 0.5rem;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .question-text.clickable:hover {
                background: rgba(99, 102, 241, 0.1);
                color: #fff;
            }

            .expand-icon {
                color: #6366f1;
                font-size: 0.85rem;
                transition: transform 0.3s ease;
                flex-shrink: 0;
                margin-top: 0.25rem;
            }

            .question-text.clickable.expanded .expand-icon {
                transform: rotate(90deg);
            }

            /* ================= ANSWER SECTION ================= */
            .answer-section {
                margin-top: 1rem;
                padding: 1rem;
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.1), rgba(139, 92, 246, 0.05));
                border-left: 3px solid #6366f1;
                border-radius: 8px;
                animation: slideDown 0.3s ease-out;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .answer-label {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-weight: 600;
                color: #a5b4fc;
                margin-bottom: 0.75rem;
                font-size: 0.9rem;
            }

            .answer-label i {
                color: #fbbf24;
                font-size: 1rem;
            }

            .answer-text {
                color: #d1d5db;
                line-height: 1.7;
                font-size: 0.95rem;
                padding-left: 1.5rem;
            }

            /* ================= BADGES ================= */
            .badge-category,
            .badge-company {
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

            /* ================= BOOKMARK BUTTON ================= */
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
                transition: all 0.3s ease;
            }

            .btn-bookmark:hover {
                background: #4f46e5;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
            }
        </style>

        <script>
            function toggleAnswer(element) {
                const questionText = element;
                const answerSection = questionText.nextElementSibling;

                // Toggle expanded class
                questionText.classList.toggle('expanded');

                // Toggle answer visibility
                if (answerSection.style.display === 'none' || answerSection.style.display === '') {
                    answerSection.style.display = 'block';
                } else {
                    answerSection.style.display = 'none';
                }
            }
        </script>

    </asp:Content>
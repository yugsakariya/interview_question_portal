<%@ Page Title="Bookmarks" Language="C#" MasterPageFile="~/User/Site.Master" AutoEventWireup="true"
    CodeBehind="Bookmarks.aspx.cs" Inherits="interview_questions.User.Bookmarks" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <style>
            .bookmarks-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 0 1rem;
            }

            .page-hero {
                background: linear-gradient(135deg, rgba(245, 158, 11, 0.15), rgba(251, 191, 36, 0.1));
                border: 1px solid rgba(245, 158, 11, 0.2);
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 1rem;
                backdrop-filter: blur(10px);
            }

            .page-title-section {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .page-icon {
                width: 56px;
                height: 56px;
                background: linear-gradient(135deg, #f59e0b, #fbbf24);
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                color: white;
                box-shadow: 0 8px 20px rgba(245, 158, 11, 0.3);
            }

            .page-title {
                font-size: 1.75rem;
                font-weight: 800;
                color: #ffffff;
                margin: 0;
            }

            .page-subtitle {
                color: #9ca3af;
                font-size: 0.95rem;
                margin-top: 0.25rem;
            }

            .bookmark-badge {
                background: rgba(245, 158, 11, 0.2);
                border: 1px solid rgba(245, 158, 11, 0.3);
                padding: 0.75rem 1.25rem;
                border-radius: 12px;
                color: #fbbf24;
                font-weight: 700;
            }

            .table-card {
                background: rgba(15, 15, 25, 0.95);
                border: 1px solid rgba(245, 158, 11, 0.15);
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
                background-color:#1C1C26;
            }

            /* Column widths */
            .table th:nth-child(1),
            .table td:nth-child(1) {
                width: 45%;
            }

            .table th:nth-child(2),
            .table td:nth-child(2) {
                width: 18%;
                text-align: center;
            }

            .table th:nth-child(3),
            .table td:nth-child(3) {
                width: 18%;
                text-align: center;
            }

            .table th:nth-child(4),
            .table td:nth-child(4) {
                width: 19%;
                text-align: center;
            }

            .table th {
                padding: 1.25rem 1.5rem;
                text-align: left;
                font-weight: 700;
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.1em;
                background: linear-gradient(135deg, #f59e0b, #fbbf24);
                color: #1a1a2e;
            }

            .table th:nth-child(2),
            .table th:nth-child(3),
            .table th:nth-child(4) {
                text-align: center;
            }

            .table td {
                padding: 1.25rem 1.5rem;
                border-bottom: 1px solid rgba(245, 158, 11, 0.08);
                color: #e5e7eb;
                vertical-align: middle;
            }

            .table tbody tr {
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background: rgba(245, 158, 11, 0.08);
            }

            .table tbody tr:hover td {
                border-color: rgba(245, 158, 11, 0.15);
            }

            .table tbody tr:last-child td {
                border-bottom: none;
            }

            .question-cell {
                font-weight: 500;
                color: #ffffff;
                line-height: 1.6;
                font-size: 0.95rem;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .badge-category,
            .badge-company {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                padding: 0.5rem 1rem;
                border-radius: 10px;
                font-size: 0.8rem;
                font-weight: 600;
                white-space: nowrap;
                transition: all 0.2s ease;
            }

            .badge-category {
                background: rgba(99, 102, 241, 0.15);
                border: 1px solid rgba(99, 102, 241, 0.25);
                color: #a5b4fc;
            }

            .badge-category:hover {
                background: rgba(99, 102, 241, 0.25);
                transform: translateY(-1px);
            }

            .badge-company {
                background: rgba(16, 185, 129, 0.15);
                border: 1px solid rgba(16, 185, 129, 0.25);
                color: #6ee7b7;
            }

            .badge-company:hover {
                background: rgba(16, 185, 129, 0.25);
                transform: translateY(-1px);
            }

            .btn-remove {
                padding: 0.6rem 1.25rem;
                border-radius: 10px;
                font-weight: 600;
                font-size: 0.85rem;
                background: rgba(239, 68, 68, 0.12);
                border: 1px solid rgba(239, 68, 68, 0.25);
                color: #f87171;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.4rem;
            }

            .btn-remove:hover {
                background: rgba(239, 68, 68, 0.25);
                border-color: #ef4444;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(239, 68, 68, 0.2);
            }

            .btn-remove:active {
                transform: translateY(0);
            }

            .empty-state {
                text-align: center;
                padding: 5rem 2rem;
                background: rgba(15, 15, 25, 0.95);
                border-radius: 16px;
            }

            .empty-state i {
                font-size: 4rem;
                color: #fbbf24;
                margin-bottom: 1.5rem;
                display: block;
                opacity: 0.8;
            }

            .empty-state h3 {
                font-size: 1.5rem;
                color: #ffffff;
                margin-bottom: 0.75rem;
                font-weight: 700;
            }

            .empty-state p {
                color: #9ca3af;
                margin-bottom: 2rem;
                font-size: 1rem;
            }

            .btn-primary-custom {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.85rem 1.75rem;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                border-radius: 12px;
                color: white;
                font-weight: 700;
                text-decoration: none;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
            }

            .btn-primary-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
            }

            /* Responsive Design */
            @media (max-width: 992px) {

                .table th:nth-child(1),
                .table td:nth-child(1) {
                    width: 40%;
                }

                .table th:nth-child(2),
                .table td:nth-child(2),
                .table th:nth-child(3),
                .table td:nth-child(3) {
                    width: 20%;
                }

                .table th:nth-child(4),
                .table td:nth-child(4) {
                    width: 20%;
                }
            }

            @media (max-width: 768px) {
                .table-card {
                    overflow-x: auto;
                }

                .table {
                    min-width: 700px;
                }

                .page-hero {
                    flex-direction: column;
                    text-align: center;
                }

                .page-title-section {
                    flex-direction: column;
                }

                .table th,
                .table td {
                    padding: 1rem;
                }
            }

            /* Grid Background */
.dark-grid {
    width: 100%;
    background-color: #0B1220;
    color: #E5E7EB;
    border-radius: 14px;
    overflow: hidden;
}

/* Header */
.dark-grid th {
    background-color: #111827;
    color: #93C5FD;
    font-weight: 600;
    padding: 14px;
    border-bottom: 1px solid #1F2937;
}

/* Rows */
.dark-grid td {
    padding: 14px;
    background-color: #0B1220;
    border-bottom: 1px solid #1F2937;
}

/* Hover */
.dark-grid tr:hover td {
    background-color: #111827;
}

/* Question text */
.question-cell {
    font-size: 15px;
    line-height: 1.6;
}

/* Category badge */
.badge-category {
    background: #1E293B;
    color: #38BDF8;
    padding: 6px 10px;
    border-radius: 999px;
    font-size: 13px;
}

/* Company badge */
.badge-company {
    background: #1E293B;
    color: #A5B4FC;
    padding: 6px 10px;
    border-radius: 999px;
    font-size: 13px;
}

/* Remove button */
.btn-remove {
    background: #DC2626;
    border: none;
    color: white;
    padding: 6px 14px;
    border-radius: 8px;
    cursor: pointer;
}

.btn-remove:hover {
    background: #B91C1C;
}

/* Empty state */
.empty-state {
    text-align: center;
    padding: 40px;
    color: #9CA3AF;
}

.empty-state i {
    font-size: 40px;
    color: #38BDF8;
}

.btn-primary-custom {
    display: inline-block;
    margin-top: 15px;
    padding: 10px 18px;
    background: #2563EB;
    color: white;
    border-radius: 10px;
    text-decoration: none;
}

.btn-primary-custom:hover {
    background: #1D4ED8;
}

        </style>

        <div class="bookmarks-container">
            <div class="page-hero">
                <div class="page-title-section">
                    <div class="page-icon"><i class="fas fa-heart"></i></div>
                    <div>
                        <h1 class="page-title">Saved Questions</h1>
                        <p class="page-subtitle">Your bookmarked questions for quick review</p>
                    </div>
                </div>
                <div class="bookmark-badge">
                    <asp:Label ID="lblBookmarkCount" runat="server" Text="0 Bookmarks" />
                </div>
            </div>

            <div class="table-card">
                <asp:GridView ID="gvBookmarks" runat="server"
    CssClass="table dark-grid"
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
                    OnClientClick="return confirm('Remove this bookmark?');"
                    Text="Remove" />
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

    <EmptyDataTemplate>
        <div class="empty-state">
            <i class="fas fa-heart"></i>
            <h3>No saved questions yet</h3>
            <p>Start saving questions you want to revisit later</p>
            <a href="Questions.aspx" class="btn-primary-custom">
                <i class="fas fa-search"></i> Browse Questions
            </a>
        </div>
    </EmptyDataTemplate>

</asp:GridView>
            </div>
        </div>

    </asp:Content>

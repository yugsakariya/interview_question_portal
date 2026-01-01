<%@ Page Title="My Results" Language="C#" MasterPageFile="~/User/Site.Master"
    AutoEventWireup="true" CodeBehind="Results.aspx.cs"
    Inherits="interviewquestion.User.Results" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Styles/Style.css" rel="stylesheet" />

    <!-- Header -->
    <div class="page-header">
        <i class="fas fa-chart-line"></i>
        <h3>My Test Results</h3>
    </div>

    <!-- Results Table using Repeater -->
    <div class="results-container">
        <asp:Panel ID="pnlResults" runat="server">
            <table class="results-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-file-alt"></i> Test Name</th>
                        <th><i class="fas fa-star"></i> Score</th>
                        <th><i class="fas fa-list"></i> Total</th>
                        <th><i class="fas fa-check"></i> Correct</th>
                        <th><i class="fas fa-times"></i> Wrong</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptResults" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Test_Name") %></td>
                                <td><span class="score-badge"><%# Eval("Result_Score") %></span></td>
                                <td><%# Eval("Total_Questions") %></td>
                                <td class="correct"><%# Eval("CorrectAnswers") %></td>
                                <td class="wrong"><%# Eval("WrongAnswers") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </asp:Panel>

        <!-- Empty State -->
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h4>No test results yet</h4>
                <p>Take a quiz to see your performance here.</p>
                <a href="QuizList.aspx" class="btn-browse-tests">
                    <i class="fas fa-clipboard-list"></i>
                    Browse Tests
                </a>
            </div>
        </asp:Panel>
    </div>

    <style>
        .results-container {
            margin-top: 1.5rem;
        }
        .results-table {
            width: 100%;
            border-collapse: collapse;
            background: #1f2937;
            border-radius: 12px;
            overflow: hidden;
        }
        .results-table thead {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
        }
        .results-table th {
            padding: 1rem 1.5rem;
            text-align: left;
            font-weight: 600;
            color: #fff;
        }
        .results-table th i {
            margin-right: 0.5rem;
        }
        .results-table td {
            padding: 1rem 1.5rem;
            color: #e5e7eb;
            border-bottom: 1px solid #374151;
        }
        .results-table tbody tr:hover {
            background: #374151;
        }
        .score-badge {
            background: #6366f1;
            color: #fff;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-weight: 600;
        }
        .correct {
            color: #10b981;
            font-weight: 600;
        }
        .wrong {
            color: #ef4444;
            font-weight: 600;
        }
        .empty-state {
            text-align: center;
            padding: 3rem;
            background: #1f2937;
            border-radius: 12px;
        }
        .empty-state-icon {
            font-size: 3rem;
            color: #6366f1;
            margin-bottom: 1rem;
        }
        .empty-state h4 {
            color: #e5e7eb;
            margin-bottom: 0.5rem;
        }
        .empty-state p {
            color: #9ca3af;
            margin-bottom: 1.5rem;
        }
        .btn-browse-tests {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: #6366f1;
            color: #fff;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }
        .btn-browse-tests:hover {
            background: #4f46e5;
        }
    </style>

</asp:Content>

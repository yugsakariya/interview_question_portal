<%@ Page Title="My Results" Language="C#" MasterPageFile="~/User/Site.Master" AutoEventWireup="true"
    CodeBehind="Results.aspx.cs" Inherits="interviewquestion.User.Results" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <!-- Page Header -->
        <div class="results-header">
            <div class="header-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <h2 class="header-title">My Test Results</h2>
        </div>

        <!-- Results Table -->
        <div class="results-wrapper">
            <asp:Panel ID="pnlResults" runat="server">
                <div class="table-container">
                    <table class="results-table">
                        <thead>
                            <tr>
                                <th class="col-test-name">
                                    <i class="fas fa-file-alt"></i>
                                    <span>TEST NAME</span>
                                </th>
                                <th class="col-score">
                                    <i class="fas fa-star"></i>
                                    <span>SCORE</span>
                                </th>
                                <th class="col-total">
                                    <i class="fas fa-list"></i>
                                    <span>TOTAL</span>
                                </th>
                                <th class="col-correct">
                                    <i class="fas fa-check"></i>
                                    <span>CORRECT</span>
                                </th>
                                <th class="col-wrong">
                                    <i class="fas fa-times"></i>
                                    <span>WRONG</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptResults" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="test-name">
                                            <%# Eval("Test_Name") %>
                                        </td>
                                        <td class="score-cell">
                                            <span class="score-badge">
                                                <%# Eval("Result_Score") %>
                                            </span>
                                        </td>
                                        <td class="total-cell">
                                            <%# Eval("Total_Questions") %>
                                        </td>
                                        <td class="correct-cell">
                                            <%# Eval("CorrectAnswers") %>
                                        </td>
                                        <td class="wrong-cell">
                                            <%# Eval("WrongAnswers") %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </asp:Panel>

            <!-- Empty State -->
            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="empty-state">
                    <div class="empty-icon">
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
            /* ================= PAGE HEADER ================= */
            .results-header {
                display: flex;
                align-items: center;
                gap: 1.5rem;
                margin-bottom: 2.5rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid rgba(99, 102, 241, 0.15);
            }

            .header-icon {
                width: 60px;
                height: 60px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.2), rgba(139, 92, 246, 0.15));
                border-radius: 12px;
                border: 1px solid rgba(99, 102, 241, 0.3);
                flex-shrink: 0;
            }

            .header-icon i {
                font-size: 1.75rem;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .header-title {
                font-size: 2rem;
                font-weight: 700;
                color: #fff;
                margin: 0;
                letter-spacing: -0.5px;
            }

            /* ================= RESULTS WRAPPER ================= */
            .results-wrapper {
                margin-top: 1.5rem;
            }

            .table-container {
                overflow-x: auto;
                border-radius: 16px;
            }

            /* ================= MODERN TABLE ================= */
            .results-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: rgba(31, 41, 55, 0.5);
                backdrop-filter: blur(20px);
                border-radius: 16px;
                overflow: hidden;
                border: 1px solid rgba(99, 102, 241, 0.2);
                box-shadow:
                    0 20px 60px rgba(0, 0, 0, 0.3),
                    inset 0 1px 1px rgba(255, 255, 255, 0.05);
            }

            /* ================= TABLE HEADER ================= */
            .results-table thead {
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.25), rgba(139, 92, 246, 0.2));
                backdrop-filter: blur(10px);
            }

            .results-table th {
                padding: 1.25rem 1.5rem;
                text-align: center;
                font-weight: 600;
                font-size: 0.75rem;
                color: rgba(255, 255, 255, 0.9);
                text-transform: uppercase;
                letter-spacing: 1px;
                white-space: nowrap;
                border-bottom: 1px solid rgba(99, 102, 241, 0.2);
            }

            .results-table th i {
                display: block;
                font-size: 1.1rem;
                margin-bottom: 0.4rem;
                color: #a5b4fc;
            }

            .results-table th span {
                display: block;
                font-size: 0.75rem;
            }

            .col-test-name {
                text-align: left !important;
            }

            /* ================= TABLE BODY ================= */
            .results-table tbody tr {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                background: rgba(15, 23, 42, 0.3);
            }

            .results-table tbody tr:hover {
                background: rgba(99, 102, 241, 0.1);
                transform: scale(1.005);
            }

            .results-table td {
                padding: 1.25rem 1.5rem;
                color: #e5e7eb;
                border-bottom: 1px solid rgba(55, 65, 81, 0.3);
                font-size: 0.95rem;
                text-align: center;
            }

            .results-table tbody tr:last-child td {
                border-bottom: none;
            }

            .test-name {
                text-align: left !important;
                font-weight: 500;
                color: #fff;
            }

            /* ================= SCORE BADGE ================= */
            .score-cell {
                text-align: center;
            }

            .score-badge {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-width: 50px;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                color: #fff;
                padding: 0.5rem 1rem;
                border-radius: 50px;
                font-weight: 700;
                font-size: 0.95rem;
                box-shadow:
                    0 4px 12px rgba(99, 102, 241, 0.4),
                    inset 0 1px 1px rgba(255, 255, 255, 0.2);
                transition: all 0.3s ease;
            }

            .score-badge:hover {
                transform: scale(1.08);
                box-shadow:
                    0 6px 16px rgba(99, 102, 241, 0.6),
                    inset 0 1px 1px rgba(255, 255, 255, 0.3);
            }

            /* ================= CORRECT/WRONG CELLS ================= */
            .total-cell {
                font-weight: 600;
                color: #d1d5db;
            }

            .correct-cell {
                color: #10b981;
                font-weight: 700;
                font-size: 1rem;
            }

            .wrong-cell {
                color: #ef4444;
                font-weight: 700;
                font-size: 1rem;
            }

            /* ================= EMPTY STATE ================= */
            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                background: rgba(31, 41, 55, 0.5);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                border: 1px solid rgba(99, 102, 241, 0.2);
                box-shadow:
                    0 20px 60px rgba(0, 0, 0, 0.3),
                    inset 0 1px 1px rgba(255, 255, 255, 0.05);
            }

            .empty-icon {
                font-size: 4rem;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1.5rem;
                animation: float 3s ease-in-out infinite;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translateY(0);
                }

                50% {
                    transform: translateY(-10px);
                }
            }

            .empty-state h4 {
                color: #e5e7eb;
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 0.75rem;
            }

            .empty-state p {
                color: #9ca3af;
                font-size: 1rem;
                margin-bottom: 2rem;
            }

            /* ================= BROWSE TESTS BUTTON ================= */
            .btn-browse-tests {
                display: inline-flex;
                align-items: center;
                gap: 0.6rem;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                color: #fff;
                padding: 0.85rem 1.75rem;
                border-radius: 12px;
                text-decoration: none;
                font-weight: 600;
                font-size: 0.95rem;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                box-shadow:
                    0 4px 16px rgba(99, 102, 241, 0.4),
                    inset 0 1px 1px rgba(255, 255, 255, 0.2);
                position: relative;
                overflow: hidden;
            }

            .btn-browse-tests::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(90deg,
                        transparent 0%,
                        rgba(255, 255, 255, 0.2) 50%,
                        transparent 100%);
                transform: translateX(-100%);
                transition: transform 0.6s ease;
            }

            .btn-browse-tests:hover {
                background: linear-gradient(135deg, #8b5cf6, #a78bfa);
                transform: translateY(-2px);
                box-shadow:
                    0 8px 24px rgba(99, 102, 241, 0.6),
                    inset 0 1px 1px rgba(255, 255, 255, 0.3);
                color: #fff;
            }

            .btn-browse-tests:hover::before {
                transform: translateX(100%);
            }

            .btn-browse-tests:active {
                transform: translateY(0);
            }

            /* ================= RESPONSIVE DESIGN ================= */
            @media (max-width: 768px) {
                .results-header {
                    gap: 1rem;
                }

                .header-icon {
                    width: 50px;
                    height: 50px;
                }

                .header-icon i {
                    font-size: 1.5rem;
                }

                .header-title {
                    font-size: 1.5rem;
                }

                .results-table {
                    font-size: 0.85rem;
                }

                .results-table th,
                .results-table td {
                    padding: 1rem;
                }

                .results-table th {
                    font-size: 0.7rem;
                }

                .results-table th i {
                    font-size: 0.95rem;
                }

                .score-badge {
                    padding: 0.4rem 0.85rem;
                    font-size: 0.85rem;
                }

                .empty-state {
                    padding: 3rem 1.5rem;
                }

                .empty-icon {
                    font-size: 3rem;
                }

                .empty-state h4 {
                    font-size: 1.25rem;
                }

                .empty-state p {
                    font-size: 0.9rem;
                }
            }

            @media (max-width: 576px) {
                .results-header {
                    flex-direction: row;
                    gap: 1rem;
                }

                .header-icon {
                    width: 45px;
                    height: 45px;
                }

                .header-icon i {
                    font-size: 1.25rem;
                }

                .header-title {
                    font-size: 1.25rem;
                }

                .results-table th,
                .results-table td {
                    padding: 0.85rem 0.75rem;
                    font-size: 0.8rem;
                }

                .results-table th i {
                    font-size: 0.85rem;
                    margin-bottom: 0.3rem;
                }

                .results-table th span {
                    font-size: 0.65rem;
                }

                .score-badge {
                    padding: 0.35rem 0.7rem;
                    font-size: 0.8rem;
                    min-width: 40px;
                }

                .btn-browse-tests {
                    width: 100%;
                    justify-content: center;
                }
            }

            /* ================= SCROLL ENHANCEMENT ================= */
            .table-container::-webkit-scrollbar {
                height: 8px;
            }

            .table-container::-webkit-scrollbar-track {
                background: rgba(31, 41, 55, 0.5);
                border-radius: 4px;
            }

            .table-container::-webkit-scrollbar-thumb {
                background: linear-gradient(90deg, #6366f1, #8b5cf6);
                border-radius: 4px;
            }

            .table-container::-webkit-scrollbar-thumb:hover {
                background: linear-gradient(90deg, #8b5cf6, #a78bfa);
            }
        </style>

    </asp:Content>
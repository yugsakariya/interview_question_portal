<%@ Page Title="My Results" Language="C#" MasterPageFile="~/User/Site.Master" AutoEventWireup="true"
    CodeBehind="Results.aspx.cs" Inherits="interviewquestion.User.Results" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <style>
            .results-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 0 1rem;
            }

            .page-hero {
                background: linear-gradient(135deg, rgba(16, 185, 129, 0.15), rgba(20, 184, 166, 0.1));
                border: 1px solid rgba(16, 185, 129, 0.2);
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 1rem;
                backdrop-filter: blur(10px);
            }

            .page-icon {
                width: 56px;
                height: 56px;
                background: linear-gradient(135deg, #10b981, #14b8a6);
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                color: white;
                box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
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

            .table-card {
                background: rgba(15, 15, 25, 0.95);
                border: 1px solid rgba(16, 185, 129, 0.15);
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            }

            .results-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
            }

            .results-table thead {
                background: linear-gradient(135deg, #10b981, #14b8a6);
            }

            .results-table th {
                padding: 1.25rem 1.5rem;
                text-align: left;
                font-weight: 700;
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.1em;
                color: #ffffff;
            }

            .results-table th:nth-child(1) {
                width: 30%;
            }

            .results-table th:nth-child(2),
            .results-table th:nth-child(3),
            .results-table th:nth-child(4),
            .results-table th:nth-child(5) {
                width: 12%;
                text-align: center;
            }

            .results-table th:nth-child(6) {
                width: 22%;
                text-align: center;
            }

            .results-table th i {
                margin-right: 0.5rem;
            }

            .results-table td {
                padding: 1.25rem 1.5rem;
                color: #e5e7eb;
                border-bottom: 1px solid rgba(16, 185, 129, 0.08);
                vertical-align: middle;
            }

            .results-table td:nth-child(2),
            .results-table td:nth-child(3),
            .results-table td:nth-child(4),
            .results-table td:nth-child(5),
            .results-table td:nth-child(6) {
                text-align: center;
            }

            .results-table tbody tr {
                transition: all 0.3s ease;
            }

            .results-table tbody tr:hover {
                background: rgba(16, 185, 129, 0.08);
            }

            .results-table tbody tr:last-child td {
                border-bottom: none;
            }

            .test-name {
                font-weight: 600;
                color: #ffffff;
            }

            .score-badge {
                display: inline-block;
                background: linear-gradient(135deg, #10b981, #14b8a6);
                color: #fff;
                padding: 0.4rem 1rem;
                border-radius: 20px;
                font-weight: 700;
                font-size: 0.9rem;
            }

            .correct {
                color: #34d399;
                font-weight: 700;
            }

            .wrong {
                color: #f87171;
                font-weight: 700;
            }

            .btn-view-answers {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.6rem 1.25rem;
                background: rgba(99, 102, 241, 0.15);
                border: 1px solid rgba(99, 102, 241, 0.3);
                border-radius: 10px;
                color: #a5b4fc;
                font-weight: 600;
                font-size: 0.85rem;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
            }

            .btn-view-answers:hover {
                background: rgba(99, 102, 241, 0.25);
                border-color: #6366f1;
                color: #c7d2fe;
                transform: translateY(-2px);
            }

            /* Answer Modal Styles */
            .answer-modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.85);
                z-index: 9999;
                overflow-y: auto;
                padding: 2rem;
                box-sizing: border-box;
                animation: fadeIn 0.3s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }

                to {
                    opacity: 1;
                }
            }

            .modal-content {
                max-width: 900px;
                margin: 0 auto;
                background: rgba(20, 20, 35, 0.98);
                border: 1px solid rgba(99, 102, 241, 0.2);
                border-radius: 20px;
                overflow: hidden;
                animation: slideUp 0.3s ease;
            }

            @keyframes slideUp {
                from {
                    transform: translateY(20px);
                    opacity: 0;
                }

                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            .modal-header {
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                padding: 1.5rem 2rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .modal-title {
                color: #ffffff;
                font-size: 1.25rem;
                font-weight: 700;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .btn-close-modal {
                background: rgba(255, 255, 255, 0.2);
                border: none;
                color: white;
                width: 40px;
                height: 40px;
                border-radius: 10px;
                cursor: pointer;
                font-size: 1.25rem;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s ease;
            }

            .btn-close-modal:hover {
                background: rgba(255, 255, 255, 0.3);
            }

            .modal-body {
                padding: 1.5rem 2rem 2rem;
                max-height: 70vh;
                overflow-y: auto;
            }

            .question-item {
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(99, 102, 241, 0.15);
                border-radius: 14px;
                padding: 1.5rem;
                margin-bottom: 1rem;
                transition: all 0.3s ease;
            }

            .question-item:hover {
                border-color: rgba(99, 102, 241, 0.3);
                background: rgba(255, 255, 255, 0.05);
            }

            .question-item:last-child {
                margin-bottom: 0;
            }

            .question-number {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 32px;
                height: 32px;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                border-radius: 8px;
                color: white;
                font-weight: 700;
                font-size: 0.9rem;
                margin-right: 1rem;
            }

            .question-text {
                color: #ffffff;
                font-weight: 600;
                font-size: 1rem;
                line-height: 1.6;
                margin-bottom: 1rem;
                display: inline;
            }

            .options-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 0.75rem;
                margin-top: 1rem;
            }

            .option-item {
                padding: 0.75rem 1rem;
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 10px;
                color: #9ca3af;
                font-size: 0.9rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .option-item.correct-answer {
                background: rgba(16, 185, 129, 0.15);
                border-color: rgba(16, 185, 129, 0.4);
                color: #34d399;
            }

            .option-label {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 26px;
                height: 26px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 6px;
                font-weight: 700;
                font-size: 0.8rem;
            }

            .option-item.correct-answer .option-label {
                background: rgba(16, 185, 129, 0.3);
            }

            .correct-badge {
                margin-left: auto;
                display: flex;
                align-items: center;
                gap: 0.35rem;
                font-size: 0.75rem;
                font-weight: 700;
                color: #34d399;
            }

            .loading-state {
                text-align: center;
                padding: 3rem;
                color: #9ca3af;
            }

            .loading-state i {
                font-size: 2rem;
                margin-bottom: 1rem;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                from {
                    transform: rotate(0deg);
                }

                to {
                    transform: rotate(360deg);
                }
            }

            .empty-state {
                text-align: center;
                padding: 5rem 2rem;
                background: rgba(15, 15, 25, 0.95);
                border-radius: 16px;
            }

            .empty-state i {
                font-size: 4rem;
                color: #10b981;
                margin-bottom: 1.5rem;
                display: block;
                opacity: 0.8;
            }

            .empty-state h4 {
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

            .btn-browse-tests {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                background: linear-gradient(135deg, #10b981, #14b8a6);
                color: #fff;
                padding: 0.85rem 1.75rem;
                border-radius: 12px;
                text-decoration: none;
                font-weight: 700;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
            }

            .btn-browse-tests:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
            }

            @media (max-width: 992px) {
                .results-table th:nth-child(1) {
                    width: 25%;
                }

                .results-table th:nth-child(6) {
                    width: 20%;
                }
            }

            @media (max-width: 768px) {
                .table-card {
                    overflow-x: auto;
                }

                .results-table {
                    min-width: 800px;
                }

                .page-hero {
                    flex-direction: column;
                    text-align: center;
                }

                .options-grid {
                    grid-template-columns: 1fr;
                }

                .modal-content {
                    margin: 1rem;
                }

                .modal-body {
                    padding: 1rem;
                }
            }
        </style>

        <div class="results-container">
            <div class="page-hero">
                <div class="page-icon"><i class="fas fa-chart-line"></i></div>
                <div>
                    <h1 class="page-title">My Test Results</h1>
                    <p class="page-subtitle">Track your performance and review correct answers</p>
                </div>
            </div>

            <asp:Panel ID="pnlResults" runat="server">
                <div class="table-card">
                    <table class="results-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-file-alt"></i> Test Name</th>
                                <th><i class="fas fa-star"></i> Score</th>
                                <th><i class="fas fa-list"></i> Total</th>
                                <th><i class="fas fa-check"></i> Correct</th>
                                <th><i class="fas fa-times"></i> Wrong</th>
                                <th><i class="fas fa-eye"></i> Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptResults" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <span class="test-name">
                                                <%# Eval("Test_Name") %>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="score-badge">
                                                <%# Eval("Result_Score") %>
                                            </span>
                                        </td>
                                        <td>
                                            <%# Eval("Total_Questions") %>
                                        </td>
                                        <td class="correct">
                                            <%# Eval("CorrectAnswers") %>
                                        </td>
                                        <td class="wrong">
                                            <%# Eval("WrongAnswers") %>
                                        </td>
                                        <td>
                                            <button type="button" class="btn-view-answers"  onclick="showAnswers(<%# Eval("Result_ID") %>, '<%# Eval("Test_Name").ToString().Replace("'", "\\'") %>')">Show Answer </button>

                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="empty-state">
                    <i class="fas fa-chart-line"></i>
                    <h4>No results yet</h4>
                    <p>Take a mock interview to see your performance here.</p>
                    <a href="QuizList.aspx" class="btn-browse-tests">
                        <i class="fas fa-play"></i> Start Mock Interview
                    </a>
                </div>
            </asp:Panel>
        </div>

        <!-- Answer Modal -->
        <div id="answerModal" class="answer-modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">
                        <i class="fas fa-check-circle"></i>
                        <span id="modalTestName">Test Answers</span>
                    </h3>
                    <button type="button" class="btn-close-modal" onclick="closeModal()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body" id="modalBody">
                    <div class="loading-state">
                        <i class="fas fa-spinner"></i>
                        <p>Loading questions...</p>
                    </div>
                </div>
            </div>
        </div>

        <asp:HiddenField ID="hfTestQuestions" runat="server" />

        <script type="text/javascript">
            function showAnswers(testId, testName) {
                document.getElementById('modalTestName').textContent = testName + ' - Answers';
                document.getElementById('answerModal').style.display = 'block';
                document.body.style.overflow = 'hidden';

                // Show loading state
                document.getElementById('modalBody').innerHTML = `
                    <div class="loading-state">
                        <i class="fas fa-spinner"></i>
                        <p>Loading questions...</p>
                    </div>
                `;

                // Make AJAX call to get questions
                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'Results.aspx/GetTestQuestions', true);
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            try {
                                var response = JSON.parse(xhr.responseText);
                                var questions = JSON.parse(response.d);
                                displayQuestions(questions);
                            } catch (e) {
                                document.getElementById('modalBody').innerHTML = `
                                    <div class="loading-state">
                                        <i class="fas fa-exclamation-triangle" style="animation: none; color: #f87171;"></i>
                                        <p>Error loading questions. Please try again.</p>
                                    </div>
                                `;
                            }
                        } else {
                            document.getElementById('modalBody').innerHTML = `
                                <div class="loading-state">
                                    <i class="fas fa-exclamation-triangle" style="animation: none; color: #f87171;"></i>
                                    <p>Error loading questions. Please try again.</p>
                                </div>
                            `;
                        }
                    }
                };
                xhr.send(JSON.stringify({ testId: testId }));
            }

            function displayQuestions(questions) {
                if (!questions || questions.length === 0) {
                    document.getElementById('modalBody').innerHTML = `
                        <div class="loading-state">
                            <i class="fas fa-info-circle" style="animation: none; color: #fbbf24;"></i>
                            <p>No questions found for this test.</p>
                        </div>
                    `;
                    return;
                }

                var html = '';
                questions.forEach(function (q, index) {
                    var options = [
                        { label: 'A', text: q.OptionA },
                        { label: 'B', text: q.OptionB },
                        { label: 'C', text: q.OptionC },
                        { label: 'D', text: q.OptionD }
                    ];

                    html += `
                        <div class="question-item">
                            <div style="display: flex; align-items: flex-start;">
                                <span class="question-number">${index + 1}</span>
                                <span class="question-text">${q.Question_Text}</span>
                            </div>
                            <div class="options-grid">
                    `;

                    options.forEach(function (opt) {
                        var isCorrect = opt.label === q.CorrectOption;
                        html += `
                            <div class="option-item ${isCorrect ? 'correct-answer' : ''}">
                                <span class="option-label">${opt.label}</span>
                                <span>${opt.text}</span>
                                ${isCorrect ? '<span class="correct-badge"><i class="fas fa-check-circle"></i> Correct</span>' : ''}
                            </div>
                        `;
                    });

                    html += `
                            </div>
                        </div>
                    `;
                });

                document.getElementById('modalBody').innerHTML = html;
            }

            function closeModal() {
                document.getElementById('answerModal').style.display = 'none';
                document.body.style.overflow = 'auto';
            }

            // Close modal on clicking outside
            document.getElementById('answerModal').addEventListener('click', function (e) {
                if (e.target === this) {
                    closeModal();
                }
            });

            // Close modal on Escape key
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    closeModal();
                }
            });
        </script>

    </asp:Content>

<%@ Page Title="Attempt Test" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="QuizAttempt.aspx.cs"
    Inherits="interview_questions.User.QuizAttempt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

 <link href="../Styles/Style.css" rel="stylesheet" />

    <!-- QUIZ HEADER -->
    <div class="quiz-header">
        <div class="quiz-title">
            <i class="fas fa-clipboard-list"></i>
            <asp:Label ID="lblTestName" runat="server" Text="Test Name"></asp:Label>
        </div>

        <div class="quiz-meta">
            <div class="timer-badge">
                <i class="fas fa-clock"></i>
                <asp:Label ID="lblTimer" runat="server" Text="Time Remaining"></asp:Label>
            </div>

            <div class="progress-indicator">
                <i class="fas fa-tasks"></i>
                <span>Answer all questions</span>
            </div>
        </div>
    </div>

    <!-- QUESTIONS -->
    <asp:Repeater ID="rptQuestions" runat="server">
        <ItemTemplate>
            <div class="question-card">

                <div class="question-header">
                    <div class="question-number">
                        <%# Container.ItemIndex + 1 %>
                    </div>

                    <div class="question-text">
                        <%# Eval("Question_Text") %>
                    </div>
                </div>

                <div class="options-container">

                    <label class="option-label">
                        <asp:RadioButton ID="rbA" runat="server"
                            GroupName='<%# "q" + Eval("Question_ID") %>' />
                        <span class="option-text"><%# Eval("OptionA") %></span>
                    </label>

                    <label class="option-label">
                        <asp:RadioButton ID="rbB" runat="server"
                            GroupName='<%# "q" + Eval("Question_ID") %>' />
                        <span class="option-text"><%# Eval("OptionB") %></span>
                    </label>

                    <label class="option-label">
                        <asp:RadioButton ID="rbC" runat="server"
                            GroupName='<%# "q" + Eval("Question_ID") %>' />
                        <span class="option-text"><%# Eval("OptionC") %></span>
                    </label>

                    <label class="option-label">
                        <asp:RadioButton ID="rbD" runat="server"
                            GroupName='<%# "q" + Eval("Question_ID") %>' />
                        <span class="option-text"><%# Eval("OptionD") %></span>
                    </label>

                </div>

                <asp:HiddenField ID="hfQuestionId" runat="server" Value='<%# Eval("Question_ID") %>' />

            </div>
        </ItemTemplate>
    </asp:Repeater>

    <!-- SUBMIT SECTION -->
    <div class="submit-section">
        <div class="submit-info">
            <i class="fas fa-info-circle"></i>
            <span>Make sure you've answered all questions before submitting</span>
        </div>

        <asp:LinkButton ID="btnSubmitTest" runat="server"
            CssClass="btn-submit"
            OnClick="btnSubmitTest_Click"
            OnClientClick="return confirm('Are you sure you want to submit the test?');"
            Text="<i class='fas fa-paper-plane'></i> <span>Submit Test</span>">
        </asp:LinkButton>

    </div>

    <!-- RESULT -->
    <asp:Panel ID="pnlResult" runat="server" Visible="false" CssClass="result-message">
        <i class="fas fa-check-circle" style="font-size: 2rem; color: #10b981;"></i>
        <div class="result-text">
            <asp:Label ID="lblResultMsg" runat="server"></asp:Label>
        </div>
    </asp:Panel>

</asp:Content>

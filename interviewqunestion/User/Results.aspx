<%@ Page Title="My Results" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Results.aspx.cs"
    Inherits="interviewquestion.User.Results" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Styles/Style.css" accesskey="stylesheet" rel="stylesheet" />

    <!-- Header -->
    <div class="page-header">
        <i class="fas fa-chart-line"></i>
        <h3>My Test Results</h3>
    </div>

    <!-- Results Table -->
    <div class="table-wrapper">
        <asp:GridView ID="gvResults" runat="server"
            AutoGenerateColumns="False"
            OnRowDataBound="gvResults_RowDataBound"
            CssClass="table results-table"
            ShowHeaderWhenEmpty="True"
            EmptyDataText="">

            <Columns>

               
               
                <asp:TemplateField HeaderText="Test">
                    <ItemTemplate>
                        <div class="test-name-cell">
                            <i class="fas fa-file-alt"></i>
                            <asp:Label ID="lblTestName" runat="server"></asp:Label>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>

             
                <asp:TemplateField HeaderText="Score">
                    <ItemTemplate>
                        <span class="score-chip">
                            <i class="fas fa-star"></i>
                            <asp:Label ID="lblScore" runat="server"></asp:Label>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="Total Qs">
                    <ItemTemplate>
                        <asp:Label ID="lblTotal" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="Correct">
                    <ItemTemplate>
                        <span class="td-correct">
                            <asp:Label ID="lblCorrect" runat="server"></asp:Label>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>

               
                <asp:TemplateField HeaderText="Wrong">
                    <ItemTemplate>
                        <span class="td-wrong">
                            <asp:Label ID="lblWrong" runat="server"></asp:Label>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

            
            <EmptyDataTemplate>
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
            </EmptyDataTemplate>

        </asp:GridView>
    </div>

</asp:Content>

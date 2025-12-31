using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.Admin
{
    public partial class AssignQuestions : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTests();
            }
        }

        // Load all tests into dropdown
        private void LoadTests()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Tests", null);
                ddlTest.DataSource = dt;
                ddlTest.DataTextField = "Test_Name";
                ddlTest.DataValueField = "Test_ID";
                ddlTest.DataBind();
                ddlTest.Items.Insert(0, new ListItem("-- Select a Test --", ""));
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading tests: " + ex.Message, false);
            }
        }

        // When test is selected, load questions
        protected void ddlTest_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlTest.SelectedValue))
            {
                LoadAvailableQuestions();
                LoadAssignedQuestions();
            }
            else
            {
                gvAllQuestions.DataSource = null;
                gvAllQuestions.DataBind();
                gvAssigned.DataSource = null;
                gvAssigned.DataBind();
            }
        }

        // Load questions NOT assigned to selected test
        private void LoadAvailableQuestions()
        {
            try
            {
                int testId = Convert.ToInt32(ddlTest.SelectedValue);
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters.Add("@p_Test_ID", testId);

                DataTable dt = db.ExeSP("sp_GetAvailable_Questions", parameters);
                gvAllQuestions.DataSource = dt;
                gvAllQuestions.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading available questions: " + ex.Message, false);
            }
        }

        // Load questions assigned to selected test
        private void LoadAssignedQuestions()
        {
            try
            {
                int testId = Convert.ToInt32(ddlTest.SelectedValue);
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters.Add("@p_Test_ID", testId);

                DataTable dt = db.ExeSP("sp_GetAssigned_Questions", parameters);
                gvAssigned.DataSource = dt;
                gvAssigned.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading assigned questions: " + ex.Message, false);
            }
        }

        // Assign question to test
        protected void gvAllQuestions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Assign")
            {
                try
                {
                    int questionId = Convert.ToInt32(e.CommandArgument);
                    int testId = Convert.ToInt32(ddlTest.SelectedValue);

                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_Test_ID", testId);
                    parameters.Add("@p_Question_ID", questionId);

                    db.ExeSP("sp_Assign_Question", parameters);
                    ShowMessage("Question assigned successfully!", true);

                    // Refresh both grids
                    LoadAvailableQuestions();
                    LoadAssignedQuestions();
                }
                catch (Exception ex)
                {
                    ShowMessage("Error assigning question: " + ex.Message, false);
                }
            }
        }

        // Remove question from test
        protected void gvAssigned_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                try
                {
                    int tqId = Convert.ToInt32(e.CommandArgument);

                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_TQ_ID", tqId);

                    db.ExeSP("sp_Remove_AssignedQuestion", parameters);
                    ShowMessage("Question removed from test successfully!", true);

                    // Refresh both grids
                    LoadAvailableQuestions();
                    LoadAssignedQuestions();
                }
                catch (Exception ex)
                {
                    ShowMessage("Error removing question: " + ex.Message, false);
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMsg.Text = message;
            lblMsg.CssClass = isSuccess ? "alert alert-success" : "alert alert-danger";
            lblMsg.Visible = true;
        }
    }
}

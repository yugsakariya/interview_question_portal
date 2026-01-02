using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.User
{
    public partial class QuizList : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/Account/Login.aspx");
                    return;
                }

                LoadTests();
            }
        }

        private void LoadTests()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_User_ID"] = userId;

                // Use the new SP that includes completion status
                DataTable dt = db.ExeSP("sp_GetTestsWithStatus_ForUser", parameters);

                if (dt != null && dt.Rows.Count > 0)
                {
                    // Bind to Repeater
                    rptTests.DataSource = dt;
                    rptTests.DataBind();


                    // Count only available (not completed) tests
                    int availableCount = 0;
                    foreach (DataRow row in dt.Rows)
                    {
                        if (Convert.ToInt32(row["IsCompleted"]) == 0)
                            availableCount++;
                    }
                    
                    lblTestCount.Text = availableCount + " Test" + (availableCount != 1 ? "s" : "") + " Available";
                }
                else
                {
                    lblTestCount.Text = "0 Tests Available";
                    rptTests.DataSource = null;
                    rptTests.DataBind();

                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading tests: " + ex.Message);
            }
        }

        // Helper method for Repeater to check completion status
        protected bool IsTestCompleted(object isCompleted)
        {
            if (isCompleted != null && isCompleted != DBNull.Value)
            {
                return Convert.ToInt32(isCompleted) == 1;
            }
            return false;
        }

        // Helper method to get button text
        protected string GetButtonText(object isCompleted)
        {
            return IsTestCompleted(isCompleted) ? "Completed" : "Start Test";
        }

        // Helper method to get button CSS class
        protected string GetButtonClass(object isCompleted)
        {
            return IsTestCompleted(isCompleted) ? "btn-completed" : "btn-start";
        }
    }
}
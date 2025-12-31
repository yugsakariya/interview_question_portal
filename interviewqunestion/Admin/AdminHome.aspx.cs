using System;
using System.Data;
using System.Web.UI;
using DataLayer;

namespace interview_questions.Admin
{
    public partial class AdminHome : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardStats();
            }
        }

        private void LoadDashboardStats()
        {
            try
            {
                // Total Users
                DataTable dtUsers = db.ExeSP("sp_GetTotalUsersCount", null);
                if (dtUsers != null && dtUsers.Rows.Count > 0)
                    lblUsers.Text = dtUsers.Rows[0]["TotalUsers"].ToString();

                // Total Questions
                DataTable dtQuestions = db.ExeSP("sp_GetTotalQuestionsCount", null);
                if (dtQuestions != null && dtQuestions.Rows.Count > 0)
                    lblQuestions.Text = dtQuestions.Rows[0]["TotalQuestions"].ToString();

                // Total Tests
                DataTable dtTests = db.ExeSP("sp_GetTotalTestsCount", null);
                if (dtTests != null && dtTests.Rows.Count > 0)
                    lblTests.Text = dtTests.Rows[0]["TotalTests"].ToString();

                // Total Attempts
                DataTable dtAttempts = db.ExeSP("sp_GetTotalAttemptsCount", null);
                if (dtAttempts != null && dtAttempts.Rows.Count > 0)
                    lblAttempts.Text = dtAttempts.Rows[0]["TotalAttempts"].ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading dashboard stats: " + ex.Message);
            }
        }
    }
}

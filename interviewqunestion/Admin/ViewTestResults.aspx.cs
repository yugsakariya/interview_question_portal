using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.Admin
{
    public partial class ViewTestResults : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadResults();
                LoadStatistics();
            }
        }

        // Load all test results
        private void LoadResults()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_TestResults", null);
                gvResults.DataSource = dt;
                gvResults.DataBind();
            }
            catch (Exception ex)
            {
                // Handle error gracefully
                System.Diagnostics.Debug.WriteLine("Error loading results: " + ex.Message);
            }
        }

        // Load summary statistics
        private void LoadStatistics()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetTestResults_Statistics", null);
                if (dt != null && dt.Rows.Count > 0)
                {
                    lblTotalAttempts.Text = dt.Rows[0]["TotalAttempts"].ToString();
                    lblAvgScore.Text = dt.Rows[0]["AvgScore"].ToString() + "%";
                    lblUniqueUsers.Text = dt.Rows[0]["UniqueUsers"].ToString();
                }
            }
            catch (Exception ex)
            {
                // Handle error gracefully
                System.Diagnostics.Debug.WriteLine("Error loading statistics: " + ex.Message);
            }
        }

        // Returns CSS class string for the score badge
        protected string GetScoreClass(object scoreObj, object totalObj)
        {
            int percentage = CalculatePercentage(scoreObj, totalObj);
            
            if (percentage >= 80)
                return "score-badge score-excellent";
            else if (percentage >= 60)
                return "score-badge score-good";
            else if (percentage >= 40)
                return "score-badge score-average";
            else
                return "score-badge score-poor";
        }

        // Returns percentage as integer string (without the '%' symbol)
        protected string GetScorePercentage(object scoreObj, object totalObj)
        {
            return CalculatePercentage(scoreObj, totalObj).ToString();
        }

        // Helper: safely compute percentage (0-100) from score and total
        private int CalculatePercentage(object scoreObj, object totalObj)
        {
            try
            {
                int score = Convert.ToInt32(scoreObj);
                int total = Convert.ToInt32(totalObj);
                
                if (total == 0) return 0;
                return (int)Math.Round((double)score / total * 100);
            }
            catch
            {
                return 0;
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.Admin
{
    public partial class AdminHome : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserCount();
            }
        }

        private void LoadUserCount()
        {
            try
            {
                // Create parameters dictionary (empty if no parameters needed)
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();

                // Execute stored procedure to get user count
                dt = db.ExeSP("sp_GetAll_Users", parameters);

                // Bind data to label
                if (dt != null && dt.Rows.Count > 0)
                {
                    int totalUsers = Convert.ToInt32(dt.Rows[0]["TotalUsers"]);
                    lblUsers.Text = totalUsers.ToString();
                }
                else
                {
                    lblUsers.Text = "0";
                }
            }
            catch (Exception ex)
            {
                // Log error (optional)
                System.Diagnostics.Debug.WriteLine("Error loading user count: " + ex.Message);
                lblUsers.Text = "0";
            }
        }
    }
}
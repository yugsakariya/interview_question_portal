using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
using System.Data;

namespace interview_questions.User
{
    public partial class Dashboard : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
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

                int userId = Convert.ToInt32(Session["UserID"]);
                LoadDashboardStats(userId);
            }
        }

        private void LoadDashboardStats(int userId)
        {
            try
            {
                Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
                para["@p_User_ID"] = userId;

                // Get tests attempted count
                dt = db.ExeSP("sp_GetUserTestAttemptCount", para);
                if (dt != null && dt.Rows.Count > 0)
                {
                    lblTests.Text = dt.Rows[0]["TestCount"].ToString();
                }
                else
                {
                    lblTests.Text = "0";
                }

                // Get bookmarks count
                para.Clear();
                para["@p_User_ID"] = userId;
                dt = db.ExeSP("sp_GetUserBookmarkCount", para);
                if (dt != null && dt.Rows.Count > 0)
                {
                    lblBookmarks.Text = dt.Rows[0]["BookmarkCount"].ToString();
                }
                else
                {
                    lblBookmarks.Text = "0";
                }

                // Get user name for welcome message
                para.Clear();
                para["@p_User_ID"] = userId;
                dt = db.ExeSP("sp_Get_User_ByID", para);
                if (dt != null && dt.Rows.Count > 0)
                {
                    lblUser.Text = dt.Rows[0]["User_FirstName"].ToString();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Dashboard error: " + ex.Message);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using DataLayer;

namespace interviewquestion.User
{
    public partial class Results : System.Web.UI.Page
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

                LoadResults();
            }
        }

        private void LoadResults()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_User_ID"] = userId;

                DataTable dt = db.ExeSP("sp_GetTestResults_ByUserID", parameters);
                
                if (dt != null && dt.Rows.Count > 0)
                {
                    rptResults.DataSource = dt;
                    rptResults.DataBind();
                    pnlResults.Visible = true;
                    pnlEmpty.Visible = false;
                }
                else
                {
                    pnlResults.Visible = false;
                    pnlEmpty.Visible = true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading results: " + ex.Message);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DataLayer;

namespace interviewqunestion
{
    public partial class Site : System.Web.UI.MasterPage
    {
        DataTable dt = new DataTable();
        DBHelper db = new DBHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }
            
            if (!IsPostBack)
            {
                string userID = Session["UserID"].ToString();
                Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
                para["@p_User_ID"] = Convert.ToInt32(userID);
                dt = db.ExeSP("sp_Get_User_ByID", para);

                if (dt != null && dt.Rows.Count > 0)
                {
                    lblUser.Text = dt.Rows[0]["User_FirstName"].ToString() + " " + dt.Rows[0]["User_LastName"].ToString();
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Account/Login.aspx");
        }
    }
}
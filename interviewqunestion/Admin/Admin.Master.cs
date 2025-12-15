using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
using System.Data;
namespace interviewqunestion.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        DataTable dt = new DataTable();
        DBHelper db = new DBHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminID"] == null)
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }
            string adminID = Session["AdminID"] as String;
            Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
            para["@p_Admin_ID"] = adminID;
            dt = db.ExeSP("sp_Get_admin_ByID", para);

            lblUser.Text = dt.Rows[0]["Admin_Name"].ToString();
            lblUserInitial.Text = lblUser.Text[0].ToString().ToUpper();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Account/Login.aspx");
        }
    }
}
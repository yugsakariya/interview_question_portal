using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DataLayer;
using System.Net;

namespace interviewqunestion.Account
{
    public partial class Login : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role = ddlRole.SelectedValue;
            string username = txtEmail.Text;
            string password = txtPassword.Text;
            DataLayer.DBHelper db = new DataLayer.DBHelper();
            Dictionary<string, dynamic> parametres = new Dictionary<string, dynamic>();
            parametres["@p_Email"] = username;
            parametres["@p_Password"] = password;
            if (role == "User")
            {
                dt = db.ExeSP("sp_UserLogin", parametres);
                if (dt.Rows.Count > 0)
                {

                    Session["UserID"] = dt.Rows[0]["User_ID"].ToString();
                    //Session["Email"] = dt.Rows[0]["User_EmailID"].ToString();
                    Session["Role"] = role;
                    //pnlError.Visible = true;
                    //string userId = Session["UserID"] as String;
                    //string User_EmailID = Session["Email"] as String;
                    Response.Redirect("~/User/Dashboard.aspx");
                }
                else
                {
                    pnlError.Visible = true;
                    lblMsg.Text = "Invalid username or password.";
                }
            }
            if (role == "Admin")
            {
                dt = db.ExeSP("sp_AdminLogin", parametres);
                if (dt.Rows.Count > 0)
                {
                    Session["AdminID"] = dt.Rows[0]["Admin_ID"].ToString();
                    //Session["Email"] = dt.Rows[0]["Admin_EmailID"].ToString();
                    Session["Role"] = role;
                    Response.Redirect("~/Admin/AdminHome.aspx");
                }
                else
                {
                    pnlError.Visible = true;
                    lblMsg.Text = "Invalid username or password.";
                }
            }

        }
    }
}
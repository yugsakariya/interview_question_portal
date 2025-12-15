using DataLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace interviewqunestion.Account
{
    public partial class Register : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string f_name = txtFirstName.Text;
            string l_name = txtLastName.Text;
            string email = txtEmail.Text;
            string pass = txtPassword.Text;
            DataLayer.DBHelper db = new DataLayer.DBHelper();

            // Check if email already exists
            Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
            para["@p_Email"] = email;
            dt = db.ExeSP("sp_Check_User_Exists", para);

            if (dt != null && dt.Rows.Count > 0)
            {
                pnlSuccess.Visible = true;
                lblMsg.Text = "Email ID already exists. Please use a different email.";
                return;
            }

            // Insert new user WITHOUT passing the date
            Dictionary<string, dynamic> parametres = new Dictionary<string, dynamic>();
            parametres["@User_FirstName"] = f_name;
            parametres["@User_LastName"] = l_name;
            parametres["@User_EmailID"] = email;
            parametres["@User_Password"] = pass;

            dt = db.ExeSP("sp_Insert_User", parametres);

            if (dt != null && dt.Rows.Count > 0)
            {
                Session["UserID"] = dt.Rows[0]["User_ID"].ToString();
                pnlSuccess.Visible = true;
                lblMsg.Text = "Registration successful! Redirecting...";
                Response.Redirect("~/User/Dashboard.aspx");
            }
            else
            {
                pnlSuccess.Visible = true;
                lblMsg.Text = "Registration failed. Please try again.";
            }
        }
    }
}
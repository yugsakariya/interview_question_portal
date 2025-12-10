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
            Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
            para["@p_Email"] = email;
            dt = db.ExeSP("sp_Check_User_Exists", para);
            if (dt != null)
            {
                pnlSuccess.Visible = true;
                lblMsg.Text = "Email ID already exists. Please use a different email.";
                return;
            }
            Dictionary<string, dynamic> parametres = new Dictionary<string, dynamic>();
            parametres["@p_FirstName"] = f_name;
            parametres["@p_LastName"] = l_name;
            parametres["@p_EmailID"] = email;
            parametres["@p_Password"] = pass;
            dt = db.ExeSP("sp_UserRegister", parametres);

            if (dt != null)
            {
                Session["UserID"] = dt.Rows[0]["User_ID"].ToString();
                //Session["Email"] = dt.Rows[0]["User_EmailID"].ToString();
                //Session["Role"] = role;
                //pnlError.Visible = true;
                //string userId = Session["UserID"] as String;
                //string User_EmailID = Session["Email"] as String;
                Response.Redirect("~/User/Dashboard.aspx");
            }
        }
    }
}
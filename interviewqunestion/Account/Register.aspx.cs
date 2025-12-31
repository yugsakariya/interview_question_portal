using DataLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.Services;
using BCrypt.Net;

namespace interviewqunestion.Account
{
    public partial class Register : System.Web.UI.Page
    {
        [WebMethod]
        public static bool CheckEmailExists(string email)
        {
            DataLayer.DBHelper db = new DataLayer.DBHelper();
            Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
            para["@p_Email"] = email;
            DataTable dtExists = db.ExeSP("sp_Check_User_Exists", para);
            return dtExists != null && dtExists.Rows.Count > 0;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string f_name = hfFirstName.Value;
            string l_name = hfLastName.Value;
            string email = hfEmail.Value;
            string pass = hfPassword.Value;

            // Hash the password
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(pass);

            DataLayer.DBHelper db = new DataLayer.DBHelper();

            // Perform Registration with hashed password
            Dictionary<string, dynamic> parametres = new Dictionary<string, dynamic>();
            parametres["@p_FirstName"] = f_name;
            parametres["@p_LastName"] = l_name;
            parametres["@p_EmailID"] = email;
            parametres["@p_Password"] = hashedPassword;

            DataTable dtReg = db.ExeSP("sp_UserRegister", parametres);

            if (dtReg != null && dtReg.Rows.Count > 0)
            {
                Session["UserID"] = dtReg.Rows[0]["User_ID"].ToString();
                Response.Redirect("~/User/Dashboard.aspx");
            }
            else
            {
                ShowTerminalError("System failure during data write. Try again later.");
            }
        }

        private void ShowTerminalError(string message)
        {
            // Wrap in setTimeout to ensure the custom print function is defined before calling it
            // This prevents the browser's native window.print() from being called
            string script = $"setTimeout(function() {{ if(typeof print === 'function') {{ print('{message}', 'text-red'); step='firstName'; input.disabled=false; input.type='text'; enableInput(); }} }}, 100);";
            ClientScript.RegisterStartupScript(this.GetType(), "TerminalError", script, true);
        }
    }
}
using DataLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;

namespace interviewqunestion.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Retrieve values from HiddenFields instead of old TextBoxes
            string f_name = hfFirstName.Value;
            string l_name = hfLastName.Value;
            string email = hfEmail.Value;
            string pass = hfPassword.Value;

            DataLayer.DBHelper db = new DataLayer.DBHelper();

            //[cite_start]// Check if user exists [cite: 121]
                        // Remove the invalid attribute marker "[cite_start]" from the following line
                        // [cite_start]// Check if user exists [cite: 121]
                        // Check if user exists [cite: 121]
            Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
            para["@p_Email"] = email;
            DataTable dtExists = db.ExeSP("sp_Check_User_Exists", para);

            if (dtExists != null && dtExists.Rows.Count > 0)
            {
                ShowTerminalError("Fatal: Email ID already in system. Access denied.");
                return;
            }

            // Perform Registration
            Dictionary<string, dynamic> parametres = new Dictionary<string, dynamic>();
            parametres["@p_FirstName"] = f_name;
            parametres["@p_LastName"] = l_name;
            parametres["@p_EmailID"] = email;
            parametres["@p_Password"] = pass;

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
            // Sends the error back to the terminal UI and resets the input
            string script = $"print('{message}', 'text-red-500'); step='firstName'; input.disabled=false; input.type='text';";
            ClientScript.RegisterStartupScript(this.GetType(), "TerminalError", script, true);
        }
    }
}
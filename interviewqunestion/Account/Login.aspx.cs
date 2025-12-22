using DataLayer; // Ensure this matches your project's data layer
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace interviewqunestion.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Page Load logic (if any)
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // 1. Retrieve values from HiddenFields (populated by Terminal JS)
            // or if you kept the IDs the same, ensure they match the UI inputs.
            string role = hfRole.Value;
            string username = hfEmail.Value;
            string password = hfPassword.Value;

            // Basic validation check
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowTerminalError("Authentication Failed: Empty credentials.");
                return;
            }

            DBHelper db = new DBHelper();
            Dictionary<string, dynamic> parametres = new Dictionary<string, dynamic>();
            parametres["@p_Email"] = username;
            parametres["@p_Password"] = password;

            DataTable dt = new DataTable();

            try
            {
                if (role == "User")
                {
                    dt = db.ExeSP("sp_UserLogin", parametres);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        Session["UserID"] = dt.Rows[0]["User_ID"].ToString();
                        Session["Role"] = role;
                        Response.Redirect("~/User/Dashboard.aspx");
                    }
                    else
                    {
                        ShowTerminalError("Access Denied: Invalid User credentials.");
                    }
                }
                else if (role == "Admin")
                {
                    dt = db.ExeSP("sp_AdminLogin", parametres);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        Session["AdminID"] = dt.Rows[0]["Admin_ID"].ToString();
                        Session["Role"] = role;
                        Response.Redirect("~/Admin/AdminHome.aspx");
                    }
                    else
                    {
                        ShowTerminalError("Access Denied: Invalid Admin credentials.");
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle database or connection errors
                ShowTerminalError("System Error: Handshake failed. Please try again.");
            }
        }

        /// <summary>
        /// Sends a command back to the Terminal UI to display an error message
        /// </summary>
        private void ShowTerminalError(string message)
        {
            // Optional: Keeps your old Panel visible for backup
            //pnlError.Visible = true;
            //lblMsg.Text = message;

            // Injects JavaScript to print the error directly into the terminal window
            string script = $"print('{message}', 'text-red-500'); step='choice'; input.type='text';";
            ClientScript.RegisterStartupScript(this.GetType(), "TerminalError", script, true);
        }
    }
}
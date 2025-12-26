using DataLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using BCrypt.Net;  // ← ADD THIS

namespace interviewqunestion.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role = hfRole.Value;
            string username = hfEmail.Value;
            string password = hfPassword.Value;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowTerminalError("Authentication Failed: Empty credentials.");
                return;
            }

            DBHelper db = new DBHelper();
            Dictionary<string, dynamic> parametres = new Dictionary<string, dynamic>();
            parametres["@p_Email"] = username;
            // REMOVED: parametres["@p_Password"] = password;

            DataTable dt = new DataTable();

            try
            {
                if (role == "User")
                {
                    dt = db.ExeSP("sp_GetUserByEmail", parametres);  // ← NEW SP
                    
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        string storedHash = dt.Rows[0]["Password"].ToString();
                        
                        // Verify password with BCrypt
                        if (BCrypt.Net.BCrypt.Verify(password, storedHash))
                        {
                            Session["UserID"] = dt.Rows[0]["User_ID"].ToString();
                            Session["Role"] = role;
                            Response.Redirect("~/User/Dashboard.aspx");
                        }
                        else
                        {
                            ShowTerminalError("Access Denied: Invalid password.");
                        }
                    }
                    else
                    {
                        ShowTerminalError("Access Denied: User not found.");
                    }
                }
                else if (role == "Admin")
                {
                    dt = db.ExeSP("sp_GetAdminByEmail", parametres);  // ← NEW SP
                    
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        string storedHash = dt.Rows[0]["Password"].ToString();
                        
                        // Verify password with BCrypt
                        if (BCrypt.Net.BCrypt.Verify(password, storedHash))
                        {
                            Session["AdminID"] = dt.Rows[0]["Admin_ID"].ToString();
                            Session["Role"] = role;
                            Response.Redirect("~/Admin/AdminHome.aspx");
                        }
                        else
                        {
                            ShowTerminalError("Access Denied: Invalid password.");
                        }
                    }
                    else
                    {
                        ShowTerminalError("Access Denied: Admin not found.");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowTerminalError("System Error: Handshake failed. Please try again.");
            }
        }

        private void ShowTerminalError(string message)
        {
            string script = $"print('{message}', 'text-red-500'); step='choice'; input.type='text';";
            ClientScript.RegisterStartupScript(this.GetType(), "TerminalError", script, true);
        }
    }
}
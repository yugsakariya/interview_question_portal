using DataLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using BCrypt.Net;

namespace interviewqunestion.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
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

            DataTable dt = new DataTable();

            try
            {
                // Get user by email (single stored procedure for all users)
                dt = db.ExeSP("sp_GetUserByEmail", parametres);

                if (dt != null && dt.Rows.Count > 0)
                {
                    string storedHash = dt.Rows[0]["User_Password"].ToString();
                    string userRole = dt.Rows[0]["User_Role"].ToString();
                    string userId = dt.Rows[0]["User_ID"].ToString();

                    bool isAuthenticated = false;

                    // For Admin: use plain text comparison (no hashing)
                    // For Users: use BCrypt verification
                    if (userRole == "Admin")
                    {
                        // Plain text comparison for admin
                        isAuthenticated = (password == storedHash);
                    }
                    else
                    {
                        // BCrypt verification for regular users
                        isAuthenticated = BCrypt.Net.BCrypt.Verify(password, storedHash);
                    }

                    if (isAuthenticated)
                    {
                        Session["UserID"] = userId;
                        Session["Role"] = userRole;

                        // Redirect based on role
                        if (userRole == "Admin")
                        {
                            Session["AdminID"] = userId;
                            Response.Redirect("~/Admin/AdminHome.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                        }
                        else
                        {
                            Response.Redirect("~/User/Dashboard.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                        }
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
            catch (Exception ex)
            {
                ShowTerminalError("System Error: " + ex.Message);
            }
        }

        private void ShowTerminalError(string message)
        {
            string script = $"print('{message}', 'text-red-500'); step='choice'; input.type='text';";
            ClientScript.RegisterStartupScript(this.GetType(), "TerminalError", script, true);
        }
    }
}
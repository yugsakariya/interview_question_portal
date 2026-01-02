using DataLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.Services;
using BCrypt.Net;

namespace interviewqunestion.Account
{
    public partial class Login : System.Web.UI.Page
    {
        private DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = hfEmail.Value?.Trim();
            string password = hfPassword.Value;

            // Step 1: Validate empty fields
            if (string.IsNullOrEmpty(email))
            {
                ShowTerminalError("Validation Error: Email address is required.");
                return;
            }

            if (string.IsNullOrEmpty(password))
            {
                ShowTerminalError("Validation Error: Password is required.");
                return;
            }

            // Step 2: Validate email format
            if (!IsValidEmail(email))
            {
                ShowTerminalError("Validation Error: Invalid email format.");
                return;
            }

            // Step 3: Check if user exists in database
            DataTable userData = GetUserByEmail(email);
            
            if (userData == null || userData.Rows.Count == 0)
            {
                ShowTerminalError("Access Denied: No account found with this email.");
                return;
            }

            // Step 4: Get user data
            DataRow user = userData.Rows[0];
            string storedHash = user["User_Password"]?.ToString();
            string userRole = user["User_Role"]?.ToString();
            string userId = user["User_ID"]?.ToString();

            // Step 5: Validate stored password exists
            if (string.IsNullOrEmpty(storedHash))
            {
                ShowTerminalError("System Error: Account configuration error. Contact admin.");
                return;
            }

            // Step 6: Verify password based on role
            bool isAuthenticated = VerifyPassword(password, storedHash, userRole);

            if (!isAuthenticated)
            {
                ShowTerminalError("Access Denied: Incorrect password.");
                return;
            }

            // Step 7: Set session and redirect
            try
            {
                Session["UserID"] = userId;
                Session["Role"] = userRole;

                if (userRole == "Admin")
                {
                    Session["AdminID"] = userId;
                    Response.Redirect("~/Admin/AdminHome.aspx", false);
                }
                else
                {
                    Response.Redirect("~/User/Dashboard.aspx", false);
                }
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                ShowTerminalError("System Error: Failed to create session. " + ex.Message);
            }
        }

        // Helper: Validate email format using regex
        private bool IsValidEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            return Regex.IsMatch(email, pattern);
        }

        // Helper: Get user from database by email
        private DataTable GetUserByEmail(string email)
        {
            try
            {
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_Email"] = email;
                return db.ExeSP("sp_GetUserByEmail", parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Database Error: " + ex.Message);
                return null;
            }
        }

        // Helper: Verify password based on user role
        private bool VerifyPassword(string inputPassword, string storedHash, string userRole)
        {
            try
            {
                if (userRole == "Admin")
                {
                    // Plain text comparison for admin (legacy support)
                    return inputPassword == storedHash;
                }
                else
                {
                    // BCrypt verification for regular users
                    return BCrypt.Net.BCrypt.Verify(inputPassword, storedHash);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Password verification error: " + ex.Message);
                return false;
            }
        }

        // Helper: Show error in terminal UI
        private void ShowTerminalError(string message)
        {
            // Escape single quotes for JavaScript
            string escapedMessage = message.Replace("'", "\\'");
            string script = $"print('{escapedMessage}', 'text-red'); step='choice'; input.type='text';";
            ClientScript.RegisterStartupScript(this.GetType(), "TerminalError", script, true);
        }

        // WebMethod: Check if email exists in database (called via AJAX)
        [WebMethod]
        public static object CheckEmailExists(string email)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(email))
                {
                    return new { success = false, message = "Email address is required." };
                }

                // Validate email format
                string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                if (!Regex.IsMatch(email, pattern))
                {
                    return new { success = false, message = "Invalid email format." };
                }

                // Check database
                DBHelper db = new DBHelper();
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_Email"] = email.Trim();
                DataTable userData = db.ExeSP("sp_GetUserByEmail", parameters);

                if (userData == null || userData.Rows.Count == 0)
                {
                    return new { success = false, message = "No account found with this email." };
                }

                // Email exists - return success with user role for UI hints
                DataRow user = userData.Rows[0];
                string userRole = user["User_Role"]?.ToString();

                return new { success = true, message = "Email verified.", role = userRole };
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("CheckEmailExists Error: " + ex.Message);
                return new { success = false, message = "System error. Please try again." };
            }
        }

        // WebMethod: Verify credentials (called via AJAX for password validation)
        [WebMethod(EnableSession = true)]
        public static object VerifyCredentials(string email, string password)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
                {
                    return new { success = false, message = "Email and password are required." };
                }

                // Check database for user
                DBHelper db = new DBHelper();
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_Email"] = email.Trim();
                DataTable userData = db.ExeSP("sp_GetUserByEmail", parameters);

                if (userData == null || userData.Rows.Count == 0)
                {
                    return new { success = false, message = "No account found with this email." };
                }

                // Get user data
                DataRow user = userData.Rows[0];
                string storedHash = user["User_Password"]?.ToString();
                string userRole = user["User_Role"]?.ToString();
                string userId = user["User_ID"]?.ToString();

                if (string.IsNullOrEmpty(storedHash))
                {
                    return new { success = false, message = "Account configuration error. Contact admin." };
                }

                // Verify password based on role
                bool isAuthenticated = false;
                if (userRole == "Admin")
                {
                    // Plain text comparison for admin (legacy support)
                    isAuthenticated = password == storedHash;
                }
                else
                {
                    // BCrypt verification for regular users
                    try
                    {
                        isAuthenticated = BCrypt.Net.BCrypt.Verify(password, storedHash);
                    }
                    catch
                    {
                        isAuthenticated = false;
                    }
                }

                if (!isAuthenticated)
                {
                    return new { success = false, message = "Incorrect password." };
                }

                // Set session variables
                System.Web.HttpContext.Current.Session["UserID"] = userId;
                System.Web.HttpContext.Current.Session["Role"] = userRole;

                // Determine redirect URL
                string redirectUrl = userRole == "Admin" ? "~/Admin/AdminHome.aspx" : "~/User/Dashboard.aspx";
                if (userRole == "Admin")
                {
                    System.Web.HttpContext.Current.Session["AdminID"] = userId;
                }

                return new { success = true, message = "Access granted.", redirectUrl = redirectUrl, role = userRole };
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("VerifyCredentials Error: " + ex.Message);
                return new { success = false, message = "System error. Please try again." };
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using DataLayer;

namespace interviewqunestion.User
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/Account/Login.aspx");
                    return;
                }
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate all fields are filled
                if (string.IsNullOrWhiteSpace(txtCurrentPassword.Text) ||
                    string.IsNullOrWhiteSpace(txtNewPassword.Text) ||
                    string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
                {
                    ShowError("Please fill in all required fields.");
                    return;
                }

                // Validate new password meets requirements
                if (!ValidatePasswordStrength(txtNewPassword.Text))
                {
                    ShowError("Password must be at least 8 characters long and contain uppercase, lowercase, number, and special character.");
                    return;
                }

                // Validate passwords match
                if (txtNewPassword.Text != txtConfirmPassword.Text)
                {
                    ShowError("New password and confirmation password do not match.");
                    return;
                }

                // Get current user
                int userId = Convert.ToInt32(Session["UserID"]);

                // Verify current password
                if (!VerifyCurrentPassword(userId, txtCurrentPassword.Text))
                {
                    ShowError("Current password is incorrect.");
                    return;
                }

                // Update password
                if (UpdatePassword(userId, txtNewPassword.Text))
                {
                    ShowSuccess("Password changed successfully! You will be redirected to your profile.");
                    
                    // Clear form fields
                    txtCurrentPassword.Text = string.Empty;
                    txtNewPassword.Text = string.Empty;
                    txtConfirmPassword.Text = string.Empty;

                    // Redirect after 2 seconds
                    Response.AddHeader("REFRESH", "2;URL=Profile.aspx");
                }
                else
                {
                    ShowError("An error occurred while updating your password. Please try again.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error changing password: " + ex.Message);
                ShowError("An unexpected error occurred. Please try again later.");
            }
        }

        private bool VerifyCurrentPassword(int userId, string currentPassword)
        {
            try
            {
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_User_ID"] = userId;

                DataTable dt = db.ExeSP("sp_Get_User_ByID", parameters);

                if (dt != null && dt.Rows.Count > 0)
                {
                    string storedPassword = dt.Rows[0]["User_Password"].ToString();
                    
                    // Use BCrypt.Verify to compare passwords (BCrypt hash includes salt)
                    return BCrypt.Net.BCrypt.Verify(currentPassword, storedPassword);
                }

                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error verifying password: " + ex.Message);
                return false;
            }
        }

        private bool UpdatePassword(int userId, string newPassword)
        {
            try
            {
                // First get the user's email
                Dictionary<string, dynamic> getUserParams = new Dictionary<string, dynamic>();
                getUserParams["@p_User_ID"] = userId;
                DataTable userDt = db.ExeSP("sp_Get_User_ByID", getUserParams);
                
                if (userDt == null || userDt.Rows.Count == 0)
                {
                    return false;
                }
                
                string userEmail = userDt.Rows[0]["User_Email"].ToString();

                // Use BCrypt to hash the new password (same as Register and Login)
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(newPassword);

                // Use the existing sp_UpdateUserPassword stored procedure
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_Email"] = userEmail;
                parameters["@p_NewPassword"] = hashedPassword;

                // Execute the stored procedure to update password
                db.ExeSP("sp_UpdateUserPassword", parameters);

                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error updating password: " + ex.Message);
                return false;
            }
        }

        private bool ValidatePasswordStrength(string password)
        {
            // Minimum 8 characters
            if (password.Length < 8)
                return false;

            // Check for uppercase
            bool hasUpperCase = false;
            bool hasLowerCase = false;
            bool hasDigit = false;
            bool hasSpecialChar = false;

            foreach (char c in password)
            {
                if (char.IsUpper(c)) hasUpperCase = true;
                if (char.IsLower(c)) hasLowerCase = true;
                if (char.IsDigit(c)) hasDigit = true;
                if (!char.IsLetterOrDigit(c)) hasSpecialChar = true;
            }

            return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;
        }

        private void ShowSuccess(string message)
        {
            pnlSuccess.Visible = true;
            pnlError.Visible = false;
            lblSuccess.Text = message;
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            pnlSuccess.Visible = false;
            lblError.Text = message;
        }
    }
}

using DataLayer;
using EmailLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Web.Caching;
using BCrypt.Net;

namespace interviewqunestion.Account
{
    public partial class Register : System.Web.UI.Page
    {
        // Cache key prefixes
        private const string OTP_CACHE_PREFIX = "RegOTP_";
        private const string COOLDOWN_CACHE_PREFIX = "RegCooldown_";
        private const int OTP_EXPIRY_MINUTES = 10;
        private const int COOLDOWN_SECONDS = 60;

        [WebMethod]
        public static bool CheckEmailExists(string email)
        {
            DataLayer.DBHelper db = new DataLayer.DBHelper();
            Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
            para["@p_Email"] = email;
            DataTable dtExists = db.ExeSP("sp_Check_User_Exists", para);
            return dtExists != null && dtExists.Rows.Count > 0;
        }

        [WebMethod]
        public static object SendVerificationOTP(string email)
        {
            try
            {
                string emailLower = email.ToLower();
                string cooldownKey = COOLDOWN_CACHE_PREFIX + emailLower;
                
                // Check cooldown - prevent spam requests
                object lastRequest = HttpRuntime.Cache[cooldownKey];
                if (lastRequest != null)
                {
                    DateTime lastTime = (DateTime)lastRequest;
                    int secondsRemaining = COOLDOWN_SECONDS - (int)(DateTime.Now - lastTime).TotalSeconds;
                    if (secondsRemaining > 0)
                    {
                        return new { success = false, message = $"Please wait {secondsRemaining} seconds before requesting again.", cooldown = true, seconds = secondsRemaining };
                    }
                }
                
                // Generate OTP
                string otp = EmailHelper.GenerateSecureOTP(6);
                
                // Store OTP in Cache with automatic expiry (10 minutes)
                string cacheKey = OTP_CACHE_PREFIX + emailLower;
                
                // Remove any existing OTP for this email
                HttpRuntime.Cache.Remove(cacheKey);
                
                // Add new OTP with absolute expiration (auto-removes after 10 minutes)
                HttpRuntime.Cache.Insert(
                    cacheKey,
                    otp,
                    null,
                    DateTime.Now.AddMinutes(OTP_EXPIRY_MINUTES),
                    Cache.NoSlidingExpiration,
                    CacheItemPriority.High,
                    null
                );
                
                // Send OTP via email
                bool emailSent = EmailHelper.SendRegistrationVerificationOTP(email, otp);
                
                if (emailSent)
                {
                    // Set cooldown timer (prevents requesting again for 60 seconds)
                    HttpRuntime.Cache.Insert(
                        cooldownKey,
                        DateTime.Now,
                        null,
                        DateTime.Now.AddSeconds(COOLDOWN_SECONDS),
                        Cache.NoSlidingExpiration,
                        CacheItemPriority.Normal,
                        null
                    );
                    
                    return new { success = true, message = "OTP sent successfully" };
                }
                else
                {
                    // Remove from cache if email failed
                    HttpRuntime.Cache.Remove(cacheKey);
                    return new { success = false, message = "Failed to send email. Please try again." };
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"SendVerificationOTP Error: {ex.Message}");
                return new { success = false, message = "Error sending OTP. Please try again." };
            }
        }

        [WebMethod]
        public static object VerifyOTP(string email, string otp)
        {
            try
            {
                string cacheKey = OTP_CACHE_PREFIX + email.ToLower();
                
                // Get OTP from cache
                string storedOtp = HttpRuntime.Cache[cacheKey] as string;
                
                if (storedOtp == null)
                {
                    // OTP not found - either expired or never existed
                    return new { success = false, message = "OTP expired. Please request a new one." };
                }
                
                if (storedOtp == otp)
                {
                    // OTP is valid - remove it from cache immediately
                    HttpRuntime.Cache.Remove(cacheKey);
                    return new { success = true, message = "Email verified successfully" };
                }
                else
                {
                    return new { success = false, message = "Invalid OTP. Please try again." };
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"VerifyOTP Error: {ex.Message}");
                return new { success = false, message = "Verification failed. Please try again." };
            }
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


using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using DataLayer;

namespace EmailLayer
{
    /// <summary>
    /// Service class for handling all email-related operations
    /// </summary>
    public static class EmailHelper
    {
        /// <summary>
        /// Generates a cryptographically secure OTP of specified length
        /// </summary>
        public static string GenerateSecureOTP(int length = 6)
        {
            using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
            {
                byte[] randomBytes = new byte[4];
                rng.GetBytes(randomBytes);
                
                int randomInt = Math.Abs(BitConverter.ToInt32(randomBytes, 0));
                int minValue = (int)Math.Pow(10, length - 1);
                int maxValue = (int)Math.Pow(10, length) - 1;
                int otp = minValue + (randomInt % (maxValue - minValue + 1));
                
                return otp.ToString();
            }
        }

        /// <summary>
        /// Gets an application setting from the database
        /// </summary>
        private static string GetAppSetting(string key)
        {
            try
            {
                DBHelper db = new DBHelper();
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_Key"] = key;
                DataTable dt = db.ExeSP("sp_GetAppSetting", parameters);

                if (dt != null && dt.Rows.Count > 0)
                {
                    return dt.Rows[0]["SettingValue"]?.ToString();
                }
                return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("GetAppSetting Error: " + ex.Message);
                return null;
            }
        }

        /// <summary>
        /// Sends an OTP email for password reset
        /// </summary>
        public static bool SendPasswordResetOTP(string toEmail, string otp)
        {
            string subject = "Password Reset OTP - IQ Portal";
            string body = GetPasswordResetEmailBody(otp);
            return SendEmail(toEmail, subject, body);
        }

        /// <summary>
        /// Sends a welcome email to new users
        /// </summary>
        public static bool SendWelcomeEmail(string toEmail, string userName)
        {
            string subject = "Welcome to IQ Portal!";
            string body = GetWelcomeEmailBody(userName);
            return SendEmail(toEmail, subject, body);
        }

        /// <summary>
        /// Core email sending method
        /// </summary>
        public static bool SendEmail(string toEmail, string subject, string htmlBody)
        {
            try
            {
                // SMTP Configuration - Hardcoded credentials
                string smtpHost = "smtp.gmail.com";
                int smtpPort = 587;
                string smtpEmail = "interviewportal39@gmail.com";      // Replace with your Gmail address
                string smtpPassword = "ekyg sbqn ddli abmi";       // Replace with your Gmail App Password

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(smtpEmail, "IQ Portal");
                mail.To.Add(toEmail);
                mail.Subject = subject;
                mail.IsBodyHtml = true;
                mail.Body = htmlBody;

                SmtpClient smtp = new SmtpClient(smtpHost, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpEmail, smtpPassword);
                smtp.EnableSsl = true;
                smtp.Timeout = 30000;
                smtp.Send(mail);

                System.Diagnostics.Debug.WriteLine($"Email sent to: {toEmail}");
                return true;
            }
            catch (SmtpException smtpEx)
            {
                System.Diagnostics.Debug.WriteLine($"SMTP Error: {smtpEx.StatusCode} - {smtpEx.Message}");
                if (smtpEx.InnerException != null)
                {
                    System.Diagnostics.Debug.WriteLine($"Inner Exception: {smtpEx.InnerException.Message}");
                }
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"SendEmail Error: {ex.Message}");
                if (ex.InnerException != null)
                {
                    System.Diagnostics.Debug.WriteLine($"Inner Exception: {ex.InnerException.Message}");
                }
                return false;
            }
        }

        /// <summary>
        /// HTML template for password reset OTP email
        /// </summary>
        private static string GetPasswordResetEmailBody(string otp)
        {
            return $@"
<html>
<body style='font-family: Arial, sans-serif; background: #1a1a2e; color: #eee; padding: 20px;'>
<div style='max-width: 450px; margin: auto; background: #16213e; padding: 35px; border-radius: 16px; border: 1px solid #6366f1;'>
    <h2 style='color: #a5b4fc; text-align: center; margin-bottom: 10px;'>🎓 IQ Portal</h2>
    <p style='text-align: center; color: #9ca3af;'>Password Reset Request</p>
    
    <div style='background: linear-gradient(135deg, #0f3460, #1a1a2e); padding: 25px; border-radius: 12px; text-align: center; margin: 25px 0; border: 2px solid #6366f1;'>
        <p style='margin: 0 0 10px 0; color: #a5b4fc; font-size: 14px;'>Your OTP Code</p>
        <span style='font-size: 38px; font-weight: bold; letter-spacing: 8px; color: #fbbf24; text-shadow: 0 0 10px rgba(251,191,36,0.5);'>{otp}</span>
    </div>
    
    <p style='text-align: center; color: #9ca3af; font-size: 13px;'>⏰ Valid for <strong>10 minutes</strong></p>
    <p style='text-align: center; color: #ef4444; font-size: 12px; margin-top: 20px;'>⚠️ Never share this OTP with anyone</p>
</div>
</body>
</html>";
        }

        /// <summary>
        /// HTML template for welcome email
        /// </summary>
        private static string GetWelcomeEmailBody(string userName)
        {
            return $@"
<html>
<body style='font-family: Arial, sans-serif; background: #1a1a2e; color: #eee; padding: 20px;'>
<div style='max-width: 450px; margin: auto; background: #16213e; padding: 35px; border-radius: 16px; border: 1px solid #6366f1;'>
    <h2 style='color: #a5b4fc; text-align: center;'>🎓 Welcome to IQ Portal!</h2>
    
    <p style='color: #e5e7eb; font-size: 16px;'>Hello <strong>{userName}</strong>,</p>
    
    <p style='color: #9ca3af;'>Thank you for joining IQ Portal - your gateway to mastering interview questions!</p>
    
    <div style='background: #0f3460; padding: 20px; border-radius: 10px; margin: 20px 0;'>
        <p style='color: #10b981; margin: 0;'>✓ Access hundreds of interview questions</p>
        <p style='color: #10b981; margin: 5px 0;'>✓ Take practice quizzes</p>
        <p style='color: #10b981; margin: 0;'>✓ Track your progress</p>
    </div>
    
    <p style='text-align: center; color: #a5b4fc;'>Start your journey now!</p>
</div>
</body>
</html>";
        }
    }
}

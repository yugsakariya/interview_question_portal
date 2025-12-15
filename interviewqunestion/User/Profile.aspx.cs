using System;
using System.Collections.Generic;
using System.Data;
using DataLayer;

namespace interviewqunestion.User
{
    public partial class Profile : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            try
            {
                // Get UserID from Session
                if (Session["UserID"] != null)
                {
                    string userID = Session["UserID"].ToString();

                    // Create parameters dictionary
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters["@UserID"] = int.Parse(userID);

                    // Execute stored procedure to get user details
                    dt = db.ExeSP("sp_GetUserProfileByUserID", parameters);

                    // Bind data to labels
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        DataRow row = dt.Rows[0];

                        // Combine FirstName and LastName for Full Name
                        string firstName = row["User_FirstName"] != DBNull.Value ? row["User_FirstName"].ToString() : "";
                        string lastName = row["User_LastName"] != DBNull.Value ? row["User_LastName"].ToString() : "";
                        lblFullName.Text = (firstName + " " + lastName).Trim();
                        if (string.IsNullOrWhiteSpace(lblFullName.Text))
                        {
                            lblFullName.Text = "N/A";
                        }

                        lblEmail.Text = row["User_EmailID"] != DBNull.Value ? row["User_EmailID"].ToString() : "N/A";
                        lblUsername.Text = (firstName + " " + lastName).Trim();

                        // Format the member since date
                        if (row["User_RegisteredDate"] != DBNull.Value)
                        {
                            DateTime registeredDate = (DateTime)row["User_RegisteredDate"];
                            lblMemberSince.Text = registeredDate.ToString("MMMM dd, yyyy");
                        }
                        else
                        {
                            lblMemberSince.Text = "N/A";
                        }
                    }
                    else
                    {
                        // No user found
                        Response.Redirect("~/Account/Login.aspx");
                    }
                }
                else
                {
                    // No session, redirect to login
                    Response.Redirect("~/Account/Login.aspx");
                }
            }
            catch (Exception ex)
            {
                // Log error (optional)
                System.Diagnostics.Debug.WriteLine("Error loading profile: " + ex.Message);

                // Show error message or redirect
                Response.Redirect("~/Account/Login.aspx");
            }
        }
    }
}
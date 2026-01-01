using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using DataLayer;

namespace interviewqunestion.User
{
    public partial class Profile : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/Account/Login.aspx");
                    return;
                }

                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_User_ID"] = userId;

                DataTable dt = db.ExeSP("sp_Get_User_ByID", parameters);

                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    // Populate profile labels
                    lblFullName.Text = row["User_FirstName"].ToString() + " " + row["User_LastName"].ToString();
                    lblEmail.Text = row["User_EmailID"].ToString();
                    lblUsername.Text = row["User_EmailID"].ToString(); // Using email as username
                    lblRole.Text = row["User_Role"].ToString();

                    // Format member since date
                    if (row["User_RegisteredDate"] != DBNull.Value)
                    {
                        DateTime registeredDate = Convert.ToDateTime(row["User_RegisteredDate"]);
                        lblMemberSince.Text = registeredDate.ToString("MMMM dd, yyyy");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading profile: " + ex.Message);
            }
        }
    }
}
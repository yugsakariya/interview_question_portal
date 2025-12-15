using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.Admin
{
    public partial class ManageCompanies : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCompanies();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string companyName = txtCompanyName.Text.Trim();

                // Validation
                if (string.IsNullOrEmpty(companyName))
                {
                    lblMsg.Text = "Please enter a company name.";
                    lblMsg.CssClass = "alert alert-danger";
                    lblMsg.Visible = true;
                    return;
                }

                // Create parameters dictionary
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@Company_Name"] = companyName;

                // Execute stored procedure
                db.ExeSP("sp_Insert_Company", parameters);

                // Clear the textbox and show success message
                txtCompanyName.Text = string.Empty;
                lblMsg.Text = "Company saved successfully!";
                lblMsg.CssClass = "alert alert-success";
                lblMsg.Visible = true;

                // Reload the grid
                LoadCompanies();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtCompanyName.Text = string.Empty;
            hfCompanyId.Value = string.Empty;
            lblMsg.Visible = false;
        }

        protected void gvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "EditRow")
                {
                    int companyId = Convert.ToInt32(e.CommandArgument);
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters["@Company_ID"] = companyId;

                    DataTable dt = db.ExeSP("sp_Get_Company_ByID", parameters);
                    if (dt.Rows.Count > 0)
                    {
                        txtCompanyName.Text = dt.Rows[0]["Company_Name"].ToString();
                        hfCompanyId.Value = companyId.ToString();
                    }
                }
                else if (e.CommandName == "DeleteRow")
                {
                    int companyId = Convert.ToInt32(e.CommandArgument);
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters["@Company_ID"] = companyId;

                    db.ExeSP("sp_Delete_Company", parameters);
                    lblMsg.Text = "Company deleted successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    lblMsg.Visible = true;
                    LoadCompanies();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }

        private void LoadCompanies()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_Get_All_Companies", null);
                gvCompanies.DataSource = dt;
                gvCompanies.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error loading companies: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }
    }
}
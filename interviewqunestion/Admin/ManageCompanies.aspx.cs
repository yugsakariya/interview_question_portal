using System;
using System.Data;
using System.Collections.Generic;
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
        // ========== READ ==========
        private void LoadCompanies()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Companies", null);
                gvCompanies.DataSource = dt;
                gvCompanies.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }
        // ========== CREATE & UPDATE ==========
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtCompanyName.Text))
                {
                    ShowMessage("Please enter company name!", false);
                    return;
                }
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                if (!string.IsNullOrEmpty(hfCompanyId.Value))
                {
                    // UPDATE
                    parameters.Add("@p_Company_ID", Convert.ToInt32(hfCompanyId.Value));
                    parameters.Add("@p_Company_Name", txtCompanyName.Text.Trim());

                    db.ExeSP("sp_Update_Company", parameters);
                    ShowMessage("Company updated successfully!", true);
                }
                else
                {
                    // CREATE
                    parameters.Add("@p_Company_Name", txtCompanyName.Text.Trim());

                    db.ExeSP("sp_Insert_Company", parameters);
                    ShowMessage("Company added successfully!", true);
                }
                ClearForm();
                LoadCompanies();
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }
        // ========== EDIT & DELETE ==========
        protected void gvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int companyId = Convert.ToInt32(e.CommandArgument);
                if (e.CommandName == "EditRow")
                {
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_Company_ID", companyId);

                    DataTable dt = db.ExeSP("sp_GetByID_Company", parameters);

                    if (dt.Rows.Count > 0)
                    {
                        hfCompanyId.Value = dt.Rows[0]["Company_ID"].ToString();
                        txtCompanyName.Text = dt.Rows[0]["Company_Name"].ToString();
                        btnSave.Text = "Update";
                    }
                }
                else if (e.CommandName == "DeleteRow")
                {
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_Company_ID", companyId);

                    db.ExeSP("sp_Delete_Company", parameters);
                    ShowMessage("Company deleted successfully!", true);
                    LoadCompanies();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }
        private void ClearForm()
        {
            txtCompanyName.Text = string.Empty;
            hfCompanyId.Value = string.Empty;
            btnSave.Text = "Save";
        }
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMsg.Text = message;
            lblMsg.CssClass = isSuccess ? "alert alert-success" : "alert alert-danger";
            lblMsg.Visible = true;
        }
    }
}
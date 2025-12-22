using System;
using System.Data;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.Admin
{
    public partial class ManageCategories : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Categories", null);
                gvCategories.DataSource = dt;
                gvCategories.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading categories: " + ex.Message, false);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtCategoryName.Text))
                {
                    ShowMessage("Please enter category name!", false);
                    return;
                }

                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();

                if (!string.IsNullOrEmpty(hfCategoryId.Value))
                {
                    // UPDATE existing category
                    parameters.Add("@Category_ID", Convert.ToInt32(hfCategoryId.Value));
                    parameters.Add("@Category_Name", txtCategoryName.Text.Trim());

                    db.ExeSP("sp_Update_Category", parameters);
                    ShowMessage("Category updated successfully!", true);
                }
                else
                {
                    // CREATE new category
                    parameters.Add("@Category_Name", txtCategoryName.Text.Trim());

                    db.ExeSP("sp_Insert_Category", parameters);
                    ShowMessage("Category added successfully!", true);
                }

                ClearForm();
                LoadCategories();
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving category: " + ex.Message, false);
            }
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int categoryId = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "EditRow")
                {
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_Category_ID", categoryId);
                    DataTable dt = db.ExeSP("sp_GetByID_Category", parameters);

                    if (dt.Rows.Count > 0)
                    {
                        hfCategoryId.Value = dt.Rows[0]["Category_ID"].ToString();
                        txtCategoryName.Text = dt.Rows[0]["Category_Name"].ToString();
                        btnSave.Text = "Update";
                    }
                }
                else if (e.CommandName == "DeleteRow")
                {
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@Category_ID", categoryId);

                    db.ExeSP("sp_Delete_Category", parameters);
                    ShowMessage("Category deleted successfully!", true);
                    LoadCategories();
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
            txtCategoryName.Text = string.Empty;
            hfCategoryId.Value = string.Empty;
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
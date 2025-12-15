using System;
using System.Collections.Generic;
using System.Data;
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string categoryName = txtCategoryName.Text.Trim();

                // Validation
                if (string.IsNullOrEmpty(categoryName))
                {
                    lblMsg.Text = "Please enter a category name.";
                    lblMsg.CssClass = "alert alert-danger";
                    lblMsg.Visible = true;
                    return;
                }

                // Create parameters dictionary
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@Category_Name"] = categoryName;

                // Execute stored procedure
                db.ExeSP("sp_Insert_Category", parameters);

                // Clear the textbox and show success message
                txtCategoryName.Text = string.Empty;
                lblMsg.Text = "Category saved successfully!";
                lblMsg.CssClass = "alert alert-success";
                lblMsg.Visible = true;

                // Reload the grid
                LoadCategories();
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
            txtCategoryName.Text = string.Empty;
            hfCategoryId.Value = string.Empty;
            lblMsg.Visible = false;
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "EditRow")
                {
                    int categoryId = Convert.ToInt32(e.CommandArgument);
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters["@Category_ID"] = categoryId;

                    DataTable dt = db.ExeSP("sp_Get_Category_ByID", parameters);
                    if (dt.Rows.Count > 0)
                    {
                        txtCategoryName.Text = dt.Rows[0]["Category_Name"].ToString();
                        hfCategoryId.Value = categoryId.ToString();
                    }
                }
                else if (e.CommandName == "DeleteRow")
                {
                    int categoryId = Convert.ToInt32(e.CommandArgument);
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters["@Category_ID"] = categoryId;

                    db.ExeSP("sp_Delete_Category", parameters);
                    lblMsg.Text = "Category deleted successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    lblMsg.Visible = true;
                    LoadCategories();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }

        private void LoadCategories()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_Get_All_Categories", null);
                gvCategories.DataSource = dt;
                gvCategories.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error loading categories: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }
    }
}
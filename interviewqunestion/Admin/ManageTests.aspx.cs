using System;
using System.Data;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.Admin
{
    public partial class ManageTests : System.Web.UI.Page
    {
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadTests();
            }
        }

        // ========== LOAD DATA ==========
        private void LoadCategories()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Categories", null);
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "Category_Name";
                ddlCategory.DataValueField = "Category_ID";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", ""));
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading categories: " + ex.Message, false);
            }
        }

        private void LoadTests()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Tests", null);
                gvTests.DataSource = dt;
                gvTests.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading tests: " + ex.Message, false);
            }
        }

        // ========== CREATE & UPDATE ==========
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Validation
                if (string.IsNullOrWhiteSpace(txtTestName.Text))
                {
                    ShowMessage("Please enter test name!", false);
                    return;
                }
                if (string.IsNullOrEmpty(ddlCategory.SelectedValue))
                {
                    ShowMessage("Please select a category!", false);
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtTotalMarks.Text))
                {
                    ShowMessage("Please enter total marks!", false);
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtDuration.Text))
                {
                    ShowMessage("Please enter duration!", false);
                    return;
                }

                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();

                if (!string.IsNullOrEmpty(hfTestId.Value))
                {
                    // UPDATE existing testr
                    parameters.Add("@p_Test_ID", Convert.ToInt32(hfTestId.Value));
                    parameters.Add("@p_Test_Name", txtTestName.Text.Trim());
                    parameters.Add("@p_Category_ID", Convert.ToInt32(ddlCategory.SelectedValue));
                    parameters.Add("@p_TotalMarks", Convert.ToInt32(txtTotalMarks.Text));
                    parameters.Add("@p_Duration_Minutes", Convert.ToInt32(txtDuration.Text));
                    parameters.Add("@p_CreatedBy", Convert.ToInt32(Session["AdminID"].ToString()));

                    db.ExeSP("sp_Update_Test", parameters);
                    ShowMessage("Test updated successfully!", true);
                }
                else
                {
                    // CREATE new test
                    parameters.Add("@p_Test_Name", txtTestName.Text.Trim());
                    parameters.Add("@p_Category_ID", Convert.ToInt32(ddlCategory.SelectedValue));
                    parameters.Add("@p_TotalMarks", Convert.ToInt32(txtTotalMarks.Text));
                    parameters.Add("@p_Duration_Minutes", Convert.ToInt32(txtDuration.Text));
                    parameters.Add("@p_CreatedBy", Convert.ToInt32(Session["AdminID"].ToString()));

                    db.ExeSP("sp_Insert_Test", parameters);
                    ShowMessage("Test added successfully!", true);
                }

                ClearForm();
                LoadTests();
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving test: " + ex.Message, false);
            }
        }

        // ========== EDIT & DELETE ==========
        protected void gvTests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int testId = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "EditT")
                {
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_Test_ID", testId);

                    DataTable dt = db.ExeSP("sp_GetByID_Test", parameters);

                    if (dt.Rows.Count > 0)
                    {
                        hfTestId.Value = dt.Rows[0]["Test_ID"].ToString();
                        txtTestName.Text = dt.Rows[0]["Test_Name"].ToString();
                        ddlCategory.SelectedValue = dt.Rows[0]["Category_ID"].ToString();
                        txtTotalMarks.Text = dt.Rows[0]["TotalMarks"].ToString();
                        txtDuration.Text = dt.Rows[0]["Duration_Minutes"].ToString();
                        txtCreatedBy.Text = dt.Rows[0]["CreatedBy"].ToString();
                        btnSave.Text = "Update Test";
                    }
                }
                else if (e.CommandName == "DeleteT")
                {
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_Test_ID", testId);

                    db.ExeSP("sp_Delete_Test", parameters);
                    ShowMessage("Test deleted successfully!", true);
                    LoadTests();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }

        // ========== CLEAR FORM ==========
        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            txtTestName.Text = string.Empty;
            ddlCategory.SelectedIndex = 0;
            txtTotalMarks.Text = string.Empty;
            txtDuration.Text = string.Empty;
            txtCreatedBy.Text = string.Empty;
            hfTestId.Value = string.Empty;
            btnSave.Text = "Save Test";
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMsg.Text = message;
            lblMsg.CssClass = isSuccess ? "alert alert-success" : "alert alert-danger";
            lblMsg.Visible = true;
        }
    }
}
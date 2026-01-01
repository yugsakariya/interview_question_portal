using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
using System.Data;

namespace interviewquestion.User
{
    public partial class Questions : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        DBHelper db = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadCompanies();
                LoadQuestions();
            }
        }

        private void LoadCategories()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Categories", null);
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "Category_Name";
                ddlCategory.DataValueField = "Category_ID";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("All Categories", "0"));
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading categories: " + ex.Message, false);
            }
        }

        private void LoadCompanies()
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Companies", null);
                ddlCompany.DataSource = dt;
                ddlCompany.DataTextField = "Company_Name";
                ddlCompany.DataValueField = "Company_ID";
                ddlCompany.DataBind();
                ddlCompany.Items.Insert(0, new ListItem("All Companies", "0"));
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading companies: " + ex.Message, false);
            }
        }

        private void LoadQuestions()
        {
            try
            {
                // Get all questions from database
                DataTable allQuestions = db.ExeSP("sp_GetAll_Questions", null);
                
                // Debug: show count
                ShowMessage("Questions found: " + (allQuestions != null ? allQuestions.Rows.Count.ToString() : "null"), true);
                
                // Create filtered table
                DataTable filteredQuestions = allQuestions.Clone();
                
                // Get selected filter values
                string selectedCategoryVal = ddlCategory.SelectedValue;
                string selectedCompanyVal = ddlCompany.SelectedValue;
                
                int selectedCategoryId = 0;
                int selectedCompanyId = 0;

                int.TryParse(selectedCategoryVal, out selectedCategoryId);
                int.TryParse(selectedCompanyVal, out selectedCompanyId);

                if (selectedCategoryId == 0 && selectedCompanyId == 0)
                {
                    gvQuestions.DataSource = allQuestions;
                    gvQuestions.DataBind();
                    return;
                }

                // Filter rows
                foreach (DataRow row in allQuestions.Rows)
                {
                    bool matchesCategory = (selectedCategoryId == 0);
                    if (!matchesCategory)
                    {
                        // Check if column exists and value matches
                        if (allQuestions.Columns.Contains("Category_ID") && row["Category_ID"] != DBNull.Value)
                        {
                            matchesCategory = (Convert.ToInt32(row["Category_ID"]) == selectedCategoryId);
                        }
                    }

                    bool matchesCompany = (selectedCompanyId == 0);
                    if (!matchesCompany)
                    {
                         if (allQuestions.Columns.Contains("Company_ID") && row["Company_ID"] != DBNull.Value)
                         {
                             matchesCompany = (Convert.ToInt32(row["Company_ID"]) == selectedCompanyId);
                         }
                    }

                    if (matchesCategory && matchesCompany)
                    {
                        filteredQuestions.ImportRow(row);
                    }
                }
                
                // Bind to GridView
                gvQuestions.DataSource = filteredQuestions;
                gvQuestions.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading questions: " + ex.Message, false);
            }
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            LoadQuestions();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlCategory.SelectedIndex = 0;
            ddlCompany.SelectedIndex = 0;
            LoadQuestions();
        }

        protected void gvQuestions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Bookmark")
                {
                    if (Session["UserID"] == null)
                    {
                        Response.Redirect("~/User/Login.aspx"); 
                        return;
                    }

                    int questionId = Convert.ToInt32(e.CommandArgument);

                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_User_ID", Session["UserID"]); // Get from session
                    parameters.Add("@p_Question_ID", questionId);
                    db.ExeSP("sp_Insert_Bookmark", parameters);
                    ShowMessage("Question bookmarked successfully!", true);

                    // Future implementation:
                    // Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    // parameters.Add("@p_User_ID", Session["UserID"]); // Get from session
                    // parameters.Add("@p_Question_ID", questionId);
                    // db.ExeSP("sp_Insert_Bookmark", parameters);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMsg.Text = message;
            pnlMessage.CssClass = isSuccess ? "alert-message alert-success" : "alert-message alert-danger";
            pnlMessage.Visible = true;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.Admin
{
    public partial class ManageQuestions : System.Web.UI.Page
    {
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
                ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", "0"));
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
                ddlCompany.Items.Insert(0, new ListItem("-- Select Company --", "0"));
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
                DataTable dt = db.ExeSP("sp_GetAll_Questions", null);
                gvQuestions.DataSource = dt;
                gvQuestions.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading questions: " + ex.Message, false);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidateForm())
                {
                    return;
                }

                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();

                if (!string.IsNullOrEmpty(hfQuestionId.Value))
                {
                    // UPDATE existing question
                    parameters.Add("@p_Question_ID", Convert.ToInt32(hfQuestionId.Value));
                    parameters.Add("@p_Category_ID", Convert.ToInt32(ddlCategory.SelectedValue));
                    parameters.Add("@p_Company_ID", Convert.ToInt32(ddlCompany.SelectedValue));
                    parameters.Add("@p_Question_Text", txtQuestion.Text.Trim());
                    parameters.Add("@p_OptionA", txtA.Text.Trim());
                    parameters.Add("@p_OptionB", txtB.Text.Trim());
                    parameters.Add("@p_OptionC", txtC.Text.Trim());
                    parameters.Add("@p_OptionD", txtD.Text.Trim());
                    parameters.Add("@p_CorrectOption", ddlCorrectOption.SelectedValue);

                    db.ExeSP("sp_Update_Question", parameters);
                    ShowMessage("Question updated successfully!", true);
                }
                else
                {
                    // CREATE new question
                    parameters.Add("@p_Category_ID", Convert.ToInt32(ddlCategory.SelectedValue));
                    parameters.Add("@p_Company_ID", Convert.ToInt32(ddlCompany.SelectedValue));
                    parameters.Add("@p_Question_Text", txtQuestion.Text.Trim());
                    parameters.Add("@p_OptionA", txtA.Text.Trim());
                    parameters.Add("@p_OptionB", txtB.Text.Trim());
                    parameters.Add("@p_OptionC", txtC.Text.Trim());
                    parameters.Add("@p_OptionD", txtD.Text.Trim());
                    parameters.Add("@p_CorrectOption", ddlCorrectOption.SelectedValue);

                    db.ExeSP("sp_Insert_Question", parameters);
                    ShowMessage("Question added successfully!", true);
                }

                ClearForm();
                LoadQuestions();
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving question: " + ex.Message, false);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void gvQuestions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int questionId = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "EditQ")
                {
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_Question_ID", questionId);
                    DataTable dt = db.ExeSP("sp_GetByID_Question", parameters);

                    if (dt.Rows.Count > 0)
                    {
                        hfQuestionId.Value = dt.Rows[0]["Question_ID"].ToString();
                        ddlCategory.SelectedValue = dt.Rows[0]["Category_ID"].ToString();
                        ddlCompany.SelectedValue = dt.Rows[0]["Company_ID"].ToString();
                        txtQuestion.Text = dt.Rows[0]["Question_Text"].ToString();
                        txtA.Text = dt.Rows[0]["OptionA"].ToString();
                        txtB.Text = dt.Rows[0]["OptionB"].ToString();
                        txtC.Text = dt.Rows[0]["OptionC"].ToString();
                        txtD.Text = dt.Rows[0]["OptionD"].ToString();
                        ddlCorrectOption.SelectedValue = dt.Rows[0]["CorrectOption"].ToString();
                        btnSave.Text = "Update Question";
                    }
                }
                else if (e.CommandName == "DeleteQ")
                {
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters.Add("@p_Question_ID", questionId);

                    db.ExeSP("sp_Delete_Question", parameters);
                    ShowMessage("Question deleted successfully!", true);
                    LoadQuestions();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
                if (!fuQuestions.HasFile)
                {
                    ShowUploadMessage("Please select a CSV file to upload!", false);
                    return;
                }

                string fileExtension = Path.GetExtension(fuQuestions.FileName).ToLower();
                if (fileExtension != ".csv")
                {
                    ShowUploadMessage("Please upload a CSV file only!", false);
                    return;
                }

                int successCount = 0;
                int errorCount = 0;
                StringBuilder errors = new StringBuilder();

                using (StreamReader sr = new StreamReader(fuQuestions.FileContent))
                {
                    string headerLine = sr.ReadLine(); // Skip header
                    int lineNumber = 1;

                    while (!sr.EndOfStream)
                    {
                        lineNumber++;
                        string line = sr.ReadLine();
                        
                        if (string.IsNullOrWhiteSpace(line))
                            continue;

                        try
                        {
                            string[] values = ParseCSVLine(line);

                            if (values.Length < 8)
                            {
                                errors.AppendLine($"Line {lineNumber}: Invalid format (expected 8 columns)");
                                errorCount++;
                                continue;
                            }

                            // Get Category ID
                            int categoryId = GetCategoryIdByName(values[0].Trim());
                            if (categoryId == 0)
                            {
                                errors.AppendLine($"Line {lineNumber}: Category '{values[0]}' not found");
                                errorCount++;
                                continue;
                            }

                            // Get Company ID
                            int companyId = GetCompanyIdByName(values[1].Trim());
                            if (companyId == 0)
                            {
                                errors.AppendLine($"Line {lineNumber}: Company '{values[1]}' not found");
                                errorCount++;
                                continue;
                            }

                            // Validate correct option
                            string correctOption = values[7].Trim().ToUpper();
                            if (correctOption != "A" && correctOption != "B" && correctOption != "C" && correctOption != "D")
                            {
                                errors.AppendLine($"Line {lineNumber}: Invalid correct option '{values[7]}' (must be A, B, C, or D)");
                                errorCount++;
                                continue;
                            }

                            // Insert question
                            Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                            parameters.Add("@p_Category_ID", categoryId);
                            parameters.Add("@p_Company_ID", companyId);
                            parameters.Add("@p_Question_Text", values[2].Trim());
                            parameters.Add("@p_OptionA", values[3].Trim());
                            parameters.Add("@p_OptionB", values[4].Trim());
                            parameters.Add("@p_OptionC", values[5].Trim());
                            parameters.Add("@p_OptionD", values[6].Trim());
                            parameters.Add("@p_CorrectOption", correctOption);

                            db.ExeSP("sp_Insert_Question", parameters);
                            successCount++;
                        }
                        catch (Exception ex)
                        {
                            errors.AppendLine($"Line {lineNumber}: {ex.Message}");
                            errorCount++;
                        }
                    }
                }

                LoadQuestions();

                string message = $"Upload completed! {successCount} questions added successfully.";
                if (errorCount > 0)
                {
                    message += $" {errorCount} errors occurred.<br/>" + errors.ToString().Replace("\n", "<br/>");
                }

                ShowUploadMessage(message, errorCount == 0);
            }
            catch (Exception ex)
            {
                ShowUploadMessage("Error uploading file: " + ex.Message, false);
            }
        }

        protected void btnDownloadTemplate_Click(object sender, EventArgs e)
        {
            try
            {
                StringBuilder csv = new StringBuilder();
                csv.AppendLine("Category,Company,Question,OptionA,OptionB,OptionC,OptionD,CorrectOption");
                csv.AppendLine("Programming,Google,\"What is C#?\",\"A programming language\",\"A database\",\"An operating system\",\"A web browser\",A");
                csv.AppendLine("Database,Microsoft,\"What does SQL stand for?\",\"Structured Query Language\",\"Simple Question Language\",\"Standard Quality Language\",\"System Query Language\",A");

                Response.Clear();
                Response.ContentType = "text/csv";
                Response.AddHeader("Content-Disposition", "attachment;filename=QuestionTemplate.csv");
                Response.Write(csv.ToString());
                Response.End();
            }
            catch (Exception ex)
            {
                ShowUploadMessage("Error downloading template: " + ex.Message, false);
            }
        }

        private string[] ParseCSVLine(string line)
        {
            List<string> values = new List<string>();
            bool inQuotes = false;
            StringBuilder currentValue = new StringBuilder();

            for (int i = 0; i < line.Length; i++)
            {
                char c = line[i];

                if (c == '"')
                {
                    inQuotes = !inQuotes;
                }
                else if (c == ',' && !inQuotes)
                {
                    values.Add(currentValue.ToString());
                    currentValue.Clear();
                }
                else
                {
                    currentValue.Append(c);
                }
            }

            values.Add(currentValue.ToString());
            return values.ToArray();
        }

        private int GetCategoryIdByName(string categoryName)
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Categories", null);
                foreach (DataRow row in dt.Rows)
                {
                    if (row["Category_Name"].ToString().Equals(categoryName, StringComparison.OrdinalIgnoreCase))
                    {
                        return Convert.ToInt32(row["Category_ID"]);
                    }
                }
                return 0;
            }
            catch
            {
                return 0;
            }
        }

        private int GetCompanyIdByName(string companyName)
        {
            try
            {
                DataTable dt = db.ExeSP("sp_GetAll_Companies", null);
                foreach (DataRow row in dt.Rows)
                {
                    if (row["Company_Name"].ToString().Equals(companyName, StringComparison.OrdinalIgnoreCase))
                    {
                        return Convert.ToInt32(row["Company_ID"]);
                    }
                }
                return 0;
            }
            catch
            {
                return 0;
            }
        }

        private bool ValidateForm()
        {
            if (ddlCategory.SelectedValue == "0")
            {
                ShowMessage("Please select a category!", false);
                return false;
            }

            if (ddlCompany.SelectedValue == "0")
            {
                ShowMessage("Please select a company!", false);
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtQuestion.Text))
            {
                ShowMessage("Please enter the question text!", false);
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtA.Text) || string.IsNullOrWhiteSpace(txtB.Text) ||
                string.IsNullOrWhiteSpace(txtC.Text) || string.IsNullOrWhiteSpace(txtD.Text))
            {
                ShowMessage("Please enter all four options!", false);
                return false;
            }

            return true;
        }

        private void ClearForm()
        {
            hfQuestionId.Value = string.Empty;
            ddlCategory.SelectedIndex = 0;
            ddlCompany.SelectedIndex = 0;
            txtQuestion.Text = string.Empty;
            txtA.Text = string.Empty;
            txtB.Text = string.Empty;
            txtC.Text = string.Empty;
            txtD.Text = string.Empty;
            ddlCorrectOption.SelectedIndex = 0;
            btnSave.Text = "Save Question";
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMsg.Text = message;
            lblMsg.CssClass = isSuccess ? "alert alert-success" : "alert alert-danger";
            lblMsg.Visible = true;
        }

        private void ShowUploadMessage(string message, bool isSuccess)
        {
            lblUploadMsg.Text = message;
            lblUploadMsg.CssClass = isSuccess ? "alert alert-success" : "alert alert-danger";
            lblUploadMsg.Visible = true;
        }
    }
}
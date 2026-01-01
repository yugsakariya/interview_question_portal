using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.User
{
    public partial class QuizAttempt : System.Web.UI.Page
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

                string testId = Request.QueryString["testId"];
                if (string.IsNullOrEmpty(testId))
                {
                    Response.Redirect("~/User/QuizList.aspx");
                    return;
                }

                int testIdInt = Convert.ToInt32(testId);
                int userId = Convert.ToInt32(Session["UserID"]);

                // Check if test is already completed by this user
                if (IsTestCompleted(userId, testIdInt))
                {
                    // Redirect back to quiz list with message
                    Response.Redirect("~/User/QuizList.aspx");
                    return;
                }

                LoadTest(testIdInt);
            }
        }

        private bool IsTestCompleted(int userId, int testId)
        {
            try
            {
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_User_ID"] = userId;
                parameters["@p_Test_ID"] = testId;

                DataTable dt = db.ExeSP("sp_CheckTestCompleted", parameters);
                
                if (dt != null && dt.Rows.Count > 0)
                {
                    int count = Convert.ToInt32(dt.Rows[0]["IsCompleted"]);
                    return count > 0;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error checking test completion: " + ex.Message);
            }
            return false;
        }

        private void LoadTest(int testId)
        {
            try
            {
                // Store test ID in session for submission
                Session["CurrentTestID"] = testId;

                // Get test details
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_Test_ID"] = testId;
                DataTable dtTest = db.ExeSP("sp_GetByID_Test", parameters);

                if (dtTest != null && dtTest.Rows.Count > 0)
                {
                    lblTestName.Text = dtTest.Rows[0]["Test_Name"].ToString();
                    int durationMinutes = Convert.ToInt32(dtTest.Rows[0]["Duration_Minutes"]);
                    lblTimer.Text = durationMinutes + ":00";
                    
                    // Store duration for JavaScript timer
                    Session["TestDuration"] = durationMinutes;
                }

                // Get questions for this test
                parameters.Clear();
                parameters["@p_Test_ID"] = testId;
                DataTable dtQuestions = db.ExeSP("sp_GetQuestionsByTestID", parameters);

                if (dtQuestions != null && dtQuestions.Rows.Count > 0)
                {
                    rptQuestions.DataSource = dtQuestions;
                    rptQuestions.DataBind();
                    
                    // Store questions in session for answer verification
                    Session["TestQuestions"] = dtQuestions;
                }
                else
                {
                    // No questions assigned to this test
                    lblResultMsg.Text = "No questions have been assigned to this test yet.";
                    pnlResult.Visible = true;
                    btnSubmitTest.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblResultMsg.Text = "Error loading test: " + ex.Message;
                pnlResult.Visible = true;
            }
        }

        protected void btnSubmitTest_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["TestQuestions"] == null || Session["CurrentTestID"] == null)
                {
                    Response.Redirect("~/User/QuizList.aspx");
                    return;
                }

                DataTable dtQuestions = (DataTable)Session["TestQuestions"];
                int testId = Convert.ToInt32(Session["CurrentTestID"]);
                int userId = Convert.ToInt32(Session["UserID"]);

                // Double-check: prevent submitting if already completed
                if (IsTestCompleted(userId, testId))
                {
                    Response.Redirect("~/User/QuizList.aspx");
                    return;
                }

                int correctCount = 0;
                int wrongCount = 0;
                int totalQuestions = dtQuestions.Rows.Count;

                // Loop through each question in the repeater
                foreach (RepeaterItem item in rptQuestions.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        HiddenField hfQuestionId = (HiddenField)item.FindControl("hfQuestionId");
                        RadioButton rbA = (RadioButton)item.FindControl("rbA");
                        RadioButton rbB = (RadioButton)item.FindControl("rbB");
                        RadioButton rbC = (RadioButton)item.FindControl("rbC");
                        RadioButton rbD = (RadioButton)item.FindControl("rbD");

                        if (hfQuestionId != null)
                        {
                            int questionId = Convert.ToInt32(hfQuestionId.Value);
                            
                            // Get selected answer
                            string selectedAnswer = "";
                            if (rbA != null && rbA.Checked) selectedAnswer = "A";
                            else if (rbB != null && rbB.Checked) selectedAnswer = "B";
                            else if (rbC != null && rbC.Checked) selectedAnswer = "C";
                            else if (rbD != null && rbD.Checked) selectedAnswer = "D";

                            // Find correct answer from stored questions
                            DataRow[] rows = dtQuestions.Select("Question_ID = " + questionId);
                            if (rows.Length > 0)
                            {
                                string correctAnswer = rows[0]["CorrectOption"].ToString().Trim();
                                
                                if (!string.IsNullOrEmpty(selectedAnswer))
                                {
                                    if (selectedAnswer.Equals(correctAnswer, StringComparison.OrdinalIgnoreCase))
                                    {
                                        correctCount++;
                                    }
                                    else
                                    {
                                        wrongCount++;
                                    }
                                }
                                else
                                {
                                    // No answer selected - count as wrong
                                    wrongCount++;
                                }
                            }
                        }
                    }
                }

                // Calculate score (each correct answer = 1 mark for simplicity)
                int score = correctCount;

                // Save result to database
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_Test_ID"] = testId;
                parameters["@p_User_ID"] = userId;
                parameters["@p_Score"] = score;
                parameters["@p_TotalQuestions"] = totalQuestions;
                parameters["@p_CorrectAnswers"] = correctCount;
                parameters["@p_WrongAnswers"] = wrongCount;

                db.ExeSP("sp_InsertTestResult", parameters);

                // Clear session data
                Session.Remove("TestQuestions");
                Session.Remove("CurrentTestID");
                Session.Remove("TestDuration");

                // Show result
                rptQuestions.Visible = false;
                btnSubmitTest.Visible = false;
                pnlResult.Visible = true;
                lblResultMsg.Text = string.Format(
                    "Test Submitted Successfully!<br/>Score: {0}/{1}<br/>Correct: {2} | Wrong: {3}",
                    score, totalQuestions, correctCount, wrongCount
                );

                // Redirect to results page after 3 seconds
                string script = "setTimeout(function(){ window.location.href = 'Results.aspx'; }, 3000);";
                ClientScript.RegisterStartupScript(this.GetType(), "RedirectToResults", script, true);
            }
            catch (Exception ex)
            {
                lblResultMsg.Text = "Error submitting test: " + ex.Message;
                pnlResult.Visible = true;
            }
        }
    }
}
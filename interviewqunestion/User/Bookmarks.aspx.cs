using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace interview_questions.User
{
    public partial class Bookmarks : System.Web.UI.Page
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

                LoadBookmarks();
            }
        }

        private void LoadBookmarks()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters["@p_User_ID"] = userId;

                DataTable dt = db.ExeSP("sp_GetBookmarks_ByUserID", parameters);
                gvBookmarks.DataSource = dt;
                gvBookmarks.DataBind();

                // Update bookmark count label
                if (dt != null)
                {
                    lblBookmarkCount.Text = dt.Rows.Count + " Bookmark" + (dt.Rows.Count != 1 ? "s" : "");
                }
                else
                {
                    lblBookmarkCount.Text = "0 Bookmarks";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading bookmarks: " + ex.Message);
            }
        }

        protected void gvBookmarks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Remove")
                {
                    int bookmarkId = Convert.ToInt32(e.CommandArgument);
                    
                    Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                    parameters["@p_Bookmark_ID"] = bookmarkId;
                    
                    db.ExeSP("sp_Delete_Bookmark", parameters);
                    
                    // Reload bookmarks
                    LoadBookmarks();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error removing bookmark: " + ex.Message);
            }
        }
    }
}
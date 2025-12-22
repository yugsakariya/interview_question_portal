using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
using System.Data;

namespace interview_questions.User
{
    public partial class Dashboard : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        DBHelper db = new DBHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Dictionary<string, dynamic> para = new Dictionary<string, dynamic>();
            ////para["@USER_ID"] = Session["UserID"].ToString();
            //dt = db.ExeSP("sp_GetAll_Tests_BY_USER_ID", para);
            //lblTests.Text = dt.Rows.Count.ToString();
            //para.Clear();
            //para["@USERID"] = Session["UserID"].ToString();
            //dt = db.ExeSP("sp_GetAll_Bookmarks_BY_UserID", para);
            //lblBookmarks.Text = dt.Rows.Count.ToString();
        }
    }
}
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

        }
        protected void FilterChanged(object sender, EventArgs e)
        {
           
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            
        }

        protected void gvQuestions_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

    }
}
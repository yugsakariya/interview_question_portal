using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace interviewqunestion.User
{
    public partial class Defaultpage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLoginNav_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/preloader.aspx?type=login");
        }

        protected void btnRegisterNav_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/preloader.aspx?type=register");
        }

        protected void btnHaveAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/preloader.aspx?type=login");
        }


        protected void btnGetStarted_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/preloader.aspx?type=register");
        }

        protected void btnAbout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/About.aspx");
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace interview_questions.Admin
{
    public partial class ViewTestResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Existing Page_Load logic can remain here.
            // No-op if not needed.
        }

        // Returns CSS class string for the score badge.
        protected string GetScoreClass(object scoreObj, object totalObj)
        {
            return string.Empty;
        }

        // Returns percentage as integer string (without the '%' symbol).
        protected string GetScorePercentage(object scoreObj, object totalObj)
        {
            return string.Empty;
        }

        // Helper: safely compute percentage (0-100) from score and total.
       
    }
}
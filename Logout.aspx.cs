// FILE: Logout.aspx.cs
// PURPOSE: Clear session and redirect to login
// HOW TO ADD: Add a Web Form called Logout.aspx (no master page needed)

using System;
using System.Web;

namespace FrostAndFlour
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}

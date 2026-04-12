// FILE: Login.aspx.cs
// PURPOSE: Authenticate user and set session

using System;
using System.Data;
using System.Data.SqlClient;

namespace FrostAndFlour
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email    = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            string query = "SELECT UserID, FullName, Role FROM Users WHERE Email = @Email AND Password = @Password";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Email",    email),
                new SqlParameter("@Password", password)
            };

            DataTable dt = DBHelper.GetData(query, parameters);

            if (dt.Rows.Count == 1)
            {
                // Set session variables
                Session["UserID"]   = dt.Rows[0]["UserID"].ToString();
                Session["FullName"] = dt.Rows[0]["FullName"].ToString();
                Session["Role"]     = dt.Rows[0]["Role"].ToString();

                // Redirect based on role
                if (Session["Role"].ToString() == "Admin")
                    Response.Redirect("~/Admin/Dashboard.aspx");
                else
                    Response.Redirect("~/Default.aspx");
            }
            else
            {
                lblMessage.Text    = "❌ Invalid email or password. Please try again.";
                lblMessage.Visible = true;
            }
        }
    }
}

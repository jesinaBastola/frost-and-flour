// FILE: Register.aspx.cs
// PURPOSE: Handle user registration

using System;
using System.Data.SqlClient;

namespace FrostAndFlour
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email    = txtEmail.Text.Trim();
            string phone    = txtPhone.Text.Trim();
            string address  = txtAddress.Text.Trim();
            string password = txtPassword.Text;

            // Check if email already exists
            string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
            SqlParameter[] checkParams = { new SqlParameter("@Email", email) };
            int count = Convert.ToInt32(DBHelper.ExecuteScalar(checkQuery, checkParams));

            if (count > 0)
            {
                lblMessage.Text = "⚠️ This email is already registered. Please login.";
                lblMessage.Visible = true;
                return;
            }

            // Insert new user (In production, hash the password!)
            string insertQuery = @"INSERT INTO Users (FullName, Email, Password, Phone, Address, Role)
                                   VALUES (@FullName, @Email, @Password, @Phone, @Address, 'Customer')";
            SqlParameter[] insertParams =
            {
                new SqlParameter("@FullName", fullName),
                new SqlParameter("@Email",    email),
                new SqlParameter("@Password", password),   // TODO: hash with BCrypt in production
                new SqlParameter("@Phone",    phone),
                new SqlParameter("@Address",  address)
            };

            int rows = DBHelper.ExecuteNonQuery(insertQuery, insertParams);

            if (rows > 0)
            {
                Response.Redirect("Login.aspx?registered=1");
            }
            else
            {
                lblMessage.Text = "❌ Registration failed. Please try again.";
                lblMessage.Visible = true;
            }
        }
    }
}

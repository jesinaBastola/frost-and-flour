// FILE: Admin/Dashboard.aspx.cs
// PURPOSE: Load admin dashboard statistics

using System;
using System.Data;

namespace FrostAndFlour.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Only allow Admins
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
                Response.Redirect("~/Login.aspx");

            if (!IsPostBack)
                LoadDashboard();
        }

        private void LoadDashboard()
        {
            // Stats
            lblTotalOrders.Text = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Orders").ToString();
            lblRevenue.Text     = string.Format("{0:F0}", DBHelper.ExecuteScalar("SELECT ISNULL(SUM(TotalAmount),0) FROM Orders WHERE Status = 'Delivered'"));
            lblCustomers.Text   = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Users WHERE Role = 'Customer'").ToString();
            lblProducts.Text    = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Products WHERE IsAvailable = 1").ToString();

            // Pending orders
            string query = @"SELECT TOP 10 o.OrderID, o.TotalAmount, o.OrderDate, u.FullName
                             FROM Orders o JOIN Users u ON o.UserID = u.UserID
                             WHERE o.Status = 'Pending'
                             ORDER BY o.OrderDate DESC";
            DataTable dt = DBHelper.GetData(query);
            rptPending.DataSource = dt;
            rptPending.DataBind();
        }
    }
}

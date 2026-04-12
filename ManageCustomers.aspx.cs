// FILE: Admin/ManageCustomers.aspx.cs
using System;
using System.Data;

namespace FrostAndFlour.Admin
{
    public partial class ManageCustomers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"]?.ToString() != "Admin") Response.Redirect("~/Login.aspx");
            if (!IsPostBack)
            {
                string query = @"SELECT u.UserID, u.FullName, u.Email, u.Phone, u.CreatedAt,
                                        COUNT(o.OrderID)          AS TotalOrders,
                                        ISNULL(SUM(o.TotalAmount), 0) AS TotalSpent
                                 FROM Users u
                                 LEFT JOIN Orders o ON u.UserID = o.UserID
                                 WHERE u.Role = 'Customer'
                                 GROUP BY u.UserID, u.FullName, u.Email, u.Phone, u.CreatedAt
                                 ORDER BY TotalOrders DESC";
                DataTable dt = DBHelper.GetData(query);
                lblCount.Text = dt.Rows.Count.ToString();
                rptCustomers.DataSource = dt;
                rptCustomers.DataBind();
            }
        }
    }
}

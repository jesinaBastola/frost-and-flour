// FILE: Admin/SalesReport.aspx.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace FrostAndFlour.Admin
{
    public partial class SalesReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"]?.ToString() != "Admin") Response.Redirect("~/Login.aspx");
            if (!IsPostBack)
            {
                LoadStats();
                LoadTopProducts();
                LoadMonthly();
            }
        }

        private void LoadStats()
        {
            lblTotalRevenue.Text = string.Format("{0:F0}",
                DBHelper.ExecuteScalar("SELECT ISNULL(SUM(TotalAmount),0) FROM Orders WHERE Status='Delivered'"));

            lblDelivered.Text = DBHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Orders WHERE Status='Delivered'").ToString();

            lblThisMonth.Text = DBHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Orders WHERE MONTH(OrderDate)=MONTH(GETDATE()) AND YEAR(OrderDate)=YEAR(GETDATE())").ToString();

            object avg = DBHelper.ExecuteScalar("SELECT ISNULL(AVG(TotalAmount),0) FROM Orders");
            lblAvgOrder.Text = string.Format("{0:F0}", avg);
        }

        private void LoadTopProducts()
        {
            string query = @"SELECT TOP 10 p.ProductName, c.CategoryName,
                                    SUM(oi.Quantity)                       AS UnitsSold,
                                    SUM(oi.Quantity * oi.UnitPrice)        AS Revenue
                             FROM OrderItems oi
                             JOIN Products p  ON oi.ProductID  = p.ProductID
                             JOIN Categories c ON p.CategoryID = c.CategoryID
                             GROUP BY p.ProductName, c.CategoryName
                             ORDER BY UnitsSold DESC";
            DataTable dt = DBHelper.GetData(query);
            rptTopProducts.DataSource = dt;
            rptTopProducts.DataBind();
        }

        private void LoadMonthly()
        {
            string query = @"SELECT TOP 6
                                FORMAT(OrderDate, 'MMM yyyy')      AS MonthYear,
                                COUNT(*)                           AS OrderCount,
                                ISNULL(SUM(TotalAmount), 0)        AS Revenue
                             FROM Orders
                             GROUP BY FORMAT(OrderDate, 'MMM yyyy'), YEAR(OrderDate), MONTH(OrderDate)
                             ORDER BY YEAR(OrderDate) DESC, MONTH(OrderDate) DESC";
            DataTable dt = DBHelper.GetData(query);
            rptMonthly.DataSource = dt;
            rptMonthly.DataBind();
        }
    }
}

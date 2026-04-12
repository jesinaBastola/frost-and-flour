// FILE: Orders.aspx.cs
// PURPOSE: Load customer orders and tracking

using System;
using System.Data;
using System.Data.SqlClient;

namespace FrostAndFlour
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) { Response.Redirect("Login.aspx"); return; }

            if (!IsPostBack)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string query = @"SELECT OrderID, TotalAmount, Status, DeliveryAddress, OrderDate
                                 FROM Orders WHERE UserID = @UserID ORDER BY OrderDate DESC";
                SqlParameter[] p = { new SqlParameter("@UserID", userId) };
                DataTable dt = DBHelper.GetData(query, p);

                if (dt.Rows.Count == 0)
                    lblNoOrders.Visible = true;
                else
                {
                    rptOrders.DataSource = dt;
                    rptOrders.DataBind();
                }
            }
        }

        // Returns Tailwind CSS classes for the status badge
        protected string GetStatusClass(string status)
        {
            switch (status)
            {
                case "Pending":          return "bg-yellow-100 text-yellow-800";
                case "Confirmed":        return "bg-blue-100 text-blue-800";
                case "Preparing":        return "bg-purple-100 text-purple-800";
                case "Out for Delivery": return "bg-orange-100 text-orange-800";
                case "Delivered":        return "bg-green-100 text-green-800";
                case "Cancelled":        return "bg-red-100 text-red-800";
                default:                 return "bg-gray-100 text-gray-800";
            }
        }

        // Returns progress bar width percentage
        protected int GetProgressWidth(string status)
        {
            switch (status)
            {
                case "Pending":          return 10;
                case "Confirmed":        return 30;
                case "Preparing":        return 55;
                case "Out for Delivery": return 80;
                case "Delivered":        return 100;
                default:                 return 0;
            }
        }
    }
}

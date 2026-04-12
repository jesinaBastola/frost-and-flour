// FILE: Admin/ManageOrders.aspx.cs
// PURPOSE: Load and update order status

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace FrostAndFlour.Admin
{
    public partial class ManageOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"]?.ToString() != "Admin") Response.Redirect("~/Login.aspx");
            if (!IsPostBack) LoadOrders("");
        }

        private void LoadOrders(string statusFilter)
        {
            string query = @"SELECT o.OrderID, o.TotalAmount, o.Status, o.OrderDate,
                                    u.FullName, u.Email
                             FROM Orders o JOIN Users u ON o.UserID = u.UserID
                             WHERE @Status = '' OR o.Status = @Status
                             ORDER BY o.OrderDate DESC";
            SqlParameter[] p = { new SqlParameter("@Status", statusFilter ?? "") };
            DataTable dt = DBHelper.GetData(query, p);
            rptOrders.DataSource = dt;
            rptOrders.DataBind();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
            => LoadOrders(ddlStatus.SelectedValue);

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);
            string newStatus = e.CommandName switch
            {
                "Confirm"        => "Confirmed",
                "Prepare"        => "Preparing",
                "OutForDelivery" => "Out for Delivery",
                "Deliver"        => "Delivered",
                "Cancel"         => "Cancelled",
                _                => ""
            };

            if (!string.IsNullOrEmpty(newStatus))
            {
                string q = "UPDATE Orders SET Status = @Status WHERE OrderID = @OrderID";
                SqlParameter[] p =
                {
                    new SqlParameter("@Status",  newStatus),
                    new SqlParameter("@OrderID", orderId)
                };
                DBHelper.ExecuteNonQuery(q, p);

                // Mark payment complete when delivered
                if (newStatus == "Delivered")
                    DBHelper.ExecuteNonQuery("UPDATE Payments SET Status = 'Completed' WHERE OrderID = @OrderID",
                        new SqlParameter[] { new SqlParameter("@OrderID", orderId) });
            }
            LoadOrders(ddlStatus.SelectedValue);
        }
    }
}

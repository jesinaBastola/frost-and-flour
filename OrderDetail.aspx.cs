// FILE: OrderDetail.aspx.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace FrostAndFlour
{
    public partial class OrderDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack)
            {
                int orderId = Convert.ToInt32(Request.QueryString["id"]);
                int userId  = Convert.ToInt32(Session["UserID"]);

                // Load order header
                string oQuery = @"SELECT o.OrderID, o.TotalAmount, o.Status, o.DeliveryAddress,
                                         o.OrderDate, p.Method AS PaymentMethod
                                  FROM Orders o
                                  LEFT JOIN Payments p ON o.OrderID = p.OrderID
                                  WHERE o.OrderID = @OrderID AND o.UserID = @UserID";
                SqlParameter[] oP =
                {
                    new SqlParameter("@OrderID", orderId),
                    new SqlParameter("@UserID",  userId)
                };
                DataTable odt = DBHelper.GetData(oQuery, oP);
                if (odt.Rows.Count == 0) { Response.Redirect("Orders.aspx"); return; }

                DataRow row = odt.Rows[0];
                lblOrderId.Text  = row["OrderID"].ToString();
                lblOrderDate.Text = Convert.ToDateTime(row["OrderDate"]).ToString("dd MMM yyyy hh:mm tt");
                lblStatus.Text   = row["Status"].ToString();
                lblAddress.Text  = row["DeliveryAddress"].ToString();
                lblTotal.Text    = string.Format("{0:F2}", row["TotalAmount"]);
                lblPayment.Text  = row["PaymentMethod"].ToString();

                // Load order items
                string iQuery = @"SELECT oi.Quantity, oi.UnitPrice, oi.CustomMessage, oi.CustomFlavor,
                                         oi.CustomSize, p.ProductName
                                  FROM OrderItems oi JOIN Products p ON oi.ProductID = p.ProductID
                                  WHERE oi.OrderID = @OrderID";
                DataTable idt = DBHelper.GetData(iQuery, new SqlParameter[] { new SqlParameter("@OrderID", orderId) });
                rptItems.DataSource = idt;
                rptItems.DataBind();
            }
        }
    }
}

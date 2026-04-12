// FILE: OrderConfirmation.aspx.cs
using System;
using System.Data;
using System.Data.SqlClient;

namespace FrostAndFlour
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack)
            {
                int orderId = Convert.ToInt32(Request.QueryString["id"]);
                string query = "SELECT OrderID, TotalAmount, DeliveryAddress FROM Orders WHERE OrderID = @OrderID";
                DataTable dt = DBHelper.GetData(query, new SqlParameter[] { new SqlParameter("@OrderID", orderId) });

                if (dt.Rows.Count == 1)
                {
                    lblOrderId.Text = dt.Rows[0]["OrderID"].ToString();
                    lblTotal.Text   = string.Format("{0:F2}", dt.Rows[0]["TotalAmount"]);
                    lblAddress.Text = dt.Rows[0]["DeliveryAddress"].ToString();
                }
            }
        }
    }
}

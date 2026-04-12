// FILE: Cart.aspx.cs
// PURPOSE: Manage shopping cart, place order

using System;
using System.Data;
using System.Data.SqlClient;

namespace FrostAndFlour
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) { Response.Redirect("Login.aspx"); return; }

            // Handle remove item from cart via query string
            if (Request.QueryString["removeId"] != null)
            {
                int cartId = Convert.ToInt32(Request.QueryString["removeId"]);
                DBHelper.ExecuteNonQuery("DELETE FROM Cart WHERE CartID = @CartID",
                    new SqlParameter[] { new SqlParameter("@CartID", cartId) });
                Response.Redirect("Cart.aspx");
                return;
            }

            if (!IsPostBack)
                LoadCart();
        }

        private void LoadCart()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string query = @"SELECT c.CartID, p.ProductName, p.Price, c.Quantity, 
                                    c.CustomFlavor, c.CustomSize, c.CustomMessage
                             FROM Cart c
                             JOIN Products p ON c.ProductID = p.ProductID
                             WHERE c.UserID = @UserID";
            SqlParameter[] p = { new SqlParameter("@UserID", userId) };
            DataTable dt = DBHelper.GetData(query, p);

            if (dt.Rows.Count == 0)
            {
                pnlEmpty.Visible = true;
                pnlCart.Visible  = false;
            }
            else
            {
                pnlEmpty.Visible = false;
                pnlCart.Visible  = true;
                rptCart.DataSource = dt;
                rptCart.DataBind();

                // Calculate total
                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                    total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
                lblTotal.Text = string.Format("{0:F2}", total);

                // Pre-fill delivery address from profile
                string addrQuery = "SELECT Address FROM Users WHERE UserID = @UserID";
                object addr = DBHelper.ExecuteScalar(addrQuery, new SqlParameter[] { new SqlParameter("@UserID", userId) });
                if (addr != null) txtDeliveryAddress.Text = addr.ToString();
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string delivery = txtDeliveryAddress.Text.Trim();
            string notes    = txtNotes.Text.Trim();
            string payment  = ddlPayment.SelectedValue;

            if (string.IsNullOrEmpty(delivery))
            {
                lblMessage.Text    = "⚠️ Please enter a delivery address.";
                lblMessage.Visible = true;
                return;
            }

            // Get cart items
            string cartQuery = @"SELECT c.CartID, c.ProductID, c.Quantity, c.CustomMessage, 
                                        c.CustomFlavor, c.CustomSize, p.Price
                                 FROM Cart c JOIN Products p ON c.ProductID = p.ProductID
                                 WHERE c.UserID = @UserID";
            SqlParameter[] cartP = { new SqlParameter("@UserID", userId) };
            DataTable cartDt = DBHelper.GetData(cartQuery, cartP);

            if (cartDt.Rows.Count == 0) return;

            // Calculate total
            decimal total = 0;
            foreach (DataRow row in cartDt.Rows)
                total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);

            // Create order
            string orderQuery = @"INSERT INTO Orders (UserID, TotalAmount, DeliveryAddress, Notes, Status)
                                  OUTPUT INSERTED.OrderID
                                  VALUES (@UserID, @Total, @Address, @Notes, 'Pending')";
            SqlParameter[] orderParams =
            {
                new SqlParameter("@UserID",  userId),
                new SqlParameter("@Total",   total),
                new SqlParameter("@Address", delivery),
                new SqlParameter("@Notes",   notes)
            };
            int orderId = Convert.ToInt32(DBHelper.ExecuteScalar(orderQuery, orderParams));

            // Insert order items
            foreach (DataRow row in cartDt.Rows)
            {
                string itemQuery = @"INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice, CustomMessage, CustomFlavor, CustomSize)
                                     VALUES (@OrderID, @ProductID, @Qty, @Price, @Message, @Flavor, @Size)";
                SqlParameter[] itemParams =
                {
                    new SqlParameter("@OrderID",   orderId),
                    new SqlParameter("@ProductID", row["ProductID"]),
                    new SqlParameter("@Qty",       row["Quantity"]),
                    new SqlParameter("@Price",     row["Price"]),
                    new SqlParameter("@Message",   row["CustomMessage"]),
                    new SqlParameter("@Flavor",    row["CustomFlavor"]),
                    new SqlParameter("@Size",      row["CustomSize"])
                };
                DBHelper.ExecuteNonQuery(itemQuery, itemParams);

                // Reduce stock
                DBHelper.ExecuteNonQuery("UPDATE Products SET Stock = Stock - @Qty WHERE ProductID = @ProductID",
                    new SqlParameter[] {
                        new SqlParameter("@Qty",       row["Quantity"]),
                        new SqlParameter("@ProductID", row["ProductID"])
                    });
            }

            // Record payment
            string payQuery = @"INSERT INTO Payments (OrderID, Amount, Method, Status)
                                VALUES (@OrderID, @Amount, @Method, 'Pending')";
            DBHelper.ExecuteNonQuery(payQuery, new SqlParameter[] {
                new SqlParameter("@OrderID", orderId),
                new SqlParameter("@Amount",  total),
                new SqlParameter("@Method",  payment)
            });

            // Clear cart
            DBHelper.ExecuteNonQuery("DELETE FROM Cart WHERE UserID = @UserID",
                new SqlParameter[] { new SqlParameter("@UserID", userId) });

            Response.Redirect("OrderConfirmation.aspx?id=" + orderId);
        }
    }
}

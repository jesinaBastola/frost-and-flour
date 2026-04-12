// FILE: ProductDetail.aspx.cs
// PURPOSE: Load product detail, handle add to cart and reviews

using System;
using System.Data;
using System.Data.SqlClient;

namespace FrostAndFlour
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int productId = Convert.ToInt32(Request.QueryString["id"]);
                LoadProduct(productId);
                LoadReviews(productId);

                // Show review form only if logged in
                if (Session["UserID"] != null)
                    pnlReview.Visible = true;
            }
        }

        private void LoadProduct(int productId)
        {
            string query = @"SELECT p.*, c.CategoryName FROM Products p 
                             JOIN Categories c ON p.CategoryID = c.CategoryID
                             WHERE p.ProductID = @ProductID";
            SqlParameter[] p = { new SqlParameter("@ProductID", productId) };
            DataTable dt = DBHelper.GetData(query, p);

            if (dt.Rows.Count == 0) { Response.Redirect("Products.aspx"); return; }

            DataRow row = dt.Rows[0];
            lblProductName.Text = row["ProductName"].ToString();
            lblDescription.Text = row["Description"].ToString();
            lblPrice.Text       = string.Format("{0:F2}", row["Price"]);
            lblStock.Text       = row["Stock"].ToString();
            lblCategory.Text    = row["CategoryName"].ToString();
        }

        private void LoadReviews(int productId)
        {
            string query = @"SELECT r.Rating, r.Comment, r.ReviewDate, u.FullName
                             FROM Reviews r JOIN Users u ON r.UserID = u.UserID
                             WHERE r.ProductID = @ProductID ORDER BY r.ReviewDate DESC";
            SqlParameter[] p = { new SqlParameter("@ProductID", productId) };
            DataTable dt = DBHelper.GetData(query, p);

            if (dt.Rows.Count == 0)
                lblNoReviews.Visible = true;
            else
            {
                rptReviews.DataSource = dt;
                rptReviews.DataBind();
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int productId = Convert.ToInt32(Request.QueryString["id"]);
            int userId    = Convert.ToInt32(Session["UserID"]);
            int qty       = Convert.ToInt32(txtQty.Text);
            string flavor  = ddlFlavor.SelectedValue;
            string size    = ddlSize.SelectedValue;
            string message = txtMessage.Text.Trim();

            // Check if already in cart → update quantity
            string checkQuery = @"SELECT CartID FROM Cart WHERE UserID = @UserID AND ProductID = @ProductID 
                                  AND CustomFlavor = @Flavor AND CustomSize = @Size";
            SqlParameter[] checkParams =
            {
                new SqlParameter("@UserID",    userId),
                new SqlParameter("@ProductID", productId),
                new SqlParameter("@Flavor",    flavor),
                new SqlParameter("@Size",      size)
            };
            object existing = DBHelper.ExecuteScalar(checkQuery, checkParams);

            if (existing != null)
            {
                string updateQuery = "UPDATE Cart SET Quantity = Quantity + @Qty WHERE CartID = @CartID";
                SqlParameter[] updateParams =
                {
                    new SqlParameter("@Qty",    qty),
                    new SqlParameter("@CartID", existing)
                };
                DBHelper.ExecuteNonQuery(updateQuery, updateParams);
            }
            else
            {
                string insertQuery = @"INSERT INTO Cart (UserID, ProductID, Quantity, CustomMessage, CustomFlavor, CustomSize)
                                       VALUES (@UserID, @ProductID, @Qty, @Message, @Flavor, @Size)";
                SqlParameter[] insertParams =
                {
                    new SqlParameter("@UserID",    userId),
                    new SqlParameter("@ProductID", productId),
                    new SqlParameter("@Qty",       qty),
                    new SqlParameter("@Message",   message),
                    new SqlParameter("@Flavor",    flavor),
                    new SqlParameter("@Size",      size)
                };
                DBHelper.ExecuteNonQuery(insertQuery, insertParams);
            }

            lblMessage.Text      = "✅ Added to cart!";
            lblMessage.CssClass += " text-green-600";
            lblMessage.Visible   = true;
        }

        protected void btnReview_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) return;

            int productId = Convert.ToInt32(Request.QueryString["id"]);
            int userId    = Convert.ToInt32(Session["UserID"]);
            int rating    = Convert.ToInt32(ddlRating.SelectedValue);
            string comment = txtReview.Text.Trim();

            string query = @"INSERT INTO Reviews (ProductID, UserID, Rating, Comment) 
                             VALUES (@ProductID, @UserID, @Rating, @Comment)";
            SqlParameter[] parameters =
            {
                new SqlParameter("@ProductID", productId),
                new SqlParameter("@UserID",    userId),
                new SqlParameter("@Rating",    rating),
                new SqlParameter("@Comment",   comment)
            };
            DBHelper.ExecuteNonQuery(query, parameters);
            Response.Redirect(Request.Url.ToString());
        }
    }
}

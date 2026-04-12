// FILE: Admin/ManageProducts.aspx.cs
// PURPOSE: CRUD for products

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace FrostAndFlour.Admin
{
    public partial class ManageProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"]?.ToString() != "Admin") Response.Redirect("~/Login.aspx");
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }
        }

        private void LoadCategories()
        {
            DataTable dt = DBHelper.GetData("SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName");
            ddlCategory.DataSource     = dt;
            ddlCategory.DataTextField  = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
        }

        private void LoadProducts()
        {
            string query = @"SELECT p.ProductID, p.ProductName, p.Price, p.Stock, p.IsAvailable, c.CategoryName
                             FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID
                             ORDER BY p.ProductName";
            DataTable dt = DBHelper.GetData(query);
            lblCount.Text = dt.Rows.Count.ToString();
            rptProducts.DataSource = dt;
            rptProducts.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int productId = Convert.ToInt32(hfProductId.Value);
            string name   = txtName.Text.Trim();
            int catId     = Convert.ToInt32(ddlCategory.SelectedValue);
            string desc   = txtDesc.Text.Trim();
            decimal price = Convert.ToDecimal(txtPrice.Text);
            int stock     = Convert.ToInt32(txtStock.Text);
            bool avail    = chkAvailable.Checked;

            if (productId == 0)
            {
                // INSERT
                string query = @"INSERT INTO Products (CategoryID, ProductName, Description, Price, Stock, IsAvailable)
                                 VALUES (@CatID, @Name, @Desc, @Price, @Stock, @Avail)";
                SqlParameter[] p =
                {
                    new SqlParameter("@CatID", catId),
                    new SqlParameter("@Name",  name),
                    new SqlParameter("@Desc",  desc),
                    new SqlParameter("@Price", price),
                    new SqlParameter("@Stock", stock),
                    new SqlParameter("@Avail", avail)
                };
                DBHelper.ExecuteNonQuery(query, p);
                lblMsg.Text = "✅ Product added successfully!";
            }
            else
            {
                // UPDATE
                string query = @"UPDATE Products SET CategoryID=@CatID, ProductName=@Name, Description=@Desc,
                                 Price=@Price, Stock=@Stock, IsAvailable=@Avail WHERE ProductID=@ProductID";
                SqlParameter[] p =
                {
                    new SqlParameter("@CatID",     catId),
                    new SqlParameter("@Name",      name),
                    new SqlParameter("@Desc",      desc),
                    new SqlParameter("@Price",     price),
                    new SqlParameter("@Stock",     stock),
                    new SqlParameter("@Avail",     avail),
                    new SqlParameter("@ProductID", productId)
                };
                DBHelper.ExecuteNonQuery(query, p);
                lblMsg.Text = "✅ Product updated successfully!";
            }

            lblMsg.CssClass = "block mt-3 font-medium text-green-600";
            lblMsg.Visible  = true;
            ClearForm();
            LoadProducts();
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                DBHelper.ExecuteNonQuery("DELETE FROM Products WHERE ProductID = @ID",
                    new SqlParameter[] { new SqlParameter("@ID", productId) });
            }
            else if (e.CommandName == "Edit")
            {
                string query = "SELECT * FROM Products WHERE ProductID = @ID";
                DataTable dt = DBHelper.GetData(query, new SqlParameter[] { new SqlParameter("@ID", productId) });

                if (dt.Rows.Count == 1)
                {
                    DataRow row        = dt.Rows[0];
                    hfProductId.Value  = row["ProductID"].ToString();
                    txtName.Text       = row["ProductName"].ToString();
                    txtDesc.Text       = row["Description"].ToString();
                    txtPrice.Text      = row["Price"].ToString();
                    txtStock.Text      = row["Stock"].ToString();
                    chkAvailable.Checked = Convert.ToBoolean(row["IsAvailable"]);
                    ddlCategory.SelectedValue = row["CategoryID"].ToString();
                    lblFormTitle.Text  = "Edit Product";
                }
            }
            LoadProducts();
        }

        protected void btnCancel_Click(object sender, EventArgs e) => ClearForm();

        private void ClearForm()
        {
            hfProductId.Value     = "0";
            txtName.Text          = "";
            txtDesc.Text          = "";
            txtPrice.Text         = "";
            txtStock.Text         = "";
            chkAvailable.Checked  = true;
            lblFormTitle.Text     = "Add New Product";
        }
    }
}

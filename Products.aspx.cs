// FILE: Products.aspx.cs
// PURPOSE: Load products with filtering and search

using System;
using System.Data;
using System.Data.SqlClient;

namespace FrostAndFlour
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts("", 0);
            }
        }

        private void LoadCategories()
        {
            DataTable dt = DBHelper.GetData("SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName");
            foreach (DataRow row in dt.Rows)
            {
                ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem(
                    row["CategoryName"].ToString(),
                    row["CategoryID"].ToString()
                ));
            }
        }

        private void LoadProducts(string search, int categoryId)
        {
            string query = @"SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, 
                                    c.CategoryName
                             FROM Products p
                             JOIN Categories c ON p.CategoryID = c.CategoryID
                             WHERE p.IsAvailable = 1
                               AND (@CategoryID = 0 OR p.CategoryID = @CategoryID)
                               AND (@Search = '' OR p.ProductName LIKE '%' + @Search + '%' 
                                              OR p.Description LIKE '%' + @Search + '%')
                             ORDER BY p.ProductName";

            SqlParameter[] parameters =
            {
                new SqlParameter("@CategoryID", categoryId),
                new SqlParameter("@Search",     search)
            };

            DataTable dt = DBHelper.GetData(query, parameters);

            if (dt.Rows.Count == 0)
            {
                lblNoResults.Visible = true;
                rptProducts.Visible  = false;
            }
            else
            {
                lblNoResults.Visible = false;
                rptProducts.Visible  = true;
                rptProducts.DataSource = dt;
                rptProducts.DataBind();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string search = txtSearch.Text.Trim();
            int categoryId = int.Parse(ddlCategory.SelectedValue);
            LoadProducts(search, categoryId);
        }
    }
}

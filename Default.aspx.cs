// FILE: Default.aspx.cs
// PURPOSE: Home page code-behind — loads featured products

using System;
using System.Data;

namespace FrostAndFlour
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeaturedProducts();
            }
        }

        private void LoadFeaturedProducts()
        {
            string query = "SELECT TOP 4 ProductID, ProductName, Description, Price FROM Products WHERE IsAvailable = 1 ORDER BY ProductID DESC";
            DataTable dt = DBHelper.GetData(query);
            rptFeatured.DataSource = dt;
            rptFeatured.DataBind();
        }
    }
}

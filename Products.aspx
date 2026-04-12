<%-- 
    FILE: Products.aspx
    PURPOSE: Browse all bakery products with category filter and search
    HOW TO ADD: Right-click project > Add > Web Form with Master Page > Products.aspx
--%>
<%@ Page Title="Shop" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="FrostAndFlour.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-7xl mx-auto px-4 py-10">
    <h1 class="text-3xl font-bold text-amber-800 mb-8">Our Products</h1>

    <!-- SEARCH & FILTER BAR -->
    <div class="bg-white rounded-xl shadow p-4 mb-8 flex flex-wrap gap-4 items-end">
        <div class="flex-1 min-w-48">
            <label class="text-sm font-medium text-gray-700">Search</label>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search products..."
                CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1 focus:outline-none focus:ring-2 focus:ring-amber-400" />
        </div>
        <div>
            <label class="text-sm font-medium text-gray-700">Category</label>
            <asp:DropDownList ID="ddlCategory" runat="server"
                CssClass="block border border-gray-300 rounded-lg px-3 py-2 mt-1 focus:outline-none focus:ring-2 focus:ring-amber-400">
                <asp:ListItem Value="0">All Categories</asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" OnClick="btnFilter_Click"
            CssClass="bg-amber-700 text-white px-6 py-2 rounded-lg hover:bg-amber-600 cursor-pointer" />
    </div>

    <!-- PRODUCTS GRID -->
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                <div class="bg-white rounded-xl shadow overflow-hidden hover:shadow-lg transition group">
                    <div class="bg-amber-100 h-48 flex items-center justify-center text-6xl group-hover:bg-amber-200 transition">
                        🎂
                    </div>
                    <div class="p-4">
                        <span class="text-xs text-amber-600 bg-amber-50 px-2 py-1 rounded-full"><%# Eval("CategoryName") %></span>
                        <h3 class="font-bold text-lg text-gray-800 mt-2"><%# Eval("ProductName") %></h3>
                        <p class="text-gray-500 text-sm mt-1 line-clamp-2"><%# Eval("Description") %></p>
                        <p class="text-amber-700 font-bold text-xl mt-3">Rs. <%# Eval("Price", "{0:F2}") %></p>
                        <p class="text-xs text-gray-400 mt-1">Stock: <%# Eval("Stock") %> left</p>
                        <div class="flex gap-2 mt-3">
                            <a href='ProductDetail.aspx?id=<%# Eval("ProductID") %>'
                               class="flex-1 bg-amber-700 text-white text-center py-2 rounded-lg hover:bg-amber-600 text-sm">
                                Order
                            </a>
                            <a href='Cart.aspx?addId=<%# Eval("ProductID") %>'
                               class="flex-1 border border-amber-700 text-amber-700 text-center py-2 rounded-lg hover:bg-amber-50 text-sm">
                                🛒 Cart
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- NO RESULTS MESSAGE -->
    <asp:Label ID="lblNoResults" runat="server" Visible="false"
        CssClass="block text-center text-gray-500 mt-10 text-lg" Text="No products found. Try a different search."></asp:Label>
</div>
</asp:Content>

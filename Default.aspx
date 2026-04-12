<%-- 
    FILE: Default.aspx
    PURPOSE: Home/landing page
    HOW TO ADD: This already exists in your project. Replace its content.
--%>
<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FrostAndFlour.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- HERO SECTION -->
    <section class="bg-gradient-to-r from-amber-800 to-amber-600 text-white py-24 text-center">
        <h1 class="text-5xl font-bold mb-4">Welcome to Frost & Flour</h1>
        <p class="text-xl mb-8 text-amber-100">Fresh baked cakes, pastries, cookies and more — delivered to your door.</p>
        <a href="Products.aspx" class="bg-white text-amber-800 font-bold px-8 py-3 rounded-full hover:bg-amber-100 text-lg">
            Order Now 🛍️
        </a>
    </section>

    <!-- FEATURED CATEGORIES -->
    <section class="max-w-7xl mx-auto px-4 py-14">
        <h2 class="text-3xl font-bold text-center text-amber-800 mb-10">Our Specialties</h2>
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            <% string[] cats = {"🎂 Cakes","🥐 Pastries","🍪 Cookies","🍞 Bread","🧁 Cupcakes","🍮 Desserts"}; %>
            <% foreach(var c in cats) { %>
                <a href="Products.aspx" class="bg-white rounded-xl shadow p-6 text-center hover:shadow-md hover:bg-amber-50 transition">
                    <p class="text-lg font-semibold text-amber-700"><%= c %></p>
                </a>
            <% } %>
        </div>
    </section>

    <!-- FEATURED PRODUCTS -->
    <section class="bg-white py-14">
        <div class="max-w-7xl mx-auto px-4">
            <h2 class="text-3xl font-bold text-center text-amber-800 mb-10">Best Sellers</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
                <asp:Repeater ID="rptFeatured" runat="server">
                    <ItemTemplate>
                        <div class="bg-amber-50 rounded-xl shadow overflow-hidden hover:shadow-lg transition">
                            <div class="bg-amber-200 h-48 flex items-center justify-center text-6xl">🎂</div>
                            <div class="p-4">
                                <h3 class="font-bold text-lg text-amber-900"><%# Eval("ProductName") %></h3>
                                <p class="text-gray-600 text-sm mt-1"><%# Eval("Description") %></p>
                                <p class="text-amber-700 font-bold mt-2">Rs. <%# Eval("Price", "{0:F2}") %></p>
                                <a href='ProductDetail.aspx?id=<%# Eval("ProductID") %>'
                                   class="block mt-3 bg-amber-700 text-white text-center py-2 rounded-lg hover:bg-amber-600">
                                    View &amp; Order
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- WHY CHOOSE US -->
    <section class="max-w-7xl mx-auto px-4 py-14">
        <h2 class="text-3xl font-bold text-center text-amber-800 mb-10">Why Choose Us?</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
            <div class="bg-white p-8 rounded-xl shadow">
                <div class="text-5xl mb-4">🌟</div>
                <h3 class="text-xl font-bold text-amber-800">Fresh Daily</h3>
                <p class="text-gray-600 mt-2">All products baked fresh every morning with quality ingredients.</p>
            </div>
            <div class="bg-white p-8 rounded-xl shadow">
                <div class="text-5xl mb-4">🎨</div>
                <h3 class="text-xl font-bold text-amber-800">Custom Cakes</h3>
                <p class="text-gray-600 mt-2">Personalize your cake — flavour, size, message and design.</p>
            </div>
            <div class="bg-white p-8 rounded-xl shadow">
                <div class="text-5xl mb-4">🚚</div>
                <h3 class="text-xl font-bold text-amber-800">Fast Delivery</h3>
                <p class="text-gray-600 mt-2">Track your order in real time from our bakery to your door.</p>
            </div>
        </div>
    </section>

</asp:Content>

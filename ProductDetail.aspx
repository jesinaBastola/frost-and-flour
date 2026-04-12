<%-- 
    FILE: ProductDetail.aspx
    PURPOSE: Show product details, allow customization and add to cart
    HOW TO ADD: Right-click project > Add > Web Form with Master Page > ProductDetail.aspx
--%>
<%@ Page Title="Product Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="FrostAndFlour.ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-4xl mx-auto px-4 py-10">

    <asp:Panel ID="pnlProduct" runat="server">
        <div class="bg-white rounded-2xl shadow-lg overflow-hidden flex flex-col md:flex-row">

            <!-- Product Image -->
            <div class="bg-amber-100 flex items-center justify-center text-9xl md:w-1/2 h-72 md:h-auto">🎂</div>

            <!-- Product Details -->
            <div class="p-8 flex flex-col justify-between md:w-1/2">
                <div>
                    <span class="text-sm text-amber-600 bg-amber-50 px-3 py-1 rounded-full">
                        <asp:Label ID="lblCategory" runat="server"></asp:Label>
                    </span>
                    <h1 class="text-3xl font-bold text-gray-800 mt-3">
                        <asp:Label ID="lblProductName" runat="server"></asp:Label>
                    </h1>
                    <p class="text-gray-500 mt-2">
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </p>
                    <p class="text-amber-700 font-bold text-3xl mt-4">
                        Rs. <asp:Label ID="lblPrice" runat="server"></asp:Label>
                    </p>
                    <p class="text-gray-400 text-sm mt-1">
                        In stock: <asp:Label ID="lblStock" runat="server"></asp:Label>
                    </p>
                </div>

                <!-- Customization Options -->
                <div class="mt-6 space-y-3 border-t pt-4">
                    <h3 class="font-semibold text-gray-700">Customize Your Order</h3>
                    <div>
                        <label class="text-sm text-gray-600">Flavor</label>
                        <asp:DropDownList ID="ddlFlavor" runat="server"
                            CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1">
                            <asp:ListItem>Vanilla</asp:ListItem>
                            <asp:ListItem>Chocolate</asp:ListItem>
                            <asp:ListItem>Red Velvet</asp:ListItem>
                            <asp:ListItem>Strawberry</asp:ListItem>
                            <asp:ListItem>Butterscotch</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div>
                        <label class="text-sm text-gray-600">Size</label>
                        <asp:DropDownList ID="ddlSize" runat="server"
                            CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1">
                            <asp:ListItem>Small (6")</asp:ListItem>
                            <asp:ListItem>Medium (8")</asp:ListItem>
                            <asp:ListItem>Large (10")</asp:ListItem>
                            <asp:ListItem>Extra Large (12")</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div>
                        <label class="text-sm text-gray-600">Custom Message (e.g. Happy Birthday!)</label>
                        <asp:TextBox ID="txtMessage" runat="server" placeholder="Write on the cake..."
                            CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1" MaxLength="100" />
                    </div>
                    <div>
                        <label class="text-sm text-gray-600">Quantity</label>
                        <asp:TextBox ID="txtQty" runat="server" Text="1" TextMode="Number"
                            CssClass="w-24 border border-gray-300 rounded-lg px-3 py-2 mt-1" />
                    </div>
                </div>

                <!-- Buttons -->
                <div class="mt-6 flex gap-3">
                    <asp:Button ID="btnAddToCart" runat="server" Text="🛒 Add to Cart" OnClick="btnAddToCart_Click"
                        CssClass="flex-1 bg-amber-700 text-white py-3 rounded-xl hover:bg-amber-600 font-bold cursor-pointer" />
                </div>

                <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="block mt-3 text-center font-medium"></asp:Label>
            </div>
        </div>
    </asp:Panel>

    <!-- REVIEWS SECTION -->
    <div class="mt-10 bg-white rounded-2xl shadow p-6">
        <h2 class="text-xl font-bold text-amber-800 mb-4">Customer Reviews</h2>
        <asp:Repeater ID="rptReviews" runat="server">
            <ItemTemplate>
                <div class="border-b pb-4 mb-4">
                    <p class="font-semibold text-gray-700"><%# Eval("FullName") %></p>
                    <p class="text-amber-500"><%# new string('★', Convert.ToInt32(Eval("Rating"))) %></p>
                    <p class="text-gray-600 mt-1"><%# Eval("Comment") %></p>
                    <p class="text-xs text-gray-400 mt-1"><%# Eval("ReviewDate", "{0:dd MMM yyyy}") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Label ID="lblNoReviews" runat="server" Text="No reviews yet. Be the first!" CssClass="text-gray-400" Visible="false" />

        <!-- Add Review (logged in users) -->
        <asp:Panel ID="pnlReview" runat="server" Visible="false" CssClass="mt-6 border-t pt-6">
            <h3 class="font-bold text-gray-700 mb-3">Leave a Review</h3>
            <div class="space-y-3">
                <div>
                    <label class="text-sm text-gray-600">Rating</label>
                    <asp:DropDownList ID="ddlRating" runat="server"
                        CssClass="border border-gray-300 rounded-lg px-3 py-2 mt-1">
                        <asp:ListItem Value="5">★★★★★ Excellent</asp:ListItem>
                        <asp:ListItem Value="4">★★★★ Good</asp:ListItem>
                        <asp:ListItem Value="3">★★★ Average</asp:ListItem>
                        <asp:ListItem Value="2">★★ Poor</asp:ListItem>
                        <asp:ListItem Value="1">★ Terrible</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div>
                    <label class="text-sm text-gray-600">Your Comment</label>
                    <asp:TextBox ID="txtReview" runat="server" TextMode="MultiLine" Rows="3"
                        placeholder="Share your experience..."
                        CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1" />
                </div>
                <asp:Button ID="btnReview" runat="server" Text="Submit Review" OnClick="btnReview_Click"
                    CssClass="bg-amber-700 text-white px-6 py-2 rounded-lg hover:bg-amber-600 cursor-pointer" />
            </div>
        </asp:Panel>
    </div>

</div>
</asp:Content>

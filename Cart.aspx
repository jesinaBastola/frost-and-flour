<%-- 
    FILE: Cart.aspx
    PURPOSE: Shopping cart — view, update, and checkout
    HOW TO ADD: Right-click project > Add > Web Form with Master Page > Cart.aspx
--%>
<%@ Page Title="My Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="FrostAndFlour.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-5xl mx-auto px-4 py-10">
    <h1 class="text-3xl font-bold text-amber-800 mb-8">Shopping Cart</h1>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="text-center py-20">
        <p class="text-6xl mb-4">🛒</p>
        <p class="text-gray-500 text-xl">Your cart is empty!</p>
        <a href="Products.aspx" class="mt-4 inline-block bg-amber-700 text-white px-8 py-3 rounded-xl hover:bg-amber-600">
            Start Shopping
        </a>
    </asp:Panel>

    <asp:Panel ID="pnlCart" runat="server">
        <div class="bg-white rounded-2xl shadow overflow-hidden">
            <!-- Cart Header -->
            <div class="grid grid-cols-12 bg-amber-800 text-white text-sm font-medium px-6 py-3">
                <div class="col-span-5">Product</div>
                <div class="col-span-2 text-center">Price</div>
                <div class="col-span-2 text-center">Qty</div>
                <div class="col-span-2 text-center">Subtotal</div>
                <div class="col-span-1 text-center">Del</div>
            </div>

            <!-- Cart Items -->
            <asp:Repeater ID="rptCart" runat="server">
                <ItemTemplate>
                    <div class="grid grid-cols-12 items-center px-6 py-4 border-b hover:bg-amber-50">
                        <div class="col-span-5">
                            <p class="font-semibold text-gray-800"><%# Eval("ProductName") %></p>
                            <p class="text-xs text-amber-600 mt-1">
                                <%# Eval("CustomFlavor") %> · <%# Eval("CustomSize") %>
                            </p>
                            <% if (!string.IsNullOrEmpty(Eval("CustomMessage")?.ToString())) { %>
                                <p class="text-xs text-gray-400 italic">"<%# Eval("CustomMessage") %>"</p>
                            <% } %>
                        </div>
                        <div class="col-span-2 text-center text-gray-700">Rs. <%# Eval("Price", "{0:F2}") %></div>
                        <div class="col-span-2 text-center text-gray-700"><%# Eval("Quantity") %></div>
                        <div class="col-span-2 text-center font-bold text-amber-700">
                            Rs. <%# string.Format("{0:F2}", Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %>
                        </div>
                        <div class="col-span-1 text-center">
                            <a href='Cart.aspx?removeId=<%# Eval("CartID") %>' class="text-red-500 hover:text-red-700 text-lg">✕</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Cart Total -->
            <div class="px-6 py-4 bg-amber-50 flex justify-between items-center">
                <p class="text-lg font-semibold text-gray-700">Total Amount:</p>
                <p class="text-2xl font-bold text-amber-800">Rs. <asp:Label ID="lblTotal" runat="server"></asp:Label></p>
            </div>
        </div>

        <!-- Delivery Address -->
        <div class="bg-white rounded-2xl shadow p-6 mt-6">
            <h2 class="text-xl font-bold text-gray-700 mb-4">Delivery Details</h2>
            <div class="space-y-3">
                <div>
                    <label class="text-sm text-gray-600">Delivery Address</label>
                    <asp:TextBox ID="txtDeliveryAddress" runat="server" TextMode="MultiLine" Rows="2"
                        placeholder="Enter your delivery address..."
                        CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1 focus:outline-none focus:ring-2 focus:ring-amber-400" />
                </div>
                <div>
                    <label class="text-sm text-gray-600">Special Instructions</label>
                    <asp:TextBox ID="txtNotes" runat="server"
                        placeholder="Any special delivery notes..."
                        CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1" />
                </div>
                <div>
                    <label class="text-sm text-gray-600">Payment Method</label>
                    <asp:DropDownList ID="ddlPayment" runat="server"
                        CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1">
                        <asp:ListItem Value="Cash on Delivery">Cash on Delivery</asp:ListItem>
                        <asp:ListItem Value="Card">Card Payment</asp:ListItem>
                        <asp:ListItem Value="eSewa">eSewa</asp:ListItem>
                        <asp:ListItem Value="Khalti">Khalti</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <!-- Checkout Button -->
        <div class="mt-6 flex gap-4">
            <a href="Products.aspx" class="flex-1 border border-amber-700 text-amber-700 text-center py-3 rounded-xl hover:bg-amber-50 font-medium">
                ← Continue Shopping
            </a>
            <asp:Button ID="btnCheckout" runat="server" Text="Place Order →" OnClick="btnCheckout_Click"
                CssClass="flex-1 bg-amber-700 text-white py-3 rounded-xl hover:bg-amber-600 font-bold cursor-pointer" />
        </div>

        <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="block text-center mt-4 font-medium"></asp:Label>
    </asp:Panel>
</div>
</asp:Content>

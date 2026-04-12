<%-- 
    FILE: OrderDetail.aspx
    PURPOSE: Show full details of a single order
--%>
<%@ Page Title="Order Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="FrostAndFlour.OrderDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-3xl mx-auto px-4 py-10">
    <a href="Orders.aspx" class="text-amber-700 hover:underline text-sm">← Back to My Orders</a>

    <div class="bg-white rounded-2xl shadow-lg mt-4 overflow-hidden">
        <!-- Order Header -->
        <div class="bg-amber-800 text-white px-6 py-4 flex justify-between items-center">
            <div>
                <h1 class="text-xl font-bold">Order #<asp:Label ID="lblOrderId" runat="server"></asp:Label></h1>
                <p class="text-amber-200 text-sm"><asp:Label ID="lblOrderDate" runat="server"></asp:Label></p>
            </div>
            <asp:Label ID="lblStatus" runat="server" CssClass="px-4 py-1 rounded-full text-sm font-bold"></asp:Label>
        </div>

        <!-- Order Items -->
        <div class="px-6 py-4">
            <h2 class="font-bold text-gray-700 mb-3">Items Ordered</h2>
            <asp:Repeater ID="rptItems" runat="server">
                <ItemTemplate>
                    <div class="flex justify-between items-center border-b py-3">
                        <div>
                            <p class="font-medium text-gray-800"><%# Eval("ProductName") %></p>
                            <p class="text-xs text-amber-600"><%# Eval("CustomFlavor") %> · <%# Eval("CustomSize") %></p>
                            <% if (!string.IsNullOrEmpty(Eval("CustomMessage")?.ToString())) { %>
                                <p class="text-xs text-gray-400 italic">"<%# Eval("CustomMessage") %>"</p>
                            <% } %>
                            <p class="text-xs text-gray-500">Qty: <%# Eval("Quantity") %> × Rs. <%# Eval("UnitPrice", "{0:F2}") %></p>
                        </div>
                        <p class="font-bold text-amber-700">
                            Rs. <%# string.Format("{0:F2}", Convert.ToDecimal(Eval("UnitPrice")) * Convert.ToInt32(Eval("Quantity"))) %>
                        </p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Summary -->
            <div class="mt-4 space-y-2">
                <div class="flex justify-between text-gray-600">
                    <span>Delivery Address:</span>
                    <span class="font-medium"><asp:Label ID="lblAddress" runat="server"></asp:Label></span>
                </div>
                <div class="flex justify-between text-gray-600">
                    <span>Payment Method:</span>
                    <span class="font-medium"><asp:Label ID="lblPayment" runat="server"></asp:Label></span>
                </div>
                <div class="flex justify-between text-xl font-bold text-amber-800 border-t pt-3 mt-3">
                    <span>Total Amount:</span>
                    <span>Rs. <asp:Label ID="lblTotal" runat="server"></asp:Label></span>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>

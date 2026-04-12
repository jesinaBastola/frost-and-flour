<%-- 
    FILE: Orders.aspx
    PURPOSE: Customer's order history and tracking
--%>
<%@ Page Title="My Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="FrostAndFlour.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-5xl mx-auto px-4 py-10">
    <h1 class="text-3xl font-bold text-amber-800 mb-8">My Orders</h1>

    <asp:Repeater ID="rptOrders" runat="server">
        <ItemTemplate>
            <div class="bg-white rounded-2xl shadow mb-6 overflow-hidden">
                <!-- Order Header -->
                <div class="bg-amber-800 text-white px-6 py-3 flex justify-between items-center">
                    <div>
                        <span class="font-bold">Order #<%# Eval("OrderID") %></span>
                        <span class="text-amber-200 text-sm ml-4"><%# Eval("OrderDate", "{0:dd MMM yyyy hh:mm tt}") %></span>
                    </div>
                    <span class='px-3 py-1 rounded-full text-sm font-medium
                        <%# GetStatusClass(Eval("Status").ToString()) %>'>
                        <%# Eval("Status") %>
                    </span>
                </div>

                <!-- Order Details -->
                <div class="px-6 py-4">
                    <p class="text-gray-600 text-sm">📍 <%# Eval("DeliveryAddress") %></p>
                    <p class="text-amber-800 font-bold text-lg mt-2">Total: Rs. <%# Eval("TotalAmount", "{0:F2}") %></p>

                    <!-- Delivery Progress Bar -->
                    <div class="mt-4">
                        <div class="flex justify-between text-xs text-gray-500 mb-1">
                            <span>Pending</span><span>Confirmed</span><span>Preparing</span><span>Out for Delivery</span><span>Delivered</span>
                        </div>
                        <div class="h-2 bg-gray-200 rounded-full">
                            <div class="h-2 bg-amber-600 rounded-full transition-all"
                                 style="width: <%# GetProgressWidth(Eval("Status").ToString()) %>%"></div>
                        </div>
                    </div>

                    <a href='OrderDetail.aspx?id=<%# Eval("OrderID") %>'
                       class="inline-block mt-4 text-amber-700 text-sm font-medium hover:underline">
                        View Order Details →
                    </a>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

    <asp:Label ID="lblNoOrders" runat="server" Visible="false"
        CssClass="block text-center text-gray-500 py-16 text-lg"
        Text="You haven't placed any orders yet." />
</div>
</asp:Content>

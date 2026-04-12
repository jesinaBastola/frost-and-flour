<%-- 
    FILE: OrderConfirmation.aspx
    PURPOSE: Show order confirmation after checkout
--%>
<%@ Page Title="Order Confirmed" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="FrostAndFlour.OrderConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-2xl mx-auto px-4 py-16 text-center">
    <div class="bg-white rounded-2xl shadow-lg p-10">
        <div class="text-7xl mb-6">🎉</div>
        <h1 class="text-3xl font-bold text-amber-800 mb-2">Order Placed Successfully!</h1>
        <p class="text-gray-500 mb-6">Thank you for your order. We'll start preparing it right away!</p>

        <div class="bg-amber-50 rounded-xl p-6 text-left mb-6">
            <p class="text-sm text-gray-600">Order ID: <strong class="text-amber-800">
                <asp:Label ID="lblOrderId" runat="server"></asp:Label></strong></p>
            <p class="text-sm text-gray-600 mt-1">Total: <strong class="text-amber-800">
                Rs. <asp:Label ID="lblTotal" runat="server"></asp:Label></strong></p>
            <p class="text-sm text-gray-600 mt-1">Status: <strong class="text-green-600">Pending</strong></p>
            <p class="text-sm text-gray-600 mt-1">Delivery Address: 
                <asp:Label ID="lblAddress" runat="server"></asp:Label></p>
        </div>

        <div class="flex gap-4 justify-center">
            <a href="Orders.aspx" class="bg-amber-700 text-white px-8 py-3 rounded-xl hover:bg-amber-600 font-medium">
                Track My Order
            </a>
            <a href="Products.aspx" class="border border-amber-700 text-amber-700 px-8 py-3 rounded-xl hover:bg-amber-50 font-medium">
                Continue Shopping
            </a>
        </div>
    </div>
</div>
</asp:Content>

<%-- 
    FILE: Admin/Dashboard.aspx
    PURPOSE: Admin overview — stats, recent orders
    HOW TO ADD: Right-click project > Add > New Folder "Admin"
                Then inside Admin folder: Add > Web Form with Master Page > Dashboard.aspx
--%>
<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="FrostAndFlour.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-7xl mx-auto px-4 py-10">
    <h1 class="text-3xl font-bold text-amber-800 mb-8">Admin Dashboard</h1>

    <!-- STATS CARDS -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-6 mb-10">
        <div class="bg-white rounded-2xl shadow p-6 text-center">
            <p class="text-4xl font-bold text-amber-700"><asp:Label ID="lblTotalOrders" runat="server">0</asp:Label></p>
            <p class="text-gray-500 mt-1">Total Orders</p>
        </div>
        <div class="bg-white rounded-2xl shadow p-6 text-center">
            <p class="text-4xl font-bold text-green-600"><asp:Label ID="lblRevenue" runat="server">0</asp:Label></p>
            <p class="text-gray-500 mt-1">Total Revenue (Rs.)</p>
        </div>
        <div class="bg-white rounded-2xl shadow p-6 text-center">
            <p class="text-4xl font-bold text-blue-600"><asp:Label ID="lblCustomers" runat="server">0</asp:Label></p>
            <p class="text-gray-500 mt-1">Customers</p>
        </div>
        <div class="bg-white rounded-2xl shadow p-6 text-center">
            <p class="text-4xl font-bold text-purple-600"><asp:Label ID="lblProducts" runat="server">0</asp:Label></p>
            <p class="text-gray-500 mt-1">Products</p>
        </div>
    </div>

    <!-- QUICK LINKS -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-10">
        <a href="ManageProducts.aspx" class="bg-amber-700 text-white rounded-xl p-5 text-center hover:bg-amber-600">
            <p class="text-3xl">📦</p><p class="font-bold mt-2">Manage Products</p>
        </a>
        <a href="ManageOrders.aspx" class="bg-blue-700 text-white rounded-xl p-5 text-center hover:bg-blue-600">
            <p class="text-3xl">🧾</p><p class="font-bold mt-2">Manage Orders</p>
        </a>
        <a href="ManageCustomers.aspx" class="bg-green-700 text-white rounded-xl p-5 text-center hover:bg-green-600">
            <p class="text-3xl">👥</p><p class="font-bold mt-2">Customers</p>
        </a>
        <a href="SalesReport.aspx" class="bg-purple-700 text-white rounded-xl p-5 text-center hover:bg-purple-600">
            <p class="text-3xl">📊</p><p class="font-bold mt-2">Sales Report</p>
        </a>
    </div>

    <!-- PENDING ORDERS -->
    <div class="bg-white rounded-2xl shadow overflow-hidden">
        <div class="bg-amber-800 text-white px-6 py-3 flex justify-between">
            <h2 class="font-bold text-lg">Pending Orders</h2>
            <a href="ManageOrders.aspx" class="text-amber-200 text-sm hover:underline">View All →</a>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-sm">
                <thead class="bg-amber-50">
                    <tr>
                        <th class="px-4 py-3 text-left">Order ID</th>
                        <th class="px-4 py-3 text-left">Customer</th>
                        <th class="px-4 py-3 text-left">Amount</th>
                        <th class="px-4 py-3 text-left">Date</th>
                        <th class="px-4 py-3 text-left">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptPending" runat="server">
                        <ItemTemplate>
                            <tr class="border-b hover:bg-amber-50">
                                <td class="px-4 py-3 font-medium">#<%# Eval("OrderID") %></td>
                                <td class="px-4 py-3"><%# Eval("FullName") %></td>
                                <td class="px-4 py-3 font-bold text-amber-700">Rs. <%# Eval("TotalAmount", "{0:F2}") %></td>
                                <td class="px-4 py-3 text-gray-500"><%# Eval("OrderDate", "{0:dd MMM yyyy}") %></td>
                                <td class="px-4 py-3">
                                    <a href='ManageOrders.aspx?id=<%# Eval("OrderID") %>'
                                       class="bg-amber-600 text-white px-3 py-1 rounded text-xs hover:bg-amber-500">
                                        Process
                                    </a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</div>
</asp:Content>

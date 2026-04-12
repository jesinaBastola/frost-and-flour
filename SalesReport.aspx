<%-- 
    FILE: Admin/SalesReport.aspx
    PURPOSE: Admin — view sales analytics and reports
--%>
<%@ Page Title="Sales Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesReport.aspx.cs" Inherits="FrostAndFlour.Admin.SalesReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-7xl mx-auto px-4 py-10">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-amber-800">Sales Report</h1>
        <a href="Dashboard.aspx" class="text-amber-700 hover:underline text-sm">← Dashboard</a>
    </div>

    <!-- SUMMARY STATS -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-6 mb-10">
        <div class="bg-white rounded-2xl shadow p-6 text-center">
            <p class="text-3xl font-bold text-amber-700">Rs. <asp:Label ID="lblTotalRevenue" runat="server">0</asp:Label></p>
            <p class="text-gray-500 mt-1 text-sm">Total Revenue</p>
        </div>
        <div class="bg-white rounded-2xl shadow p-6 text-center">
            <p class="text-3xl font-bold text-green-600"><asp:Label ID="lblDelivered" runat="server">0</asp:Label></p>
            <p class="text-gray-500 mt-1 text-sm">Delivered Orders</p>
        </div>
        <div class="bg-white rounded-2xl shadow p-6 text-center">
            <p class="text-3xl font-bold text-blue-600"><asp:Label ID="lblThisMonth" runat="server">0</asp:Label></p>
            <p class="text-gray-500 mt-1 text-sm">Orders This Month</p>
        </div>
        <div class="bg-white rounded-2xl shadow p-6 text-center">
            <p class="text-3xl font-bold text-purple-600">Rs. <asp:Label ID="lblAvgOrder" runat="server">0</asp:Label></p>
            <p class="text-gray-500 mt-1 text-sm">Avg Order Value</p>
        </div>
    </div>

    <!-- TOP PRODUCTS -->
    <div class="bg-white rounded-2xl shadow overflow-hidden mb-8">
        <div class="bg-amber-800 text-white px-6 py-3">
            <h2 class="font-bold">Top Selling Products</h2>
        </div>
        <table class="w-full text-sm">
            <thead class="bg-amber-50">
                <tr>
                    <th class="px-4 py-3 text-left">Product</th>
                    <th class="px-4 py-3 text-left">Category</th>
                    <th class="px-4 py-3 text-left">Units Sold</th>
                    <th class="px-4 py-3 text-left">Revenue</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptTopProducts" runat="server">
                    <ItemTemplate>
                        <tr class="border-b hover:bg-amber-50">
                            <td class="px-4 py-3 font-medium"><%# Eval("ProductName") %></td>
                            <td class="px-4 py-3 text-gray-500"><%# Eval("CategoryName") %></td>
                            <td class="px-4 py-3 font-bold"><%# Eval("UnitsSold") %></td>
                            <td class="px-4 py-3 font-bold text-amber-700">Rs. <%# Eval("Revenue", "{0:F2}") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <!-- MONTHLY BREAKDOWN -->
    <div class="bg-white rounded-2xl shadow overflow-hidden">
        <div class="bg-amber-800 text-white px-6 py-3">
            <h2 class="font-bold">Monthly Sales (Last 6 Months)</h2>
        </div>
        <table class="w-full text-sm">
            <thead class="bg-amber-50">
                <tr>
                    <th class="px-4 py-3 text-left">Month</th>
                    <th class="px-4 py-3 text-left">Orders</th>
                    <th class="px-4 py-3 text-left">Revenue</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptMonthly" runat="server">
                    <ItemTemplate>
                        <tr class="border-b hover:bg-amber-50">
                            <td class="px-4 py-3 font-medium"><%# Eval("MonthYear") %></td>
                            <td class="px-4 py-3"><%# Eval("OrderCount") %></td>
                            <td class="px-4 py-3 font-bold text-amber-700">Rs. <%# Eval("Revenue", "{0:F2}") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</div>
</asp:Content>

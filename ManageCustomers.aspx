<%-- 
    FILE: Admin/ManageCustomers.aspx
    PURPOSE: Admin — view all customers
--%>
<%@ Page Title="Manage Customers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageCustomers.aspx.cs" Inherits="FrostAndFlour.Admin.ManageCustomers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-6xl mx-auto px-4 py-10">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-amber-800">Manage Customers</h1>
        <a href="Dashboard.aspx" class="text-amber-700 hover:underline text-sm">← Dashboard</a>
    </div>

    <div class="bg-white rounded-2xl shadow overflow-hidden">
        <div class="bg-amber-800 text-white px-6 py-3">
            <h2 class="font-bold">All Customers (<asp:Label ID="lblCount" runat="server"></asp:Label>)</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-sm">
                <thead class="bg-amber-50">
                    <tr>
                        <th class="px-4 py-3 text-left">Name</th>
                        <th class="px-4 py-3 text-left">Email</th>
                        <th class="px-4 py-3 text-left">Phone</th>
                        <th class="px-4 py-3 text-left">Total Orders</th>
                        <th class="px-4 py-3 text-left">Total Spent</th>
                        <th class="px-4 py-3 text-left">Joined</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptCustomers" runat="server">
                        <ItemTemplate>
                            <tr class="border-b hover:bg-amber-50">
                                <td class="px-4 py-3 font-medium"><%# Eval("FullName") %></td>
                                <td class="px-4 py-3 text-gray-600"><%# Eval("Email") %></td>
                                <td class="px-4 py-3 text-gray-600"><%# Eval("Phone") %></td>
                                <td class="px-4 py-3 font-bold"><%# Eval("TotalOrders") %></td>
                                <td class="px-4 py-3 font-bold text-amber-700">Rs. <%# Eval("TotalSpent", "{0:F2}") %></td>
                                <td class="px-4 py-3 text-gray-400"><%# Eval("CreatedAt", "{0:dd MMM yyyy}") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</div>
</asp:Content>

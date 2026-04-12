<%-- 
    FILE: Admin/ManageOrders.aspx
    PURPOSE: Admin — view all orders, update status
--%>
<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageOrders.aspx.cs" Inherits="FrostAndFlour.Admin.ManageOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-7xl mx-auto px-4 py-10">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-amber-800">Manage Orders</h1>
        <a href="Dashboard.aspx" class="text-amber-700 hover:underline text-sm">← Dashboard</a>
    </div>

    <!-- FILTER -->
    <div class="bg-white rounded-xl shadow p-4 mb-6 flex gap-4 items-end">
        <div>
            <label class="text-sm text-gray-600">Filter by Status</label>
            <asp:DropDownList ID="ddlStatus" runat="server"
                CssClass="block border border-gray-300 rounded-lg px-3 py-2 mt-1">
                <asp:ListItem Value="">All Orders</asp:ListItem>
                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                <asp:ListItem Value="Confirmed">Confirmed</asp:ListItem>
                <asp:ListItem Value="Preparing">Preparing</asp:ListItem>
                <asp:ListItem Value="Out for Delivery">Out for Delivery</asp:ListItem>
                <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" OnClick="btnFilter_Click"
            CssClass="bg-amber-700 text-white px-5 py-2 rounded-lg hover:bg-amber-600 cursor-pointer" />
    </div>

    <!-- ORDERS TABLE -->
    <div class="bg-white rounded-2xl shadow overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-sm">
                <thead class="bg-amber-800 text-white">
                    <tr>
                        <th class="px-4 py-3 text-left">Order ID</th>
                        <th class="px-4 py-3 text-left">Customer</th>
                        <th class="px-4 py-3 text-left">Total</th>
                        <th class="px-4 py-3 text-left">Date</th>
                        <th class="px-4 py-3 text-left">Status</th>
                        <th class="px-4 py-3 text-left">Update Status</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                        <ItemTemplate>
                            <tr class="border-b hover:bg-amber-50">
                                <td class="px-4 py-3 font-medium">#<%# Eval("OrderID") %></td>
                                <td class="px-4 py-3">
                                    <p class="font-medium"><%# Eval("FullName") %></p>
                                    <p class="text-xs text-gray-400"><%# Eval("Email") %></p>
                                </td>
                                <td class="px-4 py-3 font-bold text-amber-700">Rs. <%# Eval("TotalAmount", "{0:F2}") %></td>
                                <td class="px-4 py-3 text-gray-500"><%# Eval("OrderDate", "{0:dd MMM yyyy}") %></td>
                                <td class="px-4 py-3">
                                    <span class="px-2 py-1 rounded text-xs bg-amber-100 text-amber-800"><%# Eval("Status") %></span>
                                </td>
                                <td class="px-4 py-3 flex gap-1 flex-wrap">
                                    <asp:LinkButton CommandName="Confirm" CommandArgument='<%# Eval("OrderID") %>' runat="server"
                                        CssClass="bg-blue-500 text-white px-2 py-1 rounded text-xs hover:bg-blue-400">Confirm</asp:LinkButton>
                                    <asp:LinkButton CommandName="Prepare" CommandArgument='<%# Eval("OrderID") %>' runat="server"
                                        CssClass="bg-purple-500 text-white px-2 py-1 rounded text-xs hover:bg-purple-400">Preparing</asp:LinkButton>
                                    <asp:LinkButton CommandName="OutForDelivery" CommandArgument='<%# Eval("OrderID") %>' runat="server"
                                        CssClass="bg-orange-500 text-white px-2 py-1 rounded text-xs hover:bg-orange-400">Out for Delivery</asp:LinkButton>
                                    <asp:LinkButton CommandName="Deliver" CommandArgument='<%# Eval("OrderID") %>' runat="server"
                                        CssClass="bg-green-600 text-white px-2 py-1 rounded text-xs hover:bg-green-500">Delivered</asp:LinkButton>
                                    <asp:LinkButton CommandName="Cancel" CommandArgument='<%# Eval("OrderID") %>' runat="server"
                                        CssClass="bg-red-500 text-white px-2 py-1 rounded text-xs hover:bg-red-400"
                                        OnClientClick="return confirm('Cancel this order?')">Cancel</asp:LinkButton>
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

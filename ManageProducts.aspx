<%-- 
    FILE: Admin/ManageProducts.aspx
    PURPOSE: Admin — Add, Edit, Delete products
--%>
<%@ Page Title="Manage Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProducts.aspx.cs" Inherits="FrostAndFlour.Admin.ManageProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-7xl mx-auto px-4 py-10">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-amber-800">Manage Products</h1>
        <a href="Dashboard.aspx" class="text-amber-700 hover:underline text-sm">← Dashboard</a>
    </div>

    <!-- ADD / EDIT FORM -->
    <div class="bg-white rounded-2xl shadow p-6 mb-8">
        <h2 class="text-xl font-bold text-gray-700 mb-4">
            <asp:Label ID="lblFormTitle" runat="server" Text="Add New Product"></asp:Label>
        </h2>
        <asp:HiddenField ID="hfProductId" runat="server" Value="0" />

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
                <label class="text-sm text-gray-600">Product Name *</label>
                <asp:TextBox ID="txtName" runat="server"
                    CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1" />
                <asp:RequiredFieldValidator ControlToValidate="txtName" runat="server"
                    ErrorMessage="Required" CssClass="text-red-500 text-xs" Display="Dynamic" />
            </div>
            <div>
                <label class="text-sm text-gray-600">Category *</label>
                <asp:DropDownList ID="ddlCategory" runat="server"
                    CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1" />
            </div>
            <div class="md:col-span-2">
                <label class="text-sm text-gray-600">Description</label>
                <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Rows="2"
                    CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1" />
            </div>
            <div>
                <label class="text-sm text-gray-600">Price (Rs.) *</label>
                <asp:TextBox ID="txtPrice" runat="server" TextMode="Number"
                    CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1" />
                <asp:RequiredFieldValidator ControlToValidate="txtPrice" runat="server"
                    ErrorMessage="Required" CssClass="text-red-500 text-xs" Display="Dynamic" />
            </div>
            <div>
                <label class="text-sm text-gray-600">Stock Quantity *</label>
                <asp:TextBox ID="txtStock" runat="server" TextMode="Number"
                    CssClass="w-full border border-gray-300 rounded-lg px-3 py-2 mt-1" />
                <asp:RequiredFieldValidator ControlToValidate="txtStock" runat="server"
                    ErrorMessage="Required" CssClass="text-red-500 text-xs" Display="Dynamic" />
            </div>
            <div>
                <label class="text-sm text-gray-600">Available?</label><br />
                <asp:CheckBox ID="chkAvailable" runat="server" Checked="true" Text=" Yes, show on site" />
            </div>
        </div>

        <div class="flex gap-3 mt-5">
            <asp:Button ID="btnSave" runat="server" Text="Save Product" OnClick="btnSave_Click"
                CssClass="bg-amber-700 text-white px-6 py-2 rounded-lg hover:bg-amber-600 cursor-pointer" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                CssClass="border border-gray-400 text-gray-600 px-6 py-2 rounded-lg hover:bg-gray-50 cursor-pointer" CausesValidation="false" />
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="block mt-3 font-medium"></asp:Label>
    </div>

    <!-- PRODUCTS TABLE -->
    <div class="bg-white rounded-2xl shadow overflow-hidden">
        <div class="bg-amber-800 text-white px-6 py-3">
            <h2 class="font-bold">All Products (<asp:Label ID="lblCount" runat="server"></asp:Label>)</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-sm">
                <thead class="bg-amber-50">
                    <tr>
                        <th class="px-4 py-3 text-left">Name</th>
                        <th class="px-4 py-3 text-left">Category</th>
                        <th class="px-4 py-3 text-left">Price</th>
                        <th class="px-4 py-3 text-left">Stock</th>
                        <th class="px-4 py-3 text-left">Status</th>
                        <th class="px-4 py-3 text-left">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                        <ItemTemplate>
                            <tr class="border-b hover:bg-amber-50">
                                <td class="px-4 py-3 font-medium"><%# Eval("ProductName") %></td>
                                <td class="px-4 py-3 text-gray-500"><%# Eval("CategoryName") %></td>
                                <td class="px-4 py-3 font-bold text-amber-700">Rs. <%# Eval("Price", "{0:F2}") %></td>
                                <td class="px-4 py-3">
                                    <span class='<%# Convert.ToInt32(Eval("Stock")) < 5 ? "text-red-600 font-bold" : "" %>'>
                                        <%# Eval("Stock") %>
                                    </span>
                                </td>
                                <td class="px-4 py-3">
                                    <span class='px-2 py-1 rounded text-xs <%# Convert.ToBoolean(Eval("IsAvailable")) ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700" %>'>
                                        <%# Convert.ToBoolean(Eval("IsAvailable")) ? "Active" : "Hidden" %>
                                    </span>
                                </td>
                                <td class="px-4 py-3 flex gap-2">
                                    <asp:LinkButton CommandName="Edit" CommandArgument='<%# Eval("ProductID") %>' runat="server"
                                        CssClass="bg-blue-600 text-white px-3 py-1 rounded text-xs hover:bg-blue-500">Edit</asp:LinkButton>
                                    <asp:LinkButton CommandName="Delete" CommandArgument='<%# Eval("ProductID") %>' runat="server"
                                        CssClass="bg-red-500 text-white px-3 py-1 rounded text-xs hover:bg-red-400"
                                        OnClientClick="return confirm('Delete this product?')">Delete</asp:LinkButton>
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

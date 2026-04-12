<%-- 
    FILE: Login.aspx
    PURPOSE: Login page for customers and admin
    HOW TO ADD: Right-click project > Add > Web Form with Master Page > Login.aspx
--%>
<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FrostAndFlour.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-md mx-auto mt-16 mb-16 bg-white rounded-2xl shadow-lg p-8">
    <h2 class="text-3xl font-bold text-amber-800 text-center mb-2">Welcome Back</h2>
    <p class="text-center text-gray-500 mb-6">Login to your Frost & Flour account</p>

    <% if (Request.QueryString["registered"] == "1") { %>
        <div class="bg-green-100 text-green-700 rounded-lg p-3 mb-4 text-center">
            ✅ Account created successfully! Please login.
        </div>
    <% } %>

    <asp:Label ID="lblMessage" runat="server" CssClass="block text-center text-red-600 mb-4" Visible="false"></asp:Label>

    <div class="space-y-4">
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="you@email.com"
                CssClass="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400" />
            <asp:RequiredFieldValidator ControlToValidate="txtEmail" runat="server"
                ErrorMessage="Email is required" CssClass="text-red-500 text-xs" Display="Dynamic" />
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Your password"
                CssClass="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400" />
            <asp:RequiredFieldValidator ControlToValidate="txtPassword" runat="server"
                ErrorMessage="Password is required" CssClass="text-red-500 text-xs" Display="Dynamic" />
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"
            CssClass="w-full bg-amber-700 hover:bg-amber-600 text-white font-bold py-3 rounded-lg mt-2 cursor-pointer" />
    </div>

    <p class="text-center text-gray-500 mt-4 text-sm">
        Don't have an account? <a href="Register.aspx" class="text-amber-700 font-medium hover:underline">Sign up here</a>
    </p>
</div>
</asp:Content>

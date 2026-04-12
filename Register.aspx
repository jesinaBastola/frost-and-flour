<%-- 
    FILE: Register.aspx
    PURPOSE: Customer sign-up page
    HOW TO ADD: Right-click project > Add > Web Form with Master Page > Register.aspx
--%>
<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FrostAndFlour.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="max-w-md mx-auto mt-16 mb-16 bg-white rounded-2xl shadow-lg p-8">
    <h2 class="text-3xl font-bold text-amber-800 text-center mb-2">Create Account</h2>
    <p class="text-center text-gray-500 mb-6">Join Frost & Flour today</p>

    <asp:Label ID="lblMessage" runat="server" CssClass="block text-center text-red-600 mb-4" Visible="false"></asp:Label>

    <div class="space-y-4">
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
            <asp:TextBox ID="txtFullName" runat="server" placeholder="Your full name"
                CssClass="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400" />
            <asp:RequiredFieldValidator ControlToValidate="txtFullName" runat="server"
                ErrorMessage="Full name is required" CssClass="text-red-500 text-xs" Display="Dynamic" />
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="you@email.com"
                CssClass="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400" />
            <asp:RequiredFieldValidator ControlToValidate="txtEmail" runat="server"
                ErrorMessage="Email is required" CssClass="text-red-500 text-xs" Display="Dynamic" />
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
            <asp:TextBox ID="txtPhone" runat="server" placeholder="98XXXXXXXX"
                CssClass="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400" />
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Delivery Address</label>
            <asp:TextBox ID="txtAddress" runat="server" placeholder="Street, City"
                CssClass="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400" />
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Minimum 6 characters"
                CssClass="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400" />
            <asp:RequiredFieldValidator ControlToValidate="txtPassword" runat="server"
                ErrorMessage="Password is required" CssClass="text-red-500 text-xs" Display="Dynamic" />
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
            <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" placeholder="Re-enter password"
                CssClass="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400" />
            <asp:CompareValidator ControlToValidate="txtConfirm" ControlToCompare="txtPassword" runat="server"
                ErrorMessage="Passwords do not match" CssClass="text-red-500 text-xs" Display="Dynamic" />
        </div>

        <asp:Button ID="btnRegister" runat="server" Text="Create Account" OnClick="btnRegister_Click"
            CssClass="w-full bg-amber-700 hover:bg-amber-600 text-white font-bold py-3 rounded-lg mt-2 cursor-pointer" />
    </div>

    <p class="text-center text-gray-500 mt-4 text-sm">
        Already have an account? <a href="Login.aspx" class="text-amber-700 font-medium hover:underline">Login here</a>
    </p>
</div>
</asp:Content>

<%@ Page Title="Programme Requirement Checker" Language="C#" MasterPageFile="~/Client/MasterPage/MasterPage.Master" AutoEventWireup="true" CodeBehind="spm_req.aspx.cs" Inherits="SEMASGN.Client.MinReq.spm_req" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="w-[80%] border border-black m-auto my-10 p-10 bg-white rounded shadow-lg">
        <h2 class="text-center text-2xl font-bold mb-5">Programme Requirement Checker</h2>

        <!-- Programme Selection -->
        <div class="w-full flex border-b border-black py-2">
            <div class="w-1/4 flex justify-center items-center">
                <p>Programme</p>
            </div>
            <div class="w-3/4">
                <asp:DropDownList ID="ddlCourse" runat="server" AutoPostBack="true" CssClass="form-control w-full p-2 border border-gray-300 rounded" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"></asp:DropDownList>
            </div>
        </div>

        <!-- Qualification Type -->
        <div id="requirementTypeSection" runat="server" visible="false" class="w-full flex border-b border-black py-2">
            <div class="w-1/4 flex justify-center items-center">
                <p>Qualification Type</p>
            </div>
            <div class="w-3/4">
                <asp:DropDownList ID="ddlRequirementType" runat="server" AutoPostBack="true" CssClass="form-control w-full p-2 border border-gray-300 rounded" OnSelectedIndexChanged="ddlRequirementType_SelectedIndexChanged"></asp:DropDownList>
            </div>
        </div>

        <!-- Subject Section -->
        <div id="subjectSection" runat="server" visible="false" class="w-full py-2">
            <label class="block text-center mb-2">Subjects and Grades</label>
            <asp:PlaceHolder ID="subjectPlaceHolder" runat="server"></asp:PlaceHolder>
            <div class="flex justify-between mt-4">
                <asp:Button ID="btnAddSubject" runat="server" Text="Add More Subject" CssClass="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" OnClick="btnAddSubject_Click" />
                <asp:Button ID="btnRemoveSubject" runat="server" Text="Remove Last Subject" CssClass="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded" OnClick="btnRemoveSubject_Click" />
            </div>
        </div>

        <!-- CGPA Section -->
        <div id="cgpaSection" runat="server" visible="false" class="w-full flex border-b border-black py-2">
            <div class="w-1/4 flex justify-center items-center">
                <p>Enter CGPA</p>
            </div>
            <div class="w-3/4">
                <asp:TextBox ID="txtCGPA" runat="server" CssClass="form-input w-full p-2 border border-gray-300 rounded"></asp:TextBox>
            </div>
        </div>

        <!-- MQF Level Section -->
        <div id="mqfSection" runat="server" visible="false" class="w-full flex border-b border-black py-2">
            <div class="w-1/4 flex justify-center items-center">
                <p>Select MQF Level</p>
            </div>
            <div class="w-3/4">
                <asp:DropDownList ID="ddlMQFLevel" runat="server" CssClass="form-control w-full p-2 border border-gray-300 rounded">
                    <asp:ListItem Text="Select Level" Value="" />
                    <asp:ListItem Text="Level 1" Value="1" />
                    <asp:ListItem Text="Level 2" Value="2" />
                    <asp:ListItem Text="Level 3" Value="3" />
                    <asp:ListItem Text="Level 4" Value="4" />
                    <asp:ListItem Text="Level 5" Value="5" />
                    <asp:ListItem Text="Level 6" Value="6" />
                    <asp:ListItem Text="Level 7" Value="7" />
                    <asp:ListItem Text="Level 8" Value="8" />
                    <asp:ListItem Text="Level 9" Value="9" />
                    <asp:ListItem Text="Level 10" Value="10" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Check Button -->
        <div class="w-full mt-4 text-center">
            <asp:Button ID="btnCheck" runat="server" Text="Check Requirements" CssClass="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded" OnClick="btnCheck_Click" />
        </div>

        <!-- Result Message -->
        <div class="w-full mt-4 text-center">
            <asp:Label ID="lblResult" runat="server" CssClass="text-lg font-bold" ForeColor="Red"></asp:Label>
        </div>
    </div>
</asp:Content>

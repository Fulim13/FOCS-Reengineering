<%@ Page Language="C#" MasterPageFile="~/Client/MasterPage/MasterPage.Master" AutoEventWireup="true" CodeBehind="Programme.aspx.cs" Inherits="SEMASGN.Client.Programme.Programme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Make the entire programme block clickable */
        .programme-item {
            cursor: pointer;
            transition: transform 0.2s ease-in-out;
        }

            .programme-item:hover {
                transform: scale(1.02);
            }
    </style>
    <script>
        // JavaScript to handle redirection
        function goToDetails(programmeId) {
            window.location.href = '/Client/ProgrammeDetails/ProgrammeDetails.aspx?id=' + programmeId;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="p-4 container mx-auto">
        <h1 class="text-gray-800 mb-8 text-center text-4xl font-bold">Programmes We Offered</h1>

        <!-- Foundation Programmes -->
        <h2 class="text-gray-700 mb-4 text-2xl font-semibold">Foundation Programmes</h2>
        <asp:Repeater ID="FoundationRepeater" runat="server">
            <ItemTemplate>
                <div class="bg-white p-6 mb-6 programme-item rounded-lg shadow-md"
                    onclick="goToDetails('<%# Eval("id") %>')">
                    <h3 class="text-gray-800 mb-2 text-xl font-bold"><%# Eval("name") %></h3>
                    <p class="text-gray-600 mb-4"><%# Eval("description") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Diploma Programmes -->
        <h2 class="text-gray-700 mb-4 text-2xl font-semibold">Diploma Programmes</h2>
        <asp:Repeater ID="DiplomaRepeater" runat="server">
            <ItemTemplate>
                <div class="bg-white p-6 mb-6 programme-item rounded-lg shadow-md"
                    onclick="goToDetails('<%# Eval("id") %>')">
                    <h3 class="text-gray-800 mb-2 text-xl font-bold"><%# Eval("name") %></h3>
                    <p class="text-gray-600 mb-4"><%# Eval("description") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Bachelor's Degree Programmes -->
        <h2 class="text-gray-700 mb-4 text-2xl font-semibold">Bachelor's Degree Programmes</h2>
        <asp:Repeater ID="BachelorRepeater" runat="server">
            <ItemTemplate>
                <div class="bg-white p-6 mb-6 programme-item rounded-lg shadow-md"
                    onclick="goToDetails('<%# Eval("id") %>')">
                    <h3 class="text-gray-800 mb-2 text-xl font-bold"><%# Eval("name") %></h3>
                    <p class="text-gray-600 mb-4"><%# Eval("description") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <h2 class="text-gray-700 mb-4 text-2xl font-semibold">Postgraduate Programmes</h2>
        <asp:Repeater ID="PostgraduateRepeater" runat="server">
            <ItemTemplate>
                <div class="bg-white p-6 mb-6 programme-item rounded-lg shadow-md"
                    onclick="goToDetails('<%# Eval("id") %>')">
                    <h3 class="text-gray-800 mb-2 text-xl font-bold"><%# Eval("name") %></h3>
                    <p class="text-gray-600 mb-4"><%# Eval("description") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

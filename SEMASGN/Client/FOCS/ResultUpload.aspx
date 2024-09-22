<%@ Page Title="" Language="C#" MasterPageFile="~/Client/MasterPage/MasterPage.Master" AutoEventWireup="true" CodeBehind="ResultUpload.aspx.cs" Inherits="SEMASGN.Client.FOCS.ResultUpload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        #responseMessage {
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        #responseMessage div {
            display: inline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bg-gray-100 p-8">
        <div class="max-w-2xl mx-auto bg-white p-6 rounded-lg shadow-md">
            <h2 class="text-2xl font-bold mb-4">Upload Your SPM Result Image (Beta)</h2>
            <div class="mb-4">Currently, this tool only supports SPM results for the Foundation in Computing, Diploma in Computer Science, and Diploma in Information Technology programs. </div>
            <div class="mb-4">Please be aware that the accuracy of the results may vary based on the quality of the uploaded image.</div>

            <div class="mb-4">Ensure that the image is clear and legible for the best results.</div>
            <div id="uploadForm" class="space-y-4">
                <div>
                    <label for="<%= ddlProgram.ClientID %>" class="block text-sm font-medium text-gray-700 mb-1">Select Program</label>
                    <asp:DropDownList ID="ddlProgram" runat="server" CssClass="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                        <asp:ListItem Text="-- Select a Program --" Value="" />
                        <asp:ListItem Text="Foundation in Computing" Value="Foundation in Computing" />
                        <asp:ListItem Text="Diploma in Computer Science" Value="Diploma in Computer Science" />
                        <asp:ListItem Text="Diploma in Information Technology" Value="Diploma in Information Technology" />
                    </asp:DropDownList>
                </div>
                <div>
                    <label for="<%= fileInput.ClientID %>" class="block text-sm font-medium text-gray-700 mb-1">Choose Image</label>
                    <asp:FileUpload ID="fileInput" runat="server" CssClass="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500" />
                </div>
                <asp:Button ID="submitButton" runat="server" Text="Upload" OnClientClick="uploadFile(); return false;" CssClass="w-full bg-indigo-600 text-white py-2 px-4 rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" />
            </div>
            <p id="loadingMessage" class="mt-4 text-gray-600 hidden">Response is generating, please wait...</p>
            <div id="responseMessage" class="mt-4 text-left bg-gray-100 p-4 rounded-md"></div>
        </div>
    </div>

    <script>
        function uploadFile() {
            const fileInput = document.getElementById('<%= fileInput.ClientID %>');
            const programSelect = document.getElementById('<%= ddlProgram.ClientID %>');
            const submitButton = document.getElementById('<%= submitButton.ClientID %>');
            const loadingMessage = document.getElementById('loadingMessage');
            const responseMessage = document.getElementById('responseMessage');

            if (!fileInput.files[0] || !programSelect.value) {
                responseMessage.textContent = "Please select a file and a program first.";
                return;
            }

            const formData = new FormData();
            formData.append("resultImage", fileInput.files[0]);
            formData.append("program", programSelect.value);

            submitButton.disabled = true;
            submitButton.textContent = "Generating Response...";
            loadingMessage.classList.remove('hidden');
            responseMessage.innerHTML = "";

            fetch("http://fulim.social:8000/upload-result/", {
                method: "POST",
                body: formData,
            })
                .then(response => response.json())
                .then(data => {
                    if (data.data) {
                        // Convert color attribute to inline style
                        const modifiedData = data.data.replace(/color='([^']+)'/g, "style='color:$1'");
                        responseMessage.innerHTML = modifiedData + "\n\n<br><strong>Note:</strong> The generated results may not be accurate. If you are unsure about your results, please contact FOCS for more information at 03-4145 0123 ext 3233, 011-1075 8554, or via email at focs@tarc.edu.my. You can also visit us on the 2nd Floor, Bangunan Tan Sri Khaw Kai Boh (Block A).";
                    } else {
                        responseMessage.innerHTML = modifiedData;                        
                    }
                })
                .catch(error => {
                    responseMessage.textContent = "Error while uploading: " + error.message;
                })
                .finally(() => {
                    submitButton.disabled = false;
                    submitButton.textContent = "Upload";
                    loadingMessage.classList.add('hidden');
                });
        }
    </script>
</asp:Content>
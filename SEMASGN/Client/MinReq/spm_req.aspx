<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="spm_req.aspx.cs" Inherits="SEMASGN.Client.MinReq.spm_req" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Programme Requirement Checker</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        form {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        div {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            margin-right: 10px;
        }

        input[type="text"], select {
            padding: 8px;
            width: 100%;
            margin-top: 5px;
            margin-bottom: 5px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .grade-input {
            width: 70px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .remove-btn {
            padding: 5px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 5px;
        }

        .remove-btn:hover {
            background-color: #d32f2f;
        }

        .result-message {
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Programme Requirement Checker</h2>

        <div>
            <label for="ddlCourse">Select Course:</label>
            <asp:DropDownList ID="ddlCourse" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div id="subjectSection" runat="server" visible="false">
            <label>Subjects and Grades:</label>

            <asp:PlaceHolder ID="subjectPlaceHolder" runat="server"></asp:PlaceHolder>

            <asp:Button ID="btnAddSubject" runat="server" Text="Add More Subject" CssClass="btn" OnClick="btnAddSubject_Click" />
            <asp:Button ID="btnRemoveSubject" runat="server" Text="Remove Last Subject" CssClass="remove-btn" OnClick="btnRemoveSubject_Click" />
        </div>

        <asp:Button ID="btnCheck" runat="server" Text="Check Requirements" CssClass="btn" OnClick="btnCheck_Click" />

        <asp:Label ID="lblResult" runat="server" CssClass="result-message" Text="" ForeColor="Red" />
    </form>
</body>
</html>

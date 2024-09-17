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

        input[type="text"]:invalid {
            border: 1px solid red;
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
            <div>
                <label for="txtSubject1">Subject 1:</label>
                <asp:TextBox ID="txtSubject1" runat="server" placeholder="Subject 1" required="true" />
                <asp:TextBox ID="txtGrade1" runat="server" CssClass="grade-input" placeholder="Grade (A-F or CGPA)" required="true" />
            </div>
            <div>
                <label for="txtSubject2">Subject 2:</label>
                <asp:TextBox ID="txtSubject2" runat="server" placeholder="Subject 2" required="true" />
                <asp:TextBox ID="txtGrade2" runat="server" CssClass="grade-input" placeholder="Grade (A-F or CGPA)" required="true" />
            </div>
            <div>
                <label for="txtSubject3">Subject 3:</label>
                <asp:TextBox ID="txtSubject3" runat="server" placeholder="Subject 3" />
                <asp:TextBox ID="txtGrade3" runat="server" CssClass="grade-input" placeholder="Grade (A-F or CGPA)" />
            </div>
        </div>

        <asp:Button ID="btnCheck" runat="server" Text="Check Requirements" CssClass="btn" OnClick="btnCheck_Click" />
        <asp:Label ID="lblResult" runat="server" CssClass="result-message" Text="" ForeColor="Red" />
    </form>
</body>
</html>
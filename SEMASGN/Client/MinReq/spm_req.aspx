<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="spm_req.aspx.cs" Inherits="SEMASGN.Client.MinReq.spm_req" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Programme Requirement Checker</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,500&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }

        form {
            max-width: 700px;
            margin: 40px auto;
            padding: 30px 40px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        input[type="text"], select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccd0d4;
            border-radius: 4px;
            font-size: 16px;
            color: #333;
            background-color: #fff;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, select:focus {
            border-color: #007bff;
            outline: none;
        }

        .grade-input {
            width: 100%;
        }

        .btn {
            width: 100%;
            padding: 14px 20px;
            background-color: #007bff;
            color: #ffffff;
            font-size: 16px;
            font-weight: 500;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0069d9;
        }

        .remove-btn {
            width: 100%;
            padding: 14px 20px;
            background-color: #dc3545;
            color: #ffffff;
            font-size: 16px;
            font-weight: 500;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s;
        }

        .remove-btn:hover {
            background-color: #c82333;
        }

        .result-message {
            text-align: center;
            font-weight: 500;
            margin-top: 30px;
            font-size: 18px;
        }

        .form-section {
            margin-bottom: 30px;
        }

        @media (max-width: 600px) {
            form {
                padding: 20px;
            }

            .btn, .remove-btn {
                padding: 12px 16px;
                font-size: 14px;
            }

            input[type="text"], select {
                font-size: 14px;
                padding: 10px 12px;
            }

            .result-message {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Programme Requirement Checker</h2>

        <div class="form-group">
            <label for="ddlCourse">Select Programme:</label>
            <asp:DropDownList ID="ddlCourse" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div id="requirementTypeSection" runat="server" visible="false" class="form-group">
            <label for="ddlRequirementType">Select Qualification Type:</label>
            <asp:DropDownList ID="ddlRequirementType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRequirementType_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div id="subjectSection" runat="server" visible="false" class="form-section">
            <label>Subjects and Grades:</label>
            <asp:PlaceHolder ID="subjectPlaceHolder" runat="server"></asp:PlaceHolder>
            <asp:Button ID="btnAddSubject" runat="server" Text="Add More Subject" CssClass="btn" OnClick="btnAddSubject_Click" />
            <asp:Button ID="btnRemoveSubject" runat="server" Text="Remove Last Subject" CssClass="remove-btn" OnClick="btnRemoveSubject_Click" />
        </div>

        <div id="cgpaSection" runat="server" visible="false" class="form-group">
            <label for="txtCGPA">Enter CGPA:</label>
            <asp:TextBox ID="txtCGPA" runat="server" CssClass="grade-input"></asp:TextBox>
        </div>

        <div id="mqfSection" runat="server" visible="false" class="form-group">
            <label for="ddlMQFLevel">Select MQF Level:</label>
            <asp:DropDownList ID="ddlMQFLevel" runat="server">
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

        <asp:Button ID="btnCheck" runat="server" Text="Check Requirements" CssClass="btn" OnClick="btnCheck_Click" />

        <asp:Label ID="lblResult" runat="server" CssClass="result-message" Text="" ForeColor="Red" />
    </form>
</body>
</html>

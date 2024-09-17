<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="spm_req.aspx.cs" Inherits="SEMASGN.Client.MinReq.spm_req" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Programme Requirement Checker</title>
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
                <asp:TextBox ID="txtSubject1" runat="server" />
                <asp:TextBox ID="txtGrade1" runat="server" placeholder="Grade (A-F or CGPA)" />
            </div>
            <div>
                <label for="txtSubject2">Subject 2:</label>
                <asp:TextBox ID="txtSubject2" runat="server" />
                <asp:TextBox ID="txtGrade2" runat="server" placeholder="Grade (A-F or CGPA)" />
            </div>
        </div>

        <asp:Button ID="btnCheck" runat="server" Text="Check Requirements" OnClick="btnCheck_Click" />
        <asp:Label ID="lblResult" runat="server" Text="" ForeColor="Red" />
    </form>
</body>
</html>

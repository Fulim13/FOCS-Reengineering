<%@ Page Title="" Language="C#" MasterPageFile="~/Client/MasterPage/MasterPage.Master" AutoEventWireup="true" CodeBehind="Comparison.aspx.cs" Inherits="SEMASGN.Client.Comparison.Comparison" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="w-[80%] min-h-80 border border-black m-auto my-10 text-justify">
        <!-- Programme -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center  p-2">
                <p>Programme</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:DropDownList ID="ddlProgramme1" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="ddlProgramme1_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:DropDownList ID="ddlProgramme2" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="ddlProgramme2_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
        </div>
        <!-- Row 1: Programme ID -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2"">
                <p>Programme ID</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%]  border-l border-black break-words p-2"">
                    <asp:Label ID="lblProgramme1ID" runat="server"></asp:Label>
                </div>
                <div class="w-[50%]  border-l border-black break-words p-2"">
                    <asp:Label ID="lblProgramme2ID" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 2: Description -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full  flex justify-center p-2">
                <p>Description</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1Description" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2Description" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 3: Local Student Fees -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>Local Student Fees</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1LocalFees" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2LocalFees" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 4: International Student Fees -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>International Student Fees</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1InternationalFees" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2InternationalFees" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 5: Programme Outline -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>Programme Outline</p>
            </div>
            <div class="w-[80%] min-h-full  flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1MainCourse" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2MainCourse" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 6: Minimum Requirements - Local -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>Minimum Requirements (Local)</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1LocalMinReq" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-word p-2">
                    <asp:Label ID="lblProgramme2LocalMinReq" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 7: Minimum Requirements - International -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full  flex justify-center p-2">
                <p>Minimum Requirements (International)</p>
            </div>
            <div class="w-[80%] min-h-full  flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1InternationalMinReq" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2InternationalMinReq" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 8: Career Prospects -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>Career Prospects</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1CareerProspects" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2CareerProspects" runat="server"></asp:Label>
                </div>
            </div>
        </div>


        <!-- Row 10: Full-Time Duration -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>Full-Time Duration</p>
            </div>
            <div class="w-[80%] min-h-full  flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1FTDuration" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2FTDuration" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        
        <!-- Row 9: Part-Time Duration -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full  flex justify-center p-2">
                <p>Part-Time Duration</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1PTDuration" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2PTDuration" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <!-- Row 11: Type -->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>Type</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1Type" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2Type" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 12: Campus-->
        <div class="w-[100%] min-h-10 border-b border-black flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>Campus</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1Campus" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2Campus" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Row 13: Intake-->
        <div class="w-[100%] min-h-10 flex">
            <div class="w-[20%] min-h-full flex justify-center p-2">
                <p>Intake</p>
            </div>
            <div class="w-[80%] min-h-full flex">
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme1Intake" runat="server"></asp:Label>
                </div>
                <div class="w-[50%] border-l border-black break-words p-2">
                    <asp:Label ID="lblProgramme2Intake" runat="server"></asp:Label>
                </div>
            </div>
        </div>

    </div>

</asp:Content>

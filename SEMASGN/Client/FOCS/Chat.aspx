<%@ Page Title="" Language="C#" MasterPageFile="~/Client/MasterPage/MasterPage.Master" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="SEMASGN.Client.Chat.Chat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <head>
  <title>Chat with Curator</title>
  <meta
    name="viewport"
    content="width=device-width, user-scalable=no, initial-scale=1, minimal-ui, maximum-scale=1, minimum-scale=1, viewport-fit=cover"
  />
  <meta charset="utf-8" />
  <!-- <link
    rel="shortcut icon"
    type="image/png"
    href="favicon.png"
    sizes="16x16 32x32 48x48 64x64 96x96 144x144"
  /> -->
  <!-- <link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png" /> -->
</head>
<link rel="stylesheet" type="text/css" href="./styles/styles.css" />
<body >
  <div id="app" class="h-screen">
    <div class="heading">
      <div class="heading-inner">
        <div class="photo-container"><div class="photo">JM</div></div>
        <div class="info">
          <div class="name">FOCS</div>
          <div class="title">Jamie</div>
          <div id="agentAvailability"></div>
        </div>
      </div>
    </div>
    <div class="conversation">
      <div id="conversation" class="conversation-inner">
        <div id="messages-dedicated-agent" class="messages"></div>
      </div>
      <div class="footer">
        <button type="button" class="scroll-to-bottom">
          <img src="./icons/arrow-down.svg" />
        </button>
        <div class="fade"></div>
        <div class="footer-inner">
          <div class="new-message">
            <textarea
              rows="1"
              id="autoGrowingTextarea"
              placeholder="Write a message"
            ></textarea>
          </div>
          <div class="send-message">
            <button type="submit" id="submitMessage" disabled>
              <img src="./icons/arrow-up.svg" />
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script defer src="./js/scripts.js"></script>
</body>
</asp:Content>

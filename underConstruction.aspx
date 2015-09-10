<%@ Page Language="C#" AutoEventWireup="true" Inherits="underConstruction" Codebehind="underConstruction.aspx.cs" %>

<%@ Register src="menu.ascx" tagname="menu" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page Under Construction</title>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <uc1:menu ID="menu1" runat="server" />
    
    </div>
    <asp:Panel ID="Panel1" runat="server" Height="100px" HorizontalAlign="Center">
    <p>
        <asp:Label ID="Label1" runat="server" Font-Bold="True" 
    Font-Size="XX-Large" ForeColor="Maroon" Text="Page Is Under Construction!"></asp:Label>
    </p>
    <div>
    Sorry. This page is under construction. Please check back later.
    <p>Started from 30 Jun 2011 10:00 a.m.</p>
    </div>
    </asp:Panel>
    </form>
</body>
</html>

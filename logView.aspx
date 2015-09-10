<%@ Page Language="C#" AutoEventWireup="true" Inherits="logView" Codebehind="logView.aspx.cs" %>

<%@ Register src="menu.ascx" tagname="menu" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Hub All In One Summary Reports Log Viwer</title>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />
    <script src="http://bi.multek.com/ws/utility.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/calendar.js" type="text/javascript"></script>
    <script type="text/javascript">
    function loading(){
        if(window.location.hash !=""){
            var u = window.location.hash.replace("#","");
            if(u!="")
                document.getElementById("uidTextBox").value = u;
            window.location.hash = "";
        }
        __doPostBack("SearchLog","");
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
        <uc1:menu ID="menu1" runat="server" />
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        
        <table>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Start Date:"></asp:Label>
                <asp:TextBox ID="startDateTextBox" runat="server" onfocus='calendar(this)'></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="Label3" runat="server" Text="End Date:"></asp:Label>
                <asp:TextBox ID="endDateTextBox" runat="server" onfocus='calendar(this)'></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="SearchLog" runat="server" Text="Search" 
                    onclick="SearchLog_Click" />
            </td>
        </tr>
        </table>
        
              <asp:Label ID="message" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
       
        <table>
            <tr valign="top">
                <td><asp:TreeView ID="TreeView1" runat="server" onselectednodechanged="TreeView1_SelectedNodeChanged"
                SelectedNodeStyle-BackColor="#E0FFF7" SelectedNodeStyle-Font-Bold="true"></asp:TreeView></td>
                <td>   
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" PageSize="50" 
            onpageindexchanging="GridView1_PageIndexChanging" 
            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
            GridLines="None" Width="100%">
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:BoundField DataField="uid" HeaderText="User" />
                <asp:BoundField DataField="actionTime" HeaderText="Date" />
                <asp:BoundField DataField="action" HeaderText="Action" />
                <asp:BoundField DataField="description" HeaderText="Description" />
                <asp:BoundField DataField="url" HeaderText="URL" />
            </Columns>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                No record found.
            </EmptyDataTemplate>
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>  
        
        </td></tr></table>
        </ContentTemplate>
        </asp:UpdatePanel>  

    </div>
    </form>
</body>
</html>

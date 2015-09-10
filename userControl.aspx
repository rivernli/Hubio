<%@ Page Language="C#" AutoEventWireup="true" Inherits="userControl" Codebehind="userControl.aspx.cs" %>

<%@ Register src="menu.ascx" tagname="menu" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Hub All In One Summary Reports Users Control</title>

    <script src="utility.js" type="text/javascript"></script>
    <script type="text/javascript">
    function display(string,e){
        pg.html.showDivContent("alt",string,e);
        return;
    }
    function hidden(){
        pg.html.hideDivContent("alt");
    }
    </script>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"> </asp:ScriptManager>   

            
            
        <uc1:menu ID="menu1" runat="server" />

            
            
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="searchPanel" runat="server">
                <asp:Label ID="Label2" runat="server" Text="Domain"></asp:Label>
                <asp:DropDownList ID="domainList" runat="server">
                    <asp:ListItem Text="Asia" Value="asia" />
                    <asp:ListItem Text="Europe" Value="europe" />
                    <asp:ListItem Text="Americas" Value="americas" />
                </asp:DropDownList>
             <asp:Label ID="Label1" runat="server" Text="User ID:"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
             <asp:Button ID="Button1"
                runat="server" Text="Search" onclick="Button1_Click" />
                <br />
                <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
            </asp:Panel>
             <asp:Panel ID="Panel1" runat="server" Visible="False">
             
<table  class="standardTable" border="1" width="740" bordercolor="#cccccc">
<tr>
    <td width="120" bgcolor="#C4E0FF">User Id:</td><td><asp:Label ID="userLabel" runat="server" Text=""></asp:Label>
    &nbsp;(<asp:Label ID="domainLabel" runat="server" Text=""></asp:Label>)
    </td> 
    <td width="120" bgcolor="#C4E0FF">Full Name:</td><td><asp:Label ID="nameLabel" runat="server" Text=""></asp:Label></td>
</tr>
<tr>
    <td width="120" bgcolor="#C4E0FF">Department:</td><td><asp:Label ID="departmentLabel" runat="server" Text=""></asp:Label></td>
    <td width="120" bgcolor="#C4E0FF">Job title:</td><td><asp:Label ID="titleLabel" runat="server" Text=""></asp:Label></td>
</tr>
<tr>
    <td width="120" bgcolor="#C4E0FF">E-Mail:</td><td><asp:Label ID="emailLabel" runat="server" Text=""></asp:Label></td>
    <td width="120" bgcolor="#C4E0FF">Mobile:</td><td><asp:Label ID="mobileLabel" runat="server" Text=""></asp:Label></td>
</tr>
<tr>
    <td width="120" bgcolor="#C4E0FF">Tel:</td><td><asp:Label ID="telLabel" runat="server" Text=""></asp:Label></td>
    <td width="120" bgcolor="#C4E0FF">Fax:</td><td><asp:Label ID="faxLabel" runat="server" Text=""></asp:Label></td>
</tr>
<tr valign="top">
    <td width="120" bgcolor="#C4E0FF">Control:</td><td colspan="3">
        <div>
        <asp:CheckBox ID="isAdmin" runat="server" Text="Admin" />
&nbsp; &nbsp;
        <asp:CheckBox ID="isActive" runat="server" Text="Active" Checked="true" />
        </div>
        </td></tr>
        <tr><td colspan="4" align="center">
        <asp:Button ID="addUserBtn" runat="server" Text="User Add" 
                onclick="addUserBtn_Click" OnClientClick="return confirm('add user?');" />
            <asp:Button ID="cancelAddUserBtn" runat="server" Text="Cancel" 
                onclick="cancelAddUserBtn_Click" />
    </td>
</tr>    

</table>
             </asp:Panel>
       <asp:Panel ID="list" runat="server">
       

       
           <asp:ListView ID="ListView1" runat="server" 
               onitemcanceling="ListView1_ItemCanceling" onitemcommand="ListView1_ItemCommand" 
               onitemdatabound="ListView1_ItemDataBound" onitemediting="ListView1_ItemEditing" 
               onitemupdating="ListView1_ItemUpdating">
               <LayoutTemplate>
                   <div style="background:url(images/background.gif);">
                       <table border="1" bordercolor="#cccccc" cellpadding="1" cellspacing="0" 
                           class="standardTable" width="98%" >
                           <tr bgcolor="0CAAFF">
                               <td>Name</td>
                               <td>Department/Title</td>
                               <td>tel</td>
                               <td>email</td>
                               <td>Status</td>
                               <td>Admin</td>
                               <td>
                               </td>
                           </tr>
                           <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                       </table>
                   </div>
               </LayoutTemplate>
               <ItemTemplate>
                   <tr bgcolor='<%# (bool)Eval("isActive")==true?"#ffffff":"#dddddd" %>'>
                       <td><asp:Label ID="uid" runat="server" Text='<%# Eval("uid") %>' Visible="false"></asp:Label>
                           <asp:Label ID="isAd" runat="server" Text='<%# (bool)Eval("isAdmin") == true ? "Y" : "N"%>' Visible="false" />
                           <a href='logView.aspx#<%# Eval("uid") %>'><%# Eval("username") %></a></td>
                       <td><%# Eval("department") %> <%# Eval("jobTitle") %></td>
                       <td><%# Eval("tel") %></td>
                       <td><%# Eval("emailAddress") %></td>
                       <td><%# (bool)Eval("isActive")==true?"Yes":"No" %></td>
                       <td><%# (bool)Eval("isAdmin")==true?"Yes":"No" %></td>
                       <td>
                           <asp:ImageButton ID="editBtn" runat="server" CommandName="Edit" 
                               ImageUrl="images/edit.png" AlternateText="Modify User" 
                                />
                       </td>
                   </tr>
               </ItemTemplate>
               <EditItemTemplate>
                   <tr>
                       <td>
                           <asp:Label ID="uid" runat="server" Text='<%# Eval("uid") %>' Visible="false" />
                           <asp:Label ID="isAd" runat="server" Text='<%# (bool)Eval("isAdmin") == true ? "Y" : "N"%>' Visible="false" />
                       <%# Eval("username") %></td>
                       <td><%# Eval("department") %> <%# Eval("jobTitle") %></td>
                       <td><%# Eval("tel") %></td>
                       <td><%# Eval("emailaddress") %></td>
                       <td><asp:CheckBox ID="isActive" runat="server" Checked='<%# Eval("isActive") %>' Text="Active" /></td>
                       <td><asp:CheckBox ID="isAdmin" runat="server" Checked='<%# Eval("isAdmin") %>' Text="Admin" /></td>
                       <td>
                        <asp:Label ID="dom" runat="server" Text='<%# Eval("domain") %>' Visible="false" />
                           <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Cancel" 
                               ImageUrl="images/cancel.png" 
                             onmouseover="return display('Cancel modify user');" 
                               onmouseout="return hidden()"
                               OnClientClick="return hidden();"                               
                               />
                           <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Update" 
                               ImageUrl="images/submit.png" 
                             onmouseover="return display('Save changed');" 
                               onmouseout="return hidden()"
                               OnClientClick="return hidden();"                               
                               
                               />
                       </td>
                   </tr>
               </EditItemTemplate>
           </asp:ListView>
       

       
       </asp:Panel>
        </ContentTemplate>
        </asp:UpdatePanel>
    </div>
            
            
            
    </form>
</body>
</html>

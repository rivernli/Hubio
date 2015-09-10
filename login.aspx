<%@ Page Language="C#" AutoEventWireup="true" Inherits="login" Codebehind="login.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Hub Inventory Reports</title>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>

           <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; padding:0px;">
                 <tr>
                     <td >
                        <img alt="Multek" id="HeaderImage" src="images/Multek-ID-PMS.gif" 
                             style="height:47px;border-width:0px;" />
                    </td>
                    <td align="center" width="600px">
                        <span id="Span1" class="MasterTile" style="display:inline-block;width:500px; white-space:nowrap;">
                        Hub All In One Summary Reports
                        </span></td>
                    <td  
                         style="background-image: url('images/flex_curve.gif'); width: 423px; text-align: center">
                        &nbsp;
                        <span style="color:#ffffff; cursor:pointer; text-decoration:underline;" onclick="pg.html.addFavorite('HUB all in one summary resports');">Add To Favorite</span>
                        <br />
                        <a href="mailto:CN-HKGMultekApplications%26Business@cn.flextronics.com?subject=comments%20for%20HUB%20all%20in%20one%20summary%20resports" style="color:#ffffff; cursor:pointer; text-decoration:underline;">Send your comments</a>
                    </td>
                 </tr>
                <tr bgcolor="#003366" height="20px">
                    <td colspan="3"  bgcolor="#003366" height="20px">&nbsp;</td>
                </tr>
                
            </table>

</div>

<div id="login_panel">

<table align="center" width="400">
<tr><td style="height:60px;">
    <asp:Label ID="Label5" runat="server" Text=""></asp:Label>
    </td></tr>
<tr><td align="center">
<div class="loginDiv">
        <div class="loginDivBtm">
        <br />
    <table style="width:300px;">
        <tr>
            <td align="right">
                <asp:Label ID="Label3" runat="server" Text="Domain:"></asp:Label>
            </td>
            <td>
                <asp:RadioButton runat="server" GroupName="domain" ID="americasCheck" Text="Americas" CssClass="domainSelect"/>
                <asp:RadioButton runat="server" GroupName="domain" ID="asiaCheck" Text="Asia" Checked="true" CssClass="domainSelect" />
                <asp:RadioButton runat="server" GroupName="domain" ID="europeCheck" Text="Europe" CssClass="domainSelect" />
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="Label1" runat="server" Text="User:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="username" runat="server" style="width:180px;"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="Label2" runat="server" Text="Password:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="password" runat="server" TextMode="Password"  style="width:180px;"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
       
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Login" onclick="Button1_Click" />
            </td>
        </tr>
        <tr><td colspan="2">
            <div style="color:White;font-size:10px; text-align:left; padding:4px 2px; border-top:1px #fff solid;">
            Please verify your domain,account and password <br /> 
            For example:<br />
            Domain:Asia; Account:HKGJOCHE ; Password:****** 
            </div>
        </td></tr>
    </table>
    </div>
</div>    

     <asp:Label ID="Label4" runat="server"></asp:Label>

</td></tr>
</table>
</div>
<div id="footer">
<span style="padding-top:3px;font-size:11px;">&copy; System Support: 
<a href="mailto:peter.xu@hk.multek.com">Peter Xu</a>, 
<a href="mailto:joe.cheng@hk.multek.com">Joe Cheng</a></span>
</div>
    </div>
    </form>
</body>
</html>

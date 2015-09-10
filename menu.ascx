<%@ Control Language="C#" AutoEventWireup="true" Inherits="menu" Codebehind="menu.ascx.cs" %>
<script language="javascript" type="text/javascript">
// <!CDATA[

function HeaderImage_onclick() {

}

// ]]>
</script>
<asp:Panel ID="hub_header" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; padding:0px;">
                 <tr>
                     <td >
                        <img alt="Multek" id="HeaderImage" src="images/Multek-ID-PMS.gif" style="height:47px;border-width:0px;" onclick="return HeaderImage_onclick()" />
                    </td>
                    <td align="center" width="600px">
                        <span id="Span1" class="MasterTile" style="display:inline-block;width:500px; white-space:nowrap">
                        HUB Management</span></td>
                    <td  
                         style="background-image: url('images/flex_curve.gif'); width: 423px; text-align: center">
                        &nbsp;
                        <span style="color:#ffffff; cursor:pointer; text-decoration:underline;" onclick="pg.html.addFavorite('HUB all in one summary resports');">Add To Favorite</span>
                        <br />
                        <a href="mailto:CN-HKGMultekApplications%26Business@cn.flextronics.com?subject=comments%20for%20HUB%20Management" style="color:#ffffff; cursor:pointer; text-decoration:underline;">Send your comments</a>
                    </td>
                 </tr>
                <tr bgcolor="#003366" height="20px">
                    <td colspan="3"  bgcolor="#003366" height="20px" align="center">
                        <asp:Label ID="Label1" runat="server" Text="" ForeColor="White"></asp:Label>
                    </td>
                </tr>
                <tr><td colspan="3">
            <ul id="channel">
				<li id='li_in' runat="server"><asp:HyperLink ID="HyperLink2" Text="Hub In" runat="server" NavigateUrl="indexIn.aspx"/></li>
				<li id='li_out' runat="server"><asp:HyperLink ID="HyperLink1" Text="Hub Out" runat="server" NavigateUrl="indexOut.aspx"/></li>
                <li id='li_site' runat="server"><asp:HyperLink ID="siteLink" Text="Inventory" runat="server" NavigateUrl="index.aspx"/></li>
                <li id='li_cem' runat="server"><asp:HyperLink ID="HyperLink4" Text="Inventory/CEM" runat="server" NavigateUrl="index_cem.aspx"/></li>
                <li id='li_aging' runat="server"><asp:HyperLink ID="HyperLink3" Text="Aging" runat="server" NavigateUrl="indexAging.aspx"/></li>
                <li id='li_oversit' runat="server"><asp:HyperLink ID="oversitelnk" Text="Stock Over Sit" runat="server" NavigateUrl="indexOversit.aspx" /></li>
                <li id='li_summary' runat="server"><asp:HyperLink ID="summarylnk" runat="server" Text="Summary" NavigateUrl="~/InventorySummary.aspx" /></li>
                <li runat="server" id="li_member_ctrl"><asp:HyperLink ID="memberControl" runat="server" Text="ACL" NavigateUrl="userControl.aspx" /></li>
				<li runat="server" id="li_log" visible="false"><asp:HyperLink ID="logviewer" runat="server" Text="Log" NavigateUrl="logView.aspx" /></li>
				<li><asp:HyperLink ID="logout" runat="server" Text="Logout" NavigateUrl="~/logout.aspx" /></li>

			</ul>


                <div style="border-top:1px solid #444; width:auto; height:5px; ">&nbsp;</div>
                </td></tr>
            </table>
</asp:Panel>

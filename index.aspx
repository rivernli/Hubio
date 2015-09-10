<%@ Page Language="C#" AutoEventWireup="true" Inherits="index" Codebehind="index.aspx.cs" %>
<%@ Register src="menu.ascx" tagname="menu" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hub Summary Reports</title>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />

    <script src="json2.js" type="text/javascript"></script>    
    <script src="http://bi.multek.com/ws/utility.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/calendar.js" type="text/javascript"></script>
    <script src="swfobject.js" type="text/javascript"></script>
    <script src="nReport.js" type="text/javascript"></script>
    <script type="text/javascript">
        function init(){
            data.y_legend.text = "Amount in USD";
            __doPostBack('Query', '');
        }
        function amount_type_change()
        {
            var obj = document.getElementById("no_type");
            data.y_legend.text = "Amount in USD";
            if(obj != undefined)
            {
                if(obj.selectedIndex == 1)
                    data.y_legend.text = "Number Of Quantity";
                else
                    data.y_legend.text = "Amount in USD";
            }
            var uon = document.getElementById("K_UON");
            if(uon != undefined && uon.checked)
                    data.y_legend.text += " (K per unit)";
        }
    </script>
    
    <script src="http://bi.multek.com/ws/TableFreeze.js" type="text/javascript"></script>
    <script type="text/javascript">
    function loadpage2(){
        loadpage();
        //tableFreeze("GridView1","contentDivSub",1,2);
    }
    </script>
</head>
<body onload="init()">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"  >
    <Services>
        <asp:ServiceReference Path="~/aging.asmx" />
    </Services>
    </asp:ScriptManager>
    <div>
    <uc1:menu ID="menu1" runat="server" />
    
    <div id="hubinventory">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="padding:4px;">
                <table class="standardTable" border="1" width="960" bordercolor="#cccccc">
                <tr>
                <td width="120" bgcolor="#C4E0FF">Report type:</td><td>
                    <asp:RadioButton ID="isOEM" runat="server" AutoPostBack="true" 
                        GroupName="type" 
                        Text="OEM" oncheckedchanged="isOEM_CheckedChanged" />
                    <asp:RadioButton ID="isPlant" runat="server" AutoPostBack="true" 
                        GroupName="type" 
                        Text="Plant" oncheckedchanged="isOEM_CheckedChanged"/>
                    <asp:RadioButton ID="isCEM" runat="server" AutoPostBack="true" 
                        GroupName="type" 
                        Text="CEM" oncheckedchanged="isOEM_CheckedChanged"/>

                    </td></tr>
                    <tr>
                        <td bgcolor="#C4E0FF" width="120">
                            Calender type:</td>
                        <td>
                            <asp:RadioButton ID="fiscal" runat="server" Text="Fiscal"  GroupName="timetype"
                                oncheckedchanged="fiscal_CheckedChanged"  AutoPostBack="true"/>
                            <asp:RadioButton ID="calender" runat="server" Text="Calender" 
                                GroupName="timetype" oncheckedchanged="fiscal_CheckedChanged" AutoPostBack="true" />
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#C4E0FF" width="120">
                            Timeline:</td>
                        <td>
                            <asp:Panel ID="fiscal_type_panel" runat="server" >
                            <asp:RadioButton ID="FY" runat="server" AutoPostBack="true" 
                                GroupName="Timeline" oncheckedchanged="Radio_CheckedChanged" 
                                Text="Fiscal Year" />
                            <asp:RadioButton ID="Q" runat="server" AutoPostBack="true" GroupName="Timeline" 
                                oncheckedchanged="Radio_CheckedChanged" Text="Quarter" />
                            <asp:RadioButton ID="P" runat="server" AutoPostBack="true" GroupName="Timeline" 
                                oncheckedchanged="Radio_CheckedChanged" Text="Period" />
                                </asp:Panel>
                                <asp:Panel ID="calender_type_panel" runat="server">
                            <asp:RadioButton ID="M" runat="server" AutoPostBack="true" GroupName="Timeline" 
                                oncheckedchanged="Radio_CheckedChanged" Text="Monthly" />
                            <asp:RadioButton ID="D" runat="server" AutoPostBack="true" GroupName="Timeline" 
                                oncheckedchanged="Radio_CheckedChanged" Text="Date" />
                            <asp:RadioButton ID="DP" runat="server" AutoPostBack="true" 
                                GroupName="Timeline" oncheckedchanged="Radio_CheckedChanged" 
                                Text="Period daily" /></asp:Panel>
                        </td>
                    </tr>
                <tr><td width="120" bgcolor="#C4E0FF">Time:</td><td>
                    <asp:DropDownList ID="startFY" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="startQP" runat="server"></asp:DropDownList>
                    <asp:TextBox id="startDate" runat="server" ></asp:TextBox>
                <asp:Label ID="toLabel" runat="server" Text="TO" Visible="true" />
                    <asp:DropDownList ID="endFY" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="endQP" runat="server"></asp:DropDownList>
                    <asp:TextBox ID="endDate" runat="server" ></asp:TextBox>
                </td></tr>
                <tr><td width="120" bgcolor="C4E0FF">Setting:</td><td>
                    Type<asp:DropDownList ID="no_type" runat="server" 
                        onselectedindexchanged="type_SelectedIndexChanged">
                        <asp:ListItem Text="Amount" Value="0" />
                        <asp:ListItem Text="Quantity" Value="1" />
                    </asp:DropDownList>
                    &nbsp;
                    Hub target<asp:TextBox runat="server" ID="hubTarget" Text="3800000" Width="70px" />
                    <span class="hide">
                    &nbsp; <asp:Label ID="amount_qty" runat="server" Text="Amount" />
                     <asp:DropDownList ID="AmountType" runat="server" 
                        AutoPostBack="true" onselectedindexchanged="AmountType_SelectedIndexChanged">
                        <asp:ListItem Text="Last date only" Value="0" Selected="True" />
                        <asp:ListItem Text="Accumulate" Value="1" />
                    </asp:DropDownList>
                    </span>
                    &nbsp;
                    K/Unit<asp:CheckBox ID="K_UON" runat="server"/>
                    </td></tr>
                <tr><td>&nbsp;</td><td>
                    <asp:Button ID="Query" runat="server" Text="Query" onclick="Query_Click" />
                    <asp:Button ID="Download" runat="server" Text="Download" 
                        onclick="Download_Click" Visible="False" />
            <asp:Label ID="Label1" runat="server" Text="" CssClass="hide"></asp:Label>
            <asp:Label ID="Label2" runat="server" Text="" CssClass="hide"></asp:Label>
                </td></tr>
                </table>
                <asp:Label ID="message" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                <div id="my_chart" style="border:1px solid #ccc;z-index:0; display:none;"></div>
                
            </div>
            <div id="contentDivSub" style= "overflow:auto; height:400; width:960">
            <asp:GridView ID="GridView1" runat="server" Width="960" BackColor="White" 
                     BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                     GridLines="Vertical">
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" HorizontalAlign="Right" />
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="#DCDCDC" />
            </asp:GridView>
            </div>         
        </ContentTemplate>
        <Triggers>
        <asp:PostBackTrigger ControlID="Download" />
        </Triggers>
        </asp:UpdatePanel>

    
    </div>
    </div>
    </form>
</body>

</html>

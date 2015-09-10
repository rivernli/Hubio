<%@ Page Language="C#" AutoEventWireup="true" Inherits="indexIn" Codebehind="indexIn.aspx.cs" %>
<%@ Register src="menu.ascx" tagname="menu" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hub In Reports</title>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />

    <script src="json2.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/utility.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/calendar.js" type="text/javascript"></script>
    <script src="swfobject.js" type="text/javascript"></script>
    <script src="nReport.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/TableFreeze.js" type="text/javascript"></script>
    <script type="text/javascript">
        function init(){
            __doPostBack('Query', '');
        }
        function loadpage2(){
            loadpage();
            tableFreeze("GridView1","contentDivSub",1,1);
        //demoMask();    
        }
        function demoMask(){
            var dyn = document.getElementById("demoMask");
	        if(!dyn){
		        dyn =document.createElement("div");
		        dyn.id="demoMask";
		        //dyn.style.filter="alpha(opacity=40)";
		        //dyn.style.backgroundColor="#ffffff";
		        dyn.style.position="absolute";
		        //dyn.style.padding="3px";
		        //dyn.style.border = "1px #689AFE solid";
		        var htmlbody = document.getElementsByTagName("body").item(0);
		        htmlbody.appendChild(dyn);
	        }
	        dyn.style.visibility = "visible";
	        dyn.style.backgroundImage = "url(http://bi.multek.com/ws/images/bi_demo.png)";
            dyn.style.top = (document.documentElement.scrollTop + 200) +"px";
            dyn.style.left = document.documentElement.scrollLeft+"px";
            var m = new getHW();
            dyn.style.width = (m.w>=0?m.w:0) +"px";
            dyn.style.height = "400px";//(m.h>=0?m.h:0) +"px";
            dyn.style.display = "block";
        }
        function getHW(){
            var intH = 0;
            var intW = 0;
            var intTop = 0;
            if(typeof window.innerWidth  == 'number' ) {
                   intH = window.innerHeight;
                   intW = window.innerWidth;
                   intTop = window.pageYOffset;
            } 
            else if(document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
                    intH = document.documentElement.clientHeight;
                    intW = document.documentElement.clientWidth;
                    intTop = document.documentElement.scrollTop;
            }
            else if(document.body && (document.body.clientWidth || document.body.clientHeight)) {
                    intH = document.body.clientHeight;
                    intW = document.body.clientWidth;
                    intTop = document.body.scrollTop;
            }
            this.h = parseInt(intH);
            this.w = parseInt(intW);
            this.t = parseInt(intTop);
        }
    </script>
    
</head>
<body onload="init()">
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"  >

    </asp:ScriptManager>
    <div>
    <uc1:menu ID="menu1" runat="server" />
    <div>
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
                    </td></tr>

                <tr>
                <td width="120" bgcolor="#C4E0FF">Calender type:</td><td>
                    <asp:RadioButton ID="fiscal" runat="server" AutoPostBack="true" 
                        GroupName="timetype" oncheckedchanged="fiscal_CheckedChanged" Text="Fiscal" />
                    <asp:RadioButton ID="calender_panel" runat="server" AutoPostBack="true" 
                        GroupName="timetype" oncheckedchanged="fiscal_CheckedChanged" Text="Calender" />
                </td></tr>
                    <tr>
                        <td bgcolor="#C4E0FF" width="120">
                            Timeline:</td>
                        <td>
                        <asp:Panel ID="fiscal_type_panel" runat="server">
                            <asp:RadioButton ID="FY" runat="server" AutoPostBack="true" 
                                GroupName="Timeline" oncheckedchanged="Radio_CheckedChanged" 
                                Text="Fiscal Year" />
                            <asp:RadioButton ID="Q" runat="server" AutoPostBack="true" GroupName="Timeline" 
                                oncheckedchanged="Radio_CheckedChanged" Text="Quarter" />
                            <asp:RadioButton ID="P" runat="server" AutoPostBack="true" GroupName="Timeline" 
                                oncheckedchanged="Radio_CheckedChanged" Text="Period" />
                        </asp:Panel>
                        <asp:Panel ID="calender_type_panel" runat="server" >
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
                <!-- </td></tr>
                <tr><td width="120" bgcolor="C4E0FF">Setting:</td><td>
                -->
                    <div style="display:none">
                        Hub target:<asp:TextBox runat="server" ID="hubTarget" Text="0" Width="70px" />
                    </div>
                    <span class="hide">
                            &nbsp;Amount:<asp:DropDownList ID="AmountType" runat="server" 
                                AutoPostBack="true" onselectedindexchanged="AmountType_SelectedIndexChanged">
                                <asp:ListItem Text="Last date only" Value="0"/>
                                <asp:ListItem Text="Accumulate" Value="1" Selected="True" />
                            </asp:DropDownList>
                    </span>
                    </td></tr>                <tr><td>&nbsp;</td><td>
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
            <asp:GridView ID="GridView1" runat="server" CellPadding="3" 
                GridLines="Vertical" Width="100%" BackColor="White" BorderColor="#999999" 
                    BorderStyle="None" BorderWidth="1px">
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" HorizontalAlign="Right" />
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="#DCDCDC" />
            </asp:GridView>
            </div>
                     
        <asp:Repeater runat="server" ID="Repeater1">
            <ItemTemplate>
            <th>
                <asp:Label ID="Time" Text='<%# Eval("T") %>' runat="server"></asp:Label>
                <asp:Repeater ID="childRepeater" runat="server" DataSource='<%# ((System.Data.DataRowView)Container.DataItem).Row.GetChildRows("report_relating") %>'>
                <ItemTemplate>
                    <tr>
                    <td><%# DataBinder.Eval(Container.DataItem, "[\"OEM\"]") %></td>
                    <td><%# DataBinder.Eval(Container.DataItem, "[\"tamt\"]") %></td></tr>
                </ItemTemplate>
                <HeaderTemplate><table></HeaderTemplate>
                <FooterTemplate></table></FooterTemplate>
            </asp:Repeater>
            </th>
            </ItemTemplate>
            <HeaderTemplate>
            <table><tr valign="top">
            </HeaderTemplate>
            <FooterTemplate>
            </tr></table>
            </FooterTemplate>
        </asp:Repeater>

            <asp:GridView ID="GridView2" runat="server">
            </asp:GridView>

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

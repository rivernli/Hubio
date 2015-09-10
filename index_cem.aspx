<%@ Page Language="C#" AutoEventWireup="true" Inherits="index_cem" Codebehind="index_cem.aspx.cs" %>
<%@ Register src="menu.ascx" tagname="menu" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hub Summary Reports</title>
    <style type="text/css">
    .EDITable { padding:0px; top:0px; left:0px; position:relative; border-color:#cccccc; border-collapse:collapse; border-spacing:1; border-style:solid;}
    .EDITable tr { white-space:nowrap;}
    .EDITable th { width:auto; white-space:nowrap; font-size:11px; padding:2px;}
    .EDITable td { width:auto; white-space:nowrap;}
    .EDITable td div{ width:auto; text-align:right; white-space:nowrap; font-size:11px; overflow:visible; padding:0px;}
    </style>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />
    <script src="json2.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/utility.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/calendar.js" type="text/javascript"></script>
    <script src="swfobject.js" type="text/javascript"></script>
    <script id="nReport.js" type="text/javascript">
    var data;
    var hexArray = new Array( "0", "1", "2", "3","4", "5", "6", "7","8", "9", "A", "B", "C", "D", "E", "F" );
    var CRS = new Array("#FF0000","#CC0099","#B2B300","#660099","#FFCC00","#330099","#0033CC",
    "#009999","#00CC00","#6BB200","#FF9900","#FF6600",
    "#E60066","#990099","#400099","#1919B3","#0066B3","#00B366","#33FF00",
    "#CCFF00","#FFE500","#FFB200","#FF8000","#FF3300","#FE8080","#FE80DF");
    
    function setColor(n){
        var x=0;
        var cols = new Array();

        if(n > CRS.length){
            for(var i=0; i <=15; i=i+3){
                if(x > n)
                    break;
                for(var j =0; j <=15; j=j+3){
                    for(var k =0 ; k <=15; k=k+3){
                        cols[x] = "#" + 
                            hexArray[i] + hexArray[i] +
                            hexArray[j] + hexArray[j] + 
                            hexArray[k] + hexArray[k];
                        x++;
                    }
                }
            }
        }else{
            for(var i=0; i <= n; i++){
                cols[i] = CRS[i];
            }
        }
        return cols;
    }

    function maxNmin(max,min){
        max = max +"";
        var l = max.length;
        var st = parseInt(max.substr(0,1));
        if(st >=4){
            st += 1;
        }else{
            st = parseInt(max.substr(0,2))+1;
            l = max.length -1;
        }
        
        max = st;
        for(var i=0; i < l-1; i++){
            max = max * 10;
        }
        step = max/st;
        data.y_axis.min = 0;
        data.y_axis.max = max;
        data.y_axis.offset = false;
        data.y_axis.steps = step;

    }
    function addCommas(nStr)
    {
	    nStr += '';
	    x = nStr.split('.');
	    x1 = x[0];
	    x2 = x.length > 1 ? '.' + x[1] : '';
	    var rgx = /(\d+)(\d{3})/;
	    while (rgx.test(x1)) {
		    x1 = x1.replace(rgx, '$1' + ',' + '$2');
	    }
	    return x1 + x2;
    }
    function mov(){
        var inv = document.getElementById("hubinventory");
        if(inv == null || inv == undefined)
            return;
        if(document.getElementById("D") && document.getElementById("DP")){
            if(document.getElementById("D").checked || document.getElementById("DP").checked){
                var x = document.getElementById("GridView1");
                if(x){
                 this.style.cursor = "pointer";
                }
           }
       }
    }

    //for hub inventory get parts detail.
    function getDetail(){
        var inv = document.getElementById("hubinventory");
        if(inv ==null || inv == undefined){
            return;
        }
        if(document.getElementById("D") == undefined)
            return;
        if(document.getElementById("D").checked || document.getElementById("DP").checked){
            var x = document.getElementById("GridView1");
            if(x){
                this.style.cursor = "pointer";
                var tb = x.firstChild;
                var oem = this.parentNode.parentNode.firstChild.val;
                var dat = tb.childNodes[0].childNodes[this.y].innerHTML.replace(" closing","");
                var isQty = false;
                if(document.getElementById("no_type") != undefined && document.getElementById("no_type").selectedIndex ==1)
                    isQty = true;
                var isOEM = 1;
                if(document.getElementById("isPlant").checked)
                    isOEM=2;
                if(document.getElementById("isCEM").checked)
                    isOEM=3;
                if(document.getElementById("isOEMCEM").checked)
                    isOEM=4;
                if(document.getElementById("isCEMOEM").checked)
                    isOEM=5;
                if(document.getElementById("isCEMLOC").checked)
                    isOEM=6;
                aging.getCEMDetail(oem,dat,isQty,isOEM,setValue);
                pg.html.showDivContent('tmp',oem + " &nbsp; "+ dat);
            }
       }
    }
    function setValue(Oj){
        doc = document.getElementById("tmp");
        doc.style.zIndex = 100;
        doc.style.filter="alpha(opacity=95)";
        var t =doc.innerHTML; doc.innerHTML = "";
        doc.style.width = "240px";
        var spanImg = pg.html.appendObject({create:"img",param:{src:"http://bi.multek.com/ws/images/stopC1.png",
            style:{cursor:"pointer",padding:"1px 5px",border:"0px",cssFloat:"right",styleFloat:"right"}}},doc);
        spanImg.onclick =function(){pg.html.hideDivContent('tmp')};
        var til = pg.html.appendObject({create:"span",param:{innerHTML:t,style:{cssFloat:"left",styleFloat:"left"}}},doc);
        pg.html.appendObject({create:"div",param:{innerHTML:Oj,style:{clear:"both"}}},doc);
        //alert(doc.clientWidth +"<"+ til.clientWidth);
        if(doc.clientWidth < til.clientWidth)
            doc.style.width = til.clientWidth + 20;
        
    }
    function loadpage(){
        closeCalendar();
        pg.html.hideDivContent('tmp');
        var x = document.getElementById("GridView1");
        if(x){
            var b1 = document.getElementById("Query");
            var b2 = document.getElementById("Download");
            b2.disabled = b1.disabled = true;
            var tb = x.firstChild;
            var rows = tb.childNodes.length-1; //no. of oem
            var cols = tb.firstChild.childNodes.length; //no. of period
            data.elements[0].colours = setColor(rows-1);
            data.elements[0].keys.length = 0;
            data.elements[0].values.length = 0;//cols-1;
            data.title.text = document.getElementById("Label1").innerHTML;
            var max=0;
            var min=9999
            
            //for amount data sorting.
            var valx = new Array();
            for(var a = 0; a < cols-1; a++){ 
                valx[a] = new Array();
                var total = 0;
                
                for(var b=0; b < rows-1; b++){
                    var node = tb.childNodes[b+1].childNodes[a+1];
                    var prc = parseInt(node.innerHTML);
                    valx[a][b] = prc;
                    node.innerHTML = "--";
                    if(prc !=0){
                        node.innerHTML = "";
                        var span = pg.html.appendObject({create:"span",param:{innerHTML:addCommas(prc),x:b+1,y:a+1,onmouseover:mov,onclick:getDetail}},node)
                    }
                    total += prc;
                }
                tb.childNodes[rows].childNodes[a+1].innerHTML = total;
                tb.childNodes[rows].childNodes[a+1].style.fontWeight = "bolder";
                
                if(total > max) max = total;
                if(total < min) min = total;
                var tcell = tb.childNodes[rows].childNodes[a+1];
                tcell.innerHTML = addCommas(tcell.innerHTML);
            }
            tb.childNodes[rows].childNodes[0].style.fontWeight = "bolder";
            data.elements[0].values = valx;
            //for keys items (OEM assort)
            for(var i = 0; i < rows-1; i++){
                var n = tb.childNodes[i+1];
                data.elements[0].keys[i]={"colour":data.elements[0].colours[i],"text":n.firstChild.innerText.trim(),"font-size":11};
            }
            for(i=0; i <=rows; i++)
                tb.childNodes[i].childNodes[0].style.textAlign ="left";
            //for average & title?
            var avg = (max -min)/2;
            var m5 = parseInt(document.getElementById("hubTarget").value);
            if(m5 < 0) 
                ms = 5000000;
            maxNmin(max,min);
            data.elements.length = 1;
            data.elements[1] = new LineElement("Target","#FF0000","");
            var showM5 = true;
            if(max < m5 || m5 ==0){
                data.elements[1].text = "";
                showM5 = false;
            }
            var lm = {'amt':0,'date':''};
            if(document.getElementById("Label2").innerHTML.trim() != ""){
                eval("lm = {"+ document.getElementById("Label2").innerHTML +"}");
                var dx = new Date(lm.date.substr(4,2)+"/"+lm.date.substr(6,2)+"/"+lm.date.substr(0,4));
                lm.date = dx.format("d MMM yy");
                data.elements[2] = new LineElement(lm.date,"#FF00FF","");
            }
            if(lm.amt > max)
                maxNmin(lm.amt,min);
            var title = new Array();
            for(var k=0; k < cols-1; k++){ 
                title[k] = tb.childNodes[0].childNodes[k+1].innerHTML;
                if(showM5) data.elements[1].values[k] = {"value":m5,"tip":"Target<br>"+addCommas(m5)};
                if(lm.amt > 0)data.elements[2].values[k] = {"value":lm.amt,"tip":lm.date+":#val#"};
            }
            data.x_axis.labels.labels = title;
            var params ={};
            params.wmode = "transparent";
            swfobject.embedSWF("open-flash-chart2.swf", "my_chart", "960", "450", "9.0.0","expressInstall.swf",{},params,{});
            oemcem(tb);
            scrollTable();
            b2.disabled = b1.disabled = false;
        }
    }
    
    function oemcem(table){
            var l = table.rows.length;
            var c = table.rows[0].cells.length;
            var oem_cem2="";
            for(var i=1; i < l-1; i++){
                var cell = table.rows[i].cells[0];
                cell.val = cell.innerText;
                var oem_cem = cell.innerText.split("|");
                if(oem_cem.length ==2){
                    cell.innerHTML = oem_cem[1];
                    if(oem_cem[0] != oem_cem2){
                        oem_cem2 = oem_cem[0];
                        var row = table.insertRow(i);
                        var cel = row.insertCell(0);
                        cel.style.backgroundColor = "#fcfcfc";
                        cel.style.fontWeight = "bold";
                        cel.innerText = oem_cem2;
                        cel.colSpan = c;
                        cel.setAttribute("colspan",c);
                        i++;
                        l++;
                    }
                }
            }
    }

function LineElement(name,color,tip){
    this.type = "line";
    this.text = name;
    this.values = [];
    this.width=2;
    this.colour = color;
    this.tip = tip;
    this["dot-style"] = {"type":"solid-dot","dot-size":2,"colour":color};
}

function ofc_ready(){
//do nothing..
}
function open_flash_chart_data(){return JSON.stringify(data);} //let data object to be open flash chart data object.
function findSWF(movieName) {
  if (navigator.appName.indexOf("Microsoft")!= -1) {return window[movieName];} 
  else {return document[movieName];}
}

var data = {"elements":[
{"type": "bar_stack","colours":[],"values":[],"keys":[],"key-on-click":"toggle-visibility","tip": "#key# [#x_label#]<br>#val# [total:#total#]" }
 ],
 "legend":{"position":"right"},
 "title":{"text":"","style":"{font-size: 20px; color: #F24062; text-align: center;}"},
 "x_axis":{"labels":{"labels":[],"rotate":35,"colour":"e43456"}},
 "y_axis":{"min":0,"max":1500,"steps":100},
 "y_legend":{"text":"USD","style":"{font-size: 12px; color:#736AFF;}"},
 "tooltip":{"mouse":2}
};
    </script>
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
    function scrollTable(){
        /*freeze table will be released on 31/8/2011*/
        tableFreeze("GridView1","contentDivSub",1,2);
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
                    <asp:RadioButton ID="isOEMCEM" runat="server" AutoPostBack="true" 
                        GroupName="type" 
                        Text="OEM+CEM" oncheckedchanged="isOEM_CheckedChanged"/>
                        
                    <!-- CEM Break down OEM wait for 31/8/2011 to release -->    
                    <asp:RadioButton ID="isCEMOEM" runat="server" AutoPostBack="true" 
                        GroupName="type" 
                        Text="CEM+OEM" oncheckedchanged="isOEM_CheckedChanged" 
                        />
                    
                    <asp:RadioButton ID="isCEMLOC" runat="server" AutoPostBack="true" 
                        GroupName="type"
                        Text="CEM+Location" oncheckedchanged="isOEM_CheckedChanged" 
                        />
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
                
             <!-- scrolling -->
            <div id="contentDivSub" style= "overflow:auto; height:400; width:960">
            <asp:GridView ID="GridView1" runat="server" Width="960" BackColor="White"  CssClass="EDITable"
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
            <!-- end scrolling -->
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

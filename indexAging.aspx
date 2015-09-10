<%@ Page Language="C#" AutoEventWireup="true" Inherits="indexAging" Codebehind="indexAging.aspx.cs" %>
<%@ Register src="menu.ascx" tagname="menu" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hub Aging Reports</title>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />
    <script src="json2.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/utility.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/calendar.js" type="text/javascript"></script>
    <script src="swfobject.js" type="text/javascript"></script>
    <script type="text/javascript">
    var ds;
    function setCal(ad)
    {
        calendar(ad);
        if(ad.value.trim() != "")
        {
            var d = new Date(ad.value);
            showcalendar(d.getFullYear(),d.getMonth(),d.getDate(),ad);
        }
    }
    function getaging()
    {
        pg.html.hideDivContent("detailAgingPartsAmount");
        var doc = document.getElementById("agingContent");
        if(doc.firstChild)
            doc.removeChild(doc.firstChild);
            
        var waitDiv = pg.html.appendObject({"create":"div","param":{"style":{"padding":"20px","textAlign":"center"}}},doc);
        pg.html.appendObject({"create":"img","param":{"src":"images/ajax-loader_6.gif","border":"0"}},waitDiv);

        var mon = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
        var ad = document.getElementById("agingDate");
        if(ad.value != "")
        {
            var d = new Date(ad.value);
            ds = d.getDate()+" "+mon[d.getMonth()]+","+d.getFullYear();
            var site_only = document.getElementById("siteonly").checked;
            if(document.getElementById("kperunit") != undefined && document.getElementById("kperunit").checked)
            {
                data.y_legend.text = "Amount in K/USD";
                aging.getAging(ds,site_only,true,setAgingValue);
            }
            else
            {
                data.y_legend.text = "Amount in USD";
                aging.getAging(ds,site_only,false,setAgingValue);
            }
        }
    }
    function setAgingValue(Oj){
        doc = document.getElementById("agingContent");
        if(doc.firstChild)
            doc.removeChild(doc.firstChild);
            
        pg.html.appendObject({"create":"div","param":{"innerHTML":Oj}},doc);
        var agingResult = document.getElementById("agingResult");
        if(agingResult != undefined)
        {
            //var colsOverSite = new Array(0,24,13,9,7,5,3,1,0);
            var colsOverSite = new Array(0,999,84,56,42,28,14,0,-7);            
            var rows = agingResult.rows.length;
            var cols = agingResult.rows[0].cells.length;
            var site_only = document.getElementById("siteonly").checked;
            if(site_only)
                agingResult.rows[0].cells[0].style.display = "none";
            for(var i=1; i < rows; i++)
            {
                var row = agingResult.rows[i];
                row.onmouseover = function(){this.style.backgroundColor = '#FFD8DC';}
                row.onmouseout = function(){this.style.backgroundColor = '';}
                if(site_only)
                    row.cells[0].style.display = "none";
                for(var j=2;j< cols;j++)
                {
                    var cell = row.cells[j];
                    if(cell == undefined)
                        break;
                    cell.style.textAlign="right";
                    cell.onmouseover = function(){
                        this.style.backgroundColor = "#FFB5B5";
                        this.style.fontWeight = "bold";
                        this.style.fontSize = "12pt";
                    }
                    cell.onmouseout = function()
                    {
                        this.style.backgroundColor = "";
                        this.style.fontWeight = "";
                        this.style.fontSize = "";
                    }
                    if(cell.innerHTML != "0" && j < cols -1)
                    {
                        cell.style.cursor = "pointer";
                        cell.colid = j;
                        if(i < rows-1){
                            cell.onclick = function(e){
                                var oem = this.parentNode.firstChild.innerText;
                                var plant = this.parentNode.childNodes[1].innerText;
                                var startOv=colsOverSite[this.colid]+1;
                                var endOv = colsOverSite[this.colid-1];
				aging.getAgingPartsAmt(ds,oem,plant,startOv,endOv,setDetailValue);
                                pg.html.showDivContent("detailAgingPartsAmount","");
                            }
                        }else{
                            cell.onclick = function(){
                                var startOv=colsOverSite[this.colid]+1;
                                var endOv = colsOverSite[this.colid-1];
                                aging.getAgingPartsAmt(ds,'','',startOv,endOv,setDetailValue);
                                pg.html.showDivContent('detailAgingPartsAmount','');
                            }
                        }
                    }
                }
            }
    loadOpenFlashChart(rows,cols);
        }
    }

    function loadOpenFlashChart(rows,cols)
    {
        document.getElementById("my_chart").style.display = "none";
        if(agingResult.rows[1].cells.length ==1)
            return;
            var key = 0;
            if(document.getElementById("siteonly").checked)
                key= 1
            data.elements[0].colours = setColor(rows-1);
            data.elements[0].keys.length = 0;
            data.elements[0].values.length = 0;//cols-1;
            data.title.text = document.getElementById("aging_title").innerHTML;
            var max=0;
            var min=9999
            var total = 0;
            var valx = new Array();
            for(var a = 2; a < cols-1; a++){
                total = 0;
                valx[a-2] = new Array();
                for(var b=1; b < rows-1; b++){
                    if(b==1)
                        data.x_axis.labels.labels[a-2] = agingResult.rows[0].cells[a].innerText.trim();
                    if(a==2){
                        data.elements[0].keys[b-1]= {"colour":data.elements[0].colours[b-1],"text":agingResult.rows[b].cells[key].innerText.trim(),"font-size":11};
                    }
                    var prc = parseFloat(agingResult.rows[b].cells[a].innerHTML);
                    valx[a-2][b-1] = prc;
                    total += prc;
                }
                if(total > max) max = total;
                if(total < min) min = total;
            }

            data.elements[0].values = valx;
            data.y_axis.max = max+10;

            var params ={};
            params.wmode = "transparent";
            document.getElementById("my_chart").style.display = "block";
            swfobject.embedSWF("open-flash-chart2.swf", "my_chart", "960", "450", "9.0.0","expressInstall.swf",{},params,{});
    }
    function setDetailValue(Oj)
    {   
        var root = document.getElementById("detailAgingPartsAmount");
        root.style.filter = "alpha(opacity=100)";
        root.style.padding = "1px";
        root.style.backgroundColor = "#E6FFDB";
        var cls = pg.html.appendObject({"create":"div","param":{"innerHTML":"Close","style":{"padding":"2px","textAlign":"right","fontSize":"14px","fontWeight":"bold","color":"#ffffff","backgroundColor":"blue","cursor":"pointer"}}},root);
        cls.onclick = function(){ pg.html.hideDivContent("detailAgingPartsAmount");}
        pg.html.appendObject({"create":"div","param":{"innerHTML":Oj}},root);
    }
    window.onload = function()
    {
        var ad = document.getElementById("agingDate");
        if(ad != undefined)
        {
            var d = new Date();
            ad.value = (d.getMonth()+1) +"/"+ d.getDate() +"/" + d.getFullYear();
            getaging();
        }
    }
    </script>
    <script type="text/javascript">
    var data;
    var hexArray = new Array( "0", "1", "2", "3","4", "5", "6", "7","8", "9", "A", "B", "C", "D", "E", "F" );
    var CRS = new Array("#FF0000","#CC0099","#660099","#330099","#0033CC",
    "#009999","#00CC00","#6BB200","#B2B300","#FFCC00","#FF9900","#FF6600",
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
    function ofc_ready(){
    //do nothing..
    }
    function open_flash_chart_data(){return JSON.stringify(data);} //let data object to be open flash chart data object.
    function findSWF(movieName) {
      if (navigator.appName.indexOf("Microsoft")!= -1) {return window[movieName];} 
      else {return document[movieName];}
    }

    var data = {"elements":
    [{"type": "bar_stack","colours":[],"values":[],"keys":[],"key-on-click":"toggle-visibility"}],
     "legend":{"position":"right"},
     "title":{"text":"","style":"{font-size: 20px; color: #F24062; text-align: center;}"},
     "x_axis":{"labels":{"labels":[],"rotate":35,"colour":"e43456"}},
     "y_axis":{"min":0,"max":1000,"steps":10},
     "y_legend":{"text":"USD(K)","style":"{font-size: 12px; color:#736AFF;}"},
     "tooltip":{"mouse":2}
    };

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"  >
            <Services>
                <asp:ServiceReference Path="~/aging.asmx" />
            </Services>
        </asp:ScriptManager>
        <div>
            <uc1:menu ID="menu1" runat="server" />
            <div id="hubaging">
                <div style="padding:6px;">
                    Aging Date:
                    <input type="text" id="agingDate" onclick="setCal(this)" readonly="readonly" />
                    K/USD:<input type="checkbox" id="kperunit" value="1" checked="checked" />
                    <!-- site only filter,will be enable at 31/8/2011-->
                    <span>By Plant:<input type="checkbox" id="siteonly" value="1" /></span>
                    <input type="button" onclick="getaging()" value="Get Aging" />
                </div>
                <div style="padding:4px;"><div id="my_chart"></div></div>
                
                <div id="agingContent" style="padding:4px; width:960px;">
                </div>
            </div>
        </div>
    </form>
</body>
</html>

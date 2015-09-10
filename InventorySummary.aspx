<%@ Page Language="C#" AutoEventWireup="true" Inherits="InventorySummary" Codebehind="InventorySummary.aspx.cs" %>

<%@ Register src="menu.ascx" tagname="menu" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hub Inventory Summary</title>
    <link href="Stylesheet.css" rel="stylesheet" type="text/css" />
    <script src="http://bi.multek.com/ws/utility.js" type="text/javascript"></script>
    <script src="http://bi.multek.com/ws/calendar.js" type="text/javascript"></script>
    <script type="text/javascript">
    function OpenUpSlide(obj,id)
    {
        pg.html.hideDivContent("detailAgingPartsAmount");
        var tb = document.getElementById("grid1");
        if(tb)
        {
            switch (id){
            case 1:
                status(tb,obj,3,0,2);
                break;
            case 2:
                status(tb,obj,5,3,5);
                break;
            case 3:
                status(tb,obj,7,6,13);
                break;
            }
        }
    }
    function status(tb,cell,iCell,startCell,endCell)
    {
        var status = "block";
        cell.innerHTML = "-";//"&lt;";
        if(tb.rows[0].cells[iCell].style.display != "none"){
            status = "none";
            cell.innerHTML = "+";//"&gt;";
        }
        tb.rows[0].cells[iCell].style.display = status;
        for(var i = startCell; i <= endCell; i++){
            tb.rows[1].cells[i].style.display = status;
            for(var j =2; j < tb.rows.length; j++)
            {
               tb.rows[j].cells[i+3].style.display = status;
            }
        }
    }
    var filterKey = "";
    function goFilter(o)
    {
        var tb = document.getElementById("grid1");
        if(filterKey != o.innerHTML && o.innerHTML != "Total")
        {
            filterKey = o.innerHTML;
            for(var i=2; i < tb.rows.length-1; i++)
            {
                var r = tb.rows[i];
                if(r.cells[0].innerHTML != filterKey)
                    r.style.display = "none";
                else
                    r.style.display = "block";
            }
        }
        else
        {
            filterKey = "";
            for(var i=2; i < tb.rows.length-1; i++)
                tb.rows[i].style.display = "block";
        }
    }
    function plantFilter(o)
    {
        pg.html.hideDivContent("detailAgingPartsAmount");
        var tb = document.getElementById("grid1");
        if(filterKey != o.innerHTML && o.innerHTML != "all")
        {
            filterKey = o.innerHTML;
            for(var i=2; i < tb.rows.length-1; i++)
            {
                var r = tb.rows[i];
                if(r.cells[1].innerHTML != filterKey)
                    r.style.display = "none";
                else
                    r.style.display = "block";
            }
        }
        else
        {
            filterKey = "";
            for(var i=2; i < tb.rows.length-1; i++)
                tb.rows[i].style.display = "block";
        }    
    }
    function clickDetail(o,c){
        var d = new Date(document.getElementById("summaryDate").value);
        var mon = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
        ds = d.getDate()+" "+mon[d.getMonth()]+","+d.getFullYear();

        var tr = o.parentNode
        var oem = tr.cells[0].innerText;// tr.firstChild.innerText;
        var plant = tr.cells[1].innerText;// tr.childNodes[1].innerText;
        if(plant == "all")
            oem = plant = "";
        switch(c)
        {
            case 9:case 10:case 11:case 12:case 13:case 14: case 15:
                var colsOverSite = new Array(0,999,84,56,42,28,14,0,-7,-999);            
                var startOv=colsOverSite[c-7]+1;
                var endOv = colsOverSite[c-8];
                aging.getAgingPartsAmt(ds,oem,plant,startOv,endOv,setDetailValue);
                pg.html.showDivContent('detailAgingPartsAmount','');
                break;
            case 6:
                aging.getFgPartsAmt(ds,oem,plant,setDetailValue);
                pg.html.showDivContent('detailAgingPartsAmount','');
                break;
            case 3:
                aging.getHubInOutPartsAmt(ds,oem,plant,true,setDetailValue,failed);
                pg.html.showDivContent('detailAgingPartsAmount','');
                break;
            case 4:
                aging.getHubInOutPartsAmt(ds,oem,plant,false,setDetailValue);
                pg.html.showDivContent('detailAgingPartsAmount','');
                break;
        }
    }
function failed(o){alert(JSON.stringify(o));}

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

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"  >
            <Services>
                <asp:ServiceReference Path="~/aging.asmx" />
            </Services>
        </asp:ScriptManager>
        <div>
        <uc1:menu ID="menu1" runat="server" />
        <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
            <div id="summary">
                <div style="padding:2px;">
                    <asp:Label ID="title" runat="server" CssClass="MasterTile" /><br />
                    <span class="hide">
                    Date: <asp:TextBox ID="summaryDate" ReadOnly="true" runat="server" />
                    </span>
                    <asp:CheckBox ID="isK" Text="K/USD" runat="server" AutoPostBack="true" 
                        oncheckedchanged="isK_CheckedChanged"  />
                </div>
                <asp:GridView ID="grid1" runat="server" AutoGenerateColumns="False" CssClass="standardTable"
                    ondatabound="grid1_DataBound" onrowdatabound="grid1_RowDataBound" >
                    <Columns>
                        <asp:BoundField DataField="oem" HeaderText="OEM" />
                        <asp:BoundField DataField="plant" HeaderText="Plant" />
                        <asp:BoundField DataField="fcst" HeaderText="Current period VMI Booking" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" 
                            ItemStyle-BackColor="#EEBFFF" >
                            <HeaderStyle BackColor="#EEBFFF" />
                            <ItemStyle BackColor="#EEBFFF" HorizontalAlign="Right" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="inAMT" HeaderText="In" DataFormatString="{0:#,##0}" 
                            ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderStyle-BackColor="#C5E5CA"
                            ItemStyle-BackColor="#DBFFE1" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#DBFFE1" />
                        </asp:BoundField>
                        <asp:BoundField DataField="outAMT" HeaderText="Out" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#C5E5CA"
                            ItemStyle-BackColor="#DBFFE1" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#DBFFE1" />
                        </asp:BoundField>
                        <asp:BoundField DataField="delta" HeaderText="Delta" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#C5E5CA"
                            ItemStyle-BackColor="#DBFFE1" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#DBFFE1" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fg_total" HeaderText="Total" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E5E4BC" ItemStyle-BackColor="#FFFED1" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFFED1" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fg_available" HeaderText="F.G. Available" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E5E4BC" ItemStyle-BackColor="#FFFED1" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFFED1" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fg_bal" HeaderText="Balance to Build" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E5E4BC" ItemStyle-BackColor="#FFFED1" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFFED1" />
                        </asp:BoundField>
                        <asp:BoundField DataField="over12weeks" HeaderText="Over 12 Weeks" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E5A5A2" ItemStyle-BackColor="#FFE2CC" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFE2CC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="over8weeks" HeaderText="Over 8 Weeks" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E5A5A2" ItemStyle-BackColor="#FFE2CC" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFE2CC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="over6weeks" HeaderText="Over 6 Weeks" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E5A5A2" ItemStyle-BackColor="#FFE2CC" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFE2CC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="over4weeks" HeaderText="Over 4 Weeks" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E2E5C3" ItemStyle-BackColor="#FFE2CC" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFE2CC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="over2weeks" HeaderText="Over 2 Weeks" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E2E5C3" ItemStyle-BackColor="#FFE2CC" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFE2CC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="lessthen2weeks" HeaderText="Less then 2 Weeks" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E2E5C3" ItemStyle-BackColor="#FFE2CC" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFE2CC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="intransit" HeaderText="In Transit" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#E2FFE4" ItemStyle-BackColor="#FFE2CC" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFE2CC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="total" HeaderText="Total" 
                            DataFormatString="{0:#,##0}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-Wrap="False" HeaderStyle-BackColor="#BEE2E5" ItemStyle-BackColor="#FFE2CC" >
                            <ItemStyle HorizontalAlign="Right" Wrap="False" BackColor="#FFE2CC" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                
                <asp:LinkButton ID="download" runat="server" Text="Download as Excel file" OnClick="download_Click" />
            </div>
            <asp:Label ID="message" runat="server" />
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="download" />
        </Triggers>
        </asp:UpdatePanel>
        </div>
    </div>
    </form>
</body>
</html>

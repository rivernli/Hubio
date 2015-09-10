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
    /*
    http://www.2createawebsite.com/build/hex-colors.html
    #FF0000#B20000#FEBFBF#FE8080
#E60066#A10048#FEBFDC#FE80B9
#CC0099#8E006B#FEBFEF#FE80DF
#990099#6B006B#FFBFFE#FF80FE
#660099#47006B#EABFFE#D580FE
#400099#2D006B#DABFFE#B580FE
#330099#24006B#D4BFFE#AA80FE
#1919B3#12127D#C8C8FE#9191FE
#0033CC#00248E#BFCFFE#809FFE
#0066B3#00477D#BFE3FE#80C8FE
#009999#006B6B#BFFFFE#80FFFE
#00B366#007D47#BFFEE3#80FEC8

#00CC00#008E00#BFFEBF#80FE80
#33FF00#24B200#CCFEBF#99FE80
#99FF00#6BB200#E6FEBF#CCFE80
#CCFF00#8FB200#F2FEBF#E6FE80
#FFFF00#B2B300#FEFFBF#FEFF80
#FFE500#B2A100#FEF9BF#FEF280
#FFCC00#B28F00#FEF2BF#FEE680
#FFB200#B27D00#FEECBF#FED980
#FF9900#B26B00#FEE6BF#FECC80
#FF8000#B25900#FEDFBF#FEBF80
#FF6600#B24700#FED9BF#FEB380
#FF3300#B22400#FECCBF#FE9980*/

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
    //for hub aging get by select date and show aging table (not part number).
    function getAging(){
        var inv = document.getElementById("hubinventory");
        if(inv =="null" || inv == "undefinded")
            return;
        if(document.getElementById("D") != null || document.getElementById("DP") != null){           
            if(document.getElementById("D").checked || document.getElementById("DP").checked){
                var x = document.getElementById("GridView1");
                if(x){
                 this.style.cursor = "pointer";
                    var tb = x.firstChild;
                    var dat = this.innerHTML;
                    //aging.getAging(dat,setValue);
                    alert("error: ws.aging.getAging drop!");
                    pg.html.showDivContent('tmp','<b style="color:red">Aging hub on '+dat+'</b>');
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
        
        if(document.getElementById("D").checked || document.getElementById("DP").checked){
            var x = document.getElementById("GridView1");
            if(x){
                this.style.cursor = "pointer";
                //var tb = x.firstChild;
                var oem = x.rows[this.x].cells[0].innerText;  //tb.childNodes[this.x].childNodes[0].innerText;
                var dat = x.rows[0].cells[this.y].innerHTML.replace(" closing","");// =  tb.childNodes[0].childNodes[this.y].innerHTML.replace(" closing","");
                var isQty = false;
                if(document.getElementById("no_type") != undefined && document.getElementById("no_type").selectedIndex ==1)
                    isQty = true;
                var isOEM = 1;
                if(document.getElementById("isPlant").checked)
                    isOEM=2;
                if(document.getElementById("isCEM").checked)
                    isOEM=3;
                aging.getAmountDetail(oem,dat,isQty,isOEM,setValue);
                pg.html.showDivContent('tmp',oem + " &nbsp; "+ dat +"&nbsp; &nbsp;");
            }
       }
    }
    function setValue(Oj){
        doc = document.getElementById("tmp");
        doc.style.zIndex = 100;
        //doc.innerHTML += Oj;
        doc.style.filter="alpha(opacity=95)";
        
        var span = document.createElement("span");
        span.innerHTML = "x";
        span.style.cursor = "pointer";
        span.style.backgroundColor ="#495FFF";
        span.style.color = "#ffffff";
        span.style.padding = "1px 5px";
        span.style.border = "1px #ffffff solid";
        span.onclick =function(){pg.html.hideDivContent('tmp')};
        doc.appendChild(span);
        
        var div = document.createElement("div");
        div.innerHTML = Oj;
        //div.onclick = function(){pg.html.hideDivContent('tmp')};
        doc.appendChild(div);
    }
    function loadpage(){
        closeCalendar();
        pg.html.hideDivContent('tmp');
        //prepare data and loading open flash chart
        var x = document.getElementById("GridView1");
        if (x) {
            var rows = x.rows.length - 1;
            var cols = x.rows[0].cells.length;
            /*
            var tb = x;//.firstChild;
            var rows = tb.childNodes.length-1; //no. of oem
            var cols = tb.firstChild.childNodes.length; //no. of period
            */
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
                    var node = x.rows[b + 1].cells[a + 1]; //tb.childNodes[b+1].childNodes[a+1];
                    var prc = parseInt(node.innerHTML);
                    valx[a][b] = prc;
                    node.innerHTML = "--";
                    if(prc !=0){
                        node.innerHTML = "";
                        var span = document.createElement("span");
                        span.innerHTML = addCommas(prc);
                        node.appendChild(span);
                        span.x = b+1;
                        span.y = a+1;
                        span.onmouseover = mov;
                        span.onclick = getDetail;
                    }
                    total += prc;
                }
                x.rows[rows].cells[a + 1].innerHTML = total;
                x.rows[rows].cells[a + 1].style.fontWeight = "bolder";
                /*
                tb.childNodes[rows].childNodes[a+1].innerHTML = total;
                tb.childNodes[rows].childNodes[a+1].style.fontWeight = "bolder";
                */
                if(total > max) max = total;
                if(total < min) min = total;
                var tcell = x.rows[rows].cells[a + 1]; //tb.childNodes[rows].childNodes[a+1];
                tcell.innerHTML = addCommas(tcell.innerHTML);
            }
            x.rows[rows].cells[0].style.fontWeight = "bolder"; //tb.childNodes[rows].childNodes[0].style.fontWeight = "bolder";
            data.elements[0].values = valx;
            
            //for keys items (OEM assort)
            for(var i = 0; i < rows-1; i++){
                var n = x.rows[i + 1];  //tb.childNodes[i+1];
                //data.elements[0].keys[i]={"colour":data.elements[0].colours[i],"text":n.firstChild.innerText.trim().ReplaceAll(" ","_").substr(0,10),"font-size":12};
                data.elements[0].keys[i]={"colour":data.elements[0].colours[i],"text":(n.firstChild.innerText+"").trim(),"font-size":11};
            }
            for(i=0; i <=rows; i++)
            {
                x.rows[i].cells[0].style.textAlign = "left"; //tb.childNodes[i].childNodes[0].style.textAlign ="left";
            }
           
            //for average & title?
            var avg = (max -min)/2;
            var m5 = parseInt(document.getElementById("hubTarget").value);
            if(m5 < 0) 
                ms = 5000000;
            maxNmin(max,min);

            data.elements.length = 1;
            //data.elements[2] = new LineElement("Avg","#3D32FF","");
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
                title[k] = x.rows[0].cells[k + 1].innerHTML;  //tb.childNodes[0].childNodes[k+1].innerHTML;
                //data.elements[1].values[k] = {"value":avg,"tip":"Average<br>#val#"};
                if(showM5) data.elements[1].values[k] = {"value":m5,"tip":"Target<br>"+addCommas(m5)};
                if(lm.amt > 0)data.elements[2].values[k] = {"value":lm.amt,"tip":lm.date+":#val#"};
            }
            data.x_axis.labels.labels = title;
            
            var params ={};
            params.wmode = "transparent";
            swfobject.embedSWF("open-flash-chart2.swf", "my_chart", "960", "450", "9.0.0","expressInstall.swf",{},params,{});
            //makescrolling(x);
        }
    }
function makescrolling(tbl){
    var gvh = document.getElementById("gridviewholder");
    if(gvh){
        if(gvh.clientHeight > 350)
            gvh.style.height = "360px";
        else
            gvh.style.height = gvh.clientHeight + 50;
            
        var tbl2 = tbl.cloneNode(true);
        tbl2.id = "tbl2";
        var tbl3 = tbl.cloneNode(true);
        tbl3.id = "tbl3";
        var pan = document.createElement("table");

        gvh.appendChild(tbl2);
        gvh.appendChild(tbl3);
        gvh.appendChild(pan);
        
        pan.className = tbl3.className = tbl2.className = tbl.className= "stbTbl";
        tbl3.style.zIndex = 11; tbl2.style.zIndex = 10; tbl.style.zIndex = 1;
        pan.style.zIndex= 100;
        pan.cellspacing=tbl.cellspacing=tbl2.cellspacing=tbl3.cellspacing="0";
        pan.cellpadding=tbl.cellpadding=tbl2.cellpadding=tbl3.cellpadding="1";
        pan.border=tbl.border=tbl2.border=tbl3.border="1";
        pan.bordercolor=tbl.bordercolor=tbl2.bordercolor=tbl3.bordercolor="#aaaaaa";
        
        var tby = tbl.firstChild; // content
        var tby2 = tbl2.firstChild; //oem cols
        var tby3 = tbl3.firstChild; //period rows
        
        tbl2.style.width = tby.childNodes[0].childNodes[0].clientWidth;
        for(var j = 0; j < tby2.childNodes.length; j++)
        {
            tby.childNodes[j].onmouseover = function(){this.style.backgroundColor="#FFEBE8";};
            tby.childNodes[j].onmouseout = function(){this.style.backgroundColor="";};
            var tr = tby2.childNodes[j];
            tr.style.height = tby.childNodes[j].clientHeight;
            for(var i=tr.childNodes.length-1; i > 0; i--){
                tr.removeChild(tr.childNodes[i]);
            }
            tr.firstChild.style.borderRight = "1px #aaa solid";
            tr.firstChild.style.backgroundColor = "#E2EFFF";
        }
        
        tby3.firstChild.style.height = tby.firstChild.clientHeight;
        tby3.firstChild.style.backgroundColor = "#E2EFFF";
        for(var k = tby3.childNodes.length -1; k > 0; k--){
            tby3.removeChild(tby3.childNodes[k]);
        } 
        for(var x =tby3.firstChild.childNodes.length-1; x >=0 ; x--){
            var nx = tby3.firstChild.childNodes[x];
            nx.onmouseover = mov;
            nx.onclick = getAging;
            nx.style.width = tby.firstChild.childNodes[x].clientWidth;// +"vs" + tby3.firstChild.childNodes[x].clientWidth);
        }
        
        tbl3.width = tbl3.style.width = tbl.clientWidth;
        pan.id = "tbl4";
        var pby = document.createElement("tbody");
        var ptr = document.createElement("tr");
        var ptd = document.createElement("th");
        pan.appendChild(pby);
        pby.appendChild(ptr);
        ptr.appendChild(ptd);
        ptd.style.width = tby2.firstChild.childNodes[0].clientWidth;
        ptr.style.height = tby2.firstChild.clientHeight;
        ptd.innerHTML = tby2.firstChild.childNodes[0].innerHTML;
        ptd.style.backgroundColor = "#E2EFFF";
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


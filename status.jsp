<%-- Document : status Created on : Feb 24, 2016, 2:49:04 PM --%>

    <%@page import="java.sql.ResultSet" %>
        <%@page import="java.sql.Statement" %>
            <%@page import="java.sql.Connection" %>
                <%@page import="mypack.config2" %>
                    <%ResultSet resultset=null;%>
                        <%@page contentType="text/html" pageEncoding="UTF-8" %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta http-equiv="content-type" content="text/html; charset=utf-8" />

                                <style>
                                    @font-face {
                                        font-family: myfont;
                                        src: url(OpenSans-Regular.ttf);
                                    }

                                    .round-button {
                                        width: 10%;
                                        height: 0;
                                        padding-bottom: 10%;
                                        border-radius: 50%;
                                        border: 2px solid #f5f5f5;
                                        overflow: hidden;
                                        background: #464646;
                                        box-shadow: 0 0 3px gray;
                                    }

                                    .round-button:hover {
                                        background: #262626;
                                    }

                                    .round-button img {
                                        display: block;
                                        width: 76%;
                                        padding: 12%;
                                        height: auto;
                                    }

                                    body {
                                        margin: 0px;
                                        padding: 0px;
                                        background-color: white;
                                        overflow-x: hidden;
                                        color: black;
                                        font-family: myfont;
                                        font-size: 13px;

                                    }


                                    .agent {

                                        box-shadow: none;
                                        width: 100%;
                                        height: 50%;

                                    }

                                    .main_call1 {
                                        box-shadow: none;
                                        float: left;
                                        display: block;
                                        border-top-style: solid;
                                        border-top-color: grey;
                                        border-top-width: 1px;
                                        width: 100%;
                                        height: 20%;
                                        margin-top: 0%;
                                        padding-top: 0%;
                                        margin-bottom: 0%;

                                    }

                                    .main_call {
                                        box-shadow: none;
                                        float: left;
                                        display: block;
                                        border-top-style: solid;
                                        border-top-color: grey;
                                        border-top-width: 1px;
                                        width: 100%;
                                        height: 6%;
                                        margin-top: 5%;
                                        padding-top: 2%;
                                        margin-bottom: 5%;

                                    }

                                    .hold_block {
                                        box-shadow: none;
                                        float: left;
                                        display: block;
                                        width: 100%;
                                        height: 6%;
                                        margin-top: 0x;
                                        padding-top: 2%;
                                        margin-bottom: 0x;

                                    }

                                    .other_call {
                                        box-shadow: none;
                                        float: left;
                                        display: block;
                                        /*    border-style: solid: 
                border-color:black;
                border-width:2px; */
                                        width: 100%;
                                        height: 6%;
                                        margin-top: 0x;
                                        margin-bottom: 0x;

                                    }

                                    .just_hold {
                                        box-shadow: none;
                                        float: left;
                                        display: block;
                                        /*    border-style: solid: */
                                        border-color: black;
                                        border-width: 2px;
                                        width: 100%;
                                        height: 6%;
                                        margin-top: 0x;
                                        margin-bottom: 0x;
                                    }

                                    img:hover {
                                        opacity: 0.3;
                                        cursor: pointer;

                                    }

                                    .hold_btn {
                                        box-shadow: none;
                                        float: left;
                                        display: block;
                                        /*  border-style: solid: */
                                        border-color: black;
                                        border-width: 2px;
                                        width: 100%;
                                        height: 6%;
                                        margin-top: 0x;
                                        margin-bottom: 0x;
                                    }

                                    .heads {
                                        box-shadow: none;
                                        width: 40%;


                                        font-size: 13px;

                                        text-align: right;

                                    }

                                    .contents {
                                        box-shadow: none;
                                        font-size: 13px;
                                        color: brown;
                                        width: 60%;
                                        text-align: center;
                                    }

                                    div {
                                        box-shadow: none;
                                        width: 100%;
                                        height: 100%;
                                        color: white;

                                        /* background: rgba(255,255,255, 0.1); /* Green background with 30% opacity */
                                        box-shadow: 1px 1px 1px grey;

                                    }

                                    .wind1 {
                                        width: 100%;
                                        height: 12%;
                                        display: inline-block;
                                        position: fixed;
                                        top: 67%;
                                        left: 0;
                                        right: 0;
                                        margin: 0 auto;
                                        text-align: center;
                                        background-color: whitesmoke;
                                    }

                                    .wind {
                                        width: 100%;
                                        height: 25%;
                                        display: inline-block;
                                        position: fixed;
                                        top: 76%;
                                        left: 0;
                                        right: 0;
                                        margin: 0 auto;
                                        text-align: center;
                                        background-color: whitesmoke;
                                    }

                                    .agent_details {
                                        /* border-bottom-style: solid;
                border-bottom-color:grey;
                border-bottom-width: 1px;
                padding-bottom: 0%; */
                                        box-shadow: none;
                                        color: black;
                                        float: left;
                                        display: block;
                                        width: 100%;
                                        height: 55%;
                                        padding: 1%;
                                        font-weight: bold;
                                    }

                                    .heading {
                                        box-shadow: none;
                                        color: black;
                                        float: left;
                                        width: 36%;

                                        align-items: center;
                                        text-align: right;
                                        padding-top: 1%;
                                        padding-right: 4%;
                                    }

                                    .heading_data {
                                        box-shadow: none;
                                        color: black;
                                        float: left;
                                        width: 60%;
                                        padding-top: 1%;

                                        text-align: center;

                                    }

                                    .side_hold_btn {
                                        width: 25%;
                                        height: 90%;
                                        float: left;
                                        border-style: solid;
                                        border-color: black;
                                        border-width: 1px;
                                        margin-left: 0%;
                                        margin-right: 0%;
                                        margin-top: 0px;
                                        margin-bottom: 0%;
                                        border-radius: 6%;
                                        text-align: center;
                                        padding-top: 1%;
                                        background-color: white;
                                        color: white;
                                        position: relative;
                                        left: 20px;
                                    }

                                    .side_btn {


                                        width: 25%;
                                        height: 40%;
                                        float: left;
                                        margin-left: 0%;
                                        margin-right: 0%;
                                        margin-top: 10px;
                                        margin-bottom: 0%;

                                        text-align: center;
                                        padding-top: 0%;
                                        background-color: white;
                                        color: white;
                                        position: relative;
                                        left: 0px;

                                    }

                                    .side_btn:hover,
                                    .side_hold_btn:hover {

                                        /* background-color: grey; 
                
                color: #3333ff; */
                                    }

                                    .side_btn:active,
                                    .side_hold_btn:active {
                                        /*   background-color: white;
                 box-shadow: 1px 1px 2px blue;
                color: white;  */
                                    }

                                    .dialpad {

                                        width: 29%;
                                        height: 20%;
                                        background-color: white;
                                        float: left;
                                        text-align: center;
                                    }

                                    .num {

                                        margin-left: 2%;
                                        margin-bottom: 1%;
                                        width: 29%;
                                        height: 9%;
                                        color: black;
                                        padding: 1%;
                                        text-align: center;
                                        border-radius: 10%;
                                        float: left;
                                        background: linear-gradient(white, lightgrey, white);
                                        box-shadow: 1px 2px 1px grey;
                                    }

                                    .btn_design1 {

                                        margin: 1%;
                                        width: 75px;
                                        height: 20px;
                                        background-color: white;

                                        text-align: center;
                                        border-radius: 10%;
                                        float: left;
                                        background: linear-gradient(white, lightgrey, white);
                                        box-shadow: 1px 1px 1px grey;
                                    }

                                    .btn_design {

                                        margin: 1%;
                                        width: 250px;
                                        height: 20px;
                                        background-color: white;

                                        text-align: center;
                                        border-radius: 10%;
                                        float: left;
                                        background: linear-gradient(white, lightgrey, white);
                                        box-shadow: 1px 1px 1px grey;
                                    }

                                    .num:active {
                                        box-shadow: 0px 0px 1px grey;


                                    }

                                    .btn:active {
                                        box-shadow: 0px 0px 1px grey;

                                    }

                                    .num:hover {
                                        cursor: pointer;

                                        background: linear-gradient(yellow, orange, yellow);
                                        color: white;
                                    }

                                    .btn_design:hover {
                                        cursor: pointer;

                                        background: linear-gradient(yellow, orange, yellow);
                                        color: white;
                                    }

                                    .btn_design1:hover {
                                        cursor: pointer;

                                        background: linear-gradient(yellow, orange, yellow);
                                        color: white;
                                    }

                                    .number {
                                        text-align: center;
                                    }
                                </style>
                                <script src="js/jquery.js"></script>


                                <script language="javascript" type="text/javascript" src="js/datetimepicker.js">
                                </script>

                            </head>

                            <body onload="getStatus(),fncFillDispositions(0),fncFillBreaks(0),sendrequest()">
                                <img id="arrow_hide" src="images/hide.png"
                                    style="position:fixed;top:292px;right:-2px;height:20px;width:20px;cursor: pointer;z-index: 1;"
                                    onclick="hideMe();" />

                                <script language="javascript">


                                    function hideMe() {
                                        window.parent.arrowHide();
                                    }

                                    const srvarray = ["83", "84", "87", "92", "57", "51", "76", "79", "80", "81", "82", "49", "55", "56", "57", "58", "59", "75", "104", "34", "35", "36", "37", "38", "40", "43", "45", "68", "72", "111", "120", "121", "122", "127", "105", "106", "107", "110", "112", "113", "114", "115", "116", "117", "118", "119", "126", "123", "124", "125", "128", "129", "130", "131", "132", "134", "135", "136", "137", "138", "139", "133", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183"];
                                    var gTime = 0;
                                    var gDuration = 0;
                                    var timer = "";
                                    var timer1 = "";
                                    var timerclose = "";
                                    var mins = 0;
                                    var disp = "";
                                    function getduration(gDuration) {
                                        nHour = Math.round(gDuration / 3600);
                                        if (nHour < 10)
                                            nHour = "0" + nHour;
                                        nMinute = Math.round((gDuration % 3600) / 60);
                                        if (nMinute < 10)
                                            nMinute = "0" + nMinute;
                                        nSecond = Math.round((gDuration % 3600) % 60);
                                        if (nSecond < 10)
                                            nSecond = "0" + nSecond;

                                        nDuration = nHour + ":" + nMinute + ":" + nSecond;
                                        return nDuration;
                                    }
                                    function getTimer(nTime, nDuration, gTime, gDuration) {
                                        nHour = Math.round(gTime / 3600);
                                        if (nHour < 10)
                                            nHour = "0" + nHour;
                                        nMinute = Math.round((gTime % 3600) / 60);
                                        if (nMinute < 10)
                                            nMinute = "0" + nMinute;
                                        nSecond = Math.round((gTime % 3600) % 60);
                                        if (nSecond < 10)
                                            nSecond = "0" + nSecond;

                                        nTime = nHour + ":" + nMinute + ":" + nSecond;

                                        nHour = Math.round(gDuration / 3600);
                                        if (nHour < 10)
                                            nHour = "0" + nHour;
                                        nMinute = Math.round((gDuration % 3600) / 60);
                                        if (nMinute < 10)
                                            nMinute = "0" + nMinute;
                                        nSecond = Math.round((gDuration % 3600) % 60);
                                        if (nSecond < 10)
                                            nSecond = "0" + nSecond;

                                        nDuration = nHour + ":" + nMinute + ":" + nSecond;
                                        return nDuration;
                                    }
                                    function getStatus() {
                                        var typeee = document.getElementById("typeee").value;
                                        var extno = document.getElementById("txt_ex").value;
                                        //alert(extno);
                                        var agnno = document.getElementById("txt_agnid").value;
                                        var sididle = document.getElementById("serviceref").value;
                                        //alert(typeee);
                                        if (typeee == "") {
                                            window.open("index.jsp", '_self');
                                        }
                                        var nTime = 0;
                                        var nDuration = 0;

                                        gTime = parseInt(gTime) + 2;
                                        gDuration = parseInt(gDuration) + 2;

                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                console.log("AGENTSTATUS -- " + response);
                                                var responsesplit = response.split("~", 2);
                                                var agentstatus = responsesplit[0];
                                                var extstatus = responsesplit[1];

                                                if (agentstatus.match("CONF") == "CONF") {
                                                    document.getElementById("table1").style.display = "";
                                                    document.getElementById("tbl_conf").style.display = "";
                                                }
                                                else {
                                                    document.getElementById("aidmain1").style.display = "block";
                                                    document.getElementById("aidmain2").style.display = "block";
                                                    document.getElementById("aidmain3").style.display = "block";
                                                    document.getElementById("aidmain4").style.display = "block";
                                                    document.getElementById("aidmain5").style.display = "block";
                                                    document.getElementById("aidmain6").style.display = "block";
                                                    document.getElementById("table1").style.display = "none";
                                                }
                                                if (extstatus == "UP" && (agentstatus == "INCALL" || agentstatus == "INCALL(HOLD)" || agentstatus == "INCALL(CONF)")) {
                                                    extstatus = "TALK";

                                                    window.parent.frame0.document.getElementById("btn_Change").style.pointerEvents = "none";

                                                }
                                                if (extstatus == "DOWN" || extstatus == "UNKNOWN") {
                                                    document.getElementById("extensionstatus").style.backgroundColor = "#FF0000";
                                                    var logoutondown = document.getElementById("logoutondown").value;
                                                    if (logoutondown == "Y")
                                                        fncLogout();
                                                }
                                                else {
                                                    document.getElementById("extensionstatus").style.backgroundColor = "#FFFFFF";
                                                }
                                                if (extstatus == "DOWN" || extstatus == "UNKNOWN" || agentstatus == "IDLE(NR)") {
                                                    var logoutondown = document.getElementById("logoutondown").value;
                                                    if (logoutondown == "Y")
                                                        fncLogout();
                                                }
                                                if (agentstatus.match("IDLE") == "IDLE") {

                                                    window.parent.frame0.document.getElementById("btn_Change").style.pointerEvents = "";
                                                    disabled_all_desktop_btn();
                                                    document.getElementById("opentpcrm").value = 0;

                                                    if (document.getElementById("manual_dial_btn") !== null)
                                                        document.getElementById("manual_dial_btn").style.pointerEvents = "";

                                                    if (document.getElementById("break_call_btn") !== null)
                                                        document.getElementById("break_call_btn").style.pointerEvents = "";

                                                    if (document.getElementById("btn_hold") !== null)
                                                        document.getElementById("btn_hold").style.pointerEvents = "";

                                                    if (document.getElementById("block") !== null)
                                                        document.getElementById("block").style.pointerEvents = "";

                                                    //document.getElementById("agentstatus").innerHTML=agentstatus;

                                                    var currentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                                    var responsesplitt = response.split("~", 6);
                                                    if (currentstatus.match("IDLE") == "IDLE") {
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[2];
                                                        //document.getElementById("servicename").innerHTML = agentstatus;

                                                        if (document.getElementById("btn") !== null)
                                                            document.getElementById("btn").value = "Break";

                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                        document.getElementById("demo1").value = "";
                                                        document.getElementById("agentstatus").style.backgroundColor = "#FFFFFF";
                                                        document.getElementById("calltype").style.backgroundColor = "#FFFFFF";
                                                        window.parent.frame0.document.getElementById("btn_logout").value = "Login";
                                                        document.getElementById("txt_crm").value = "idle.jsp?typeee=agent";
                                                        document.getElementById("callnumber").value = "0";
                                                        window.parent.frame0.document.getElementById("btn_Change").disabled = false;
                                                    }
                                                    else {
                                                        document.getElementById("ivrinfo").innerHTML = "";
                                                        document.getElementById("agentstatus").style.backgroundColor = "#FFFFFF";
                                                        document.getElementById("calltype").style.backgroundColor = "#FFFFFF";
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;
                                                        document.getElementById("extensionstatus").innerHTML = extstatus;

                                                        if (document.getElementById("txt_dial") !== null)
                                                            document.getElementById("txt_dial").value = "";
                                                        //document.getElementById("txt_dial").value = document.getElementById("txt_callerid").value;

                                                        gTime = gDuration = 0;
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[2];
                                                        //window.parent.frame3.location.href = "idle.jsp?typeee=agent";
                                                        var idleurl = "http://172.16.0.13:80/WEBCRM/SAMPARK_START_PAGE_28/startpage.aspx?AGENTSTATUS=" + responsesplitt[0] + "&EXTENSIONSTATUS=" + responsesplitt[1] + "&STATUSSINCE=" + responsesplitt[2] + "&QUEUECOUNT=" + responsesplitt[3] + "&INFOMESSAGSYSTEM=" + responsesplitt[4] + "&AGENTBLOCKSTATUS=" + responsesplitt[5] + "&BREAKTYPE=" + responsesplitt[6] + "&EXTNO=" + extno + "&AGENTID=" + agnno + "&SERVICEID=" + sididle;
                                                        console.log("------------------" + idleurl);
                                                        window.parent.frame3.location.href = idleurl;
                                                        document.getElementById("txt_crm").value = "http://172.16.0.13:80/WEBCRM/SAMPARK_START_PAGE_28/startpage.aspx?AGENTSTATUS=" + responsesplitt[0] + "&EXTENSIONSTATUS=" + responsesplitt[1] + "&STATUSSINCE=" + responsesplitt[2] + "&QUEUECOUNT=" + responsesplitt[3] + "&INFOMESSAGSYSTEM=" + responsesplitt[4] + "&AGENTBLOCKSTATUS=" + responsesplitt[5] + "&BREAKTYPE=" + responsesplitt[6] + "&EXTNO=" + extno + "&AGENTID=" + agnno + "&SERVICEID=" + sididle;
                                                        //document.getElementById("txt_crm").value = "idle.jsp?typeee=agent";
                                                        document.getElementById("callerid").innerHTML = "";
                                                        document.getElementById("nocallerid").innerHTML = "";
                                                        document.getElementById("calltype").innerHTML = "";
                                                        //document.getElementById("servicename").innerHTML = "";
                                                        FncSetIdle();
                                                        document.getElementById("demo1").value = "";
                                                        window.parent.frame0.document.getElementById("btn_logout").value = "Login";
                                                        var a = ['tbl_trans', 'tbl_conf', 'tbl_dial', 'tbl_1'];
                                                        window.parent.frame0.document.getElementById("btn_Change").disabled = true;
                                                        window.parent.document.getElementById("notice").style.display = "none";
                                                        var i = 0;
                                                        for (i = 0; i < a.length; i++) {

                                                            if (document.getElementById(a[i]) !== null)
                                                                document.getElementById(a[i]).style.display = "none";
                                                        }
                                                    }
                                                    if (responsesplitt[5].match("UNBLOCK") == "UNBLOCK") {
                                                        if (document.getElementById("block") !== null) {
                                                            document.getElementById("block").value = "BLOCK";
                                                            document.getElementById("agentstatus").innerHTML = agentstatus;
                                                            $("#block_btn_img").attr("src", "images/greenblock.png");
                                                        }
                                                    }
                                                    else {
                                                        document.getElementById("block").value = "UNBLOCK";
                                                        document.getElementById("agentstatus").innerHTML = agentstatus + " (Block)";
                                                        $("#block_btn_img").attr("src", "images/redblock.png");
                                                    }
                                                    var queue = responsesplitt[3];
                                                    if (queue != "") {
                                                        queue = parseInt(queue);
                                                        if (queue > 0) {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = queue;
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#FF4500";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = "";
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#2364AA";
                                                        }
                                                    }


                                                    var marque = responsesplitt[4].split("111").join("\n");
                                                    var msg_box = responsesplitt[4].split("111").join("<br />");

                                                    if (marque != "NA") {
                                                        var text = window.parent.frame0.document.getElementById("marquee").innerHTML;
                                                        text = text.replace("<marquee>", "").replace("</marquee>", "");
                                                        var n = marque.localeCompare(text);
                                                        if (n == "0" || msg_box == "") {
                                                            window.parent.document.getElementById("notice").style.display = "none";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("marquee").innerHTML = "<marquee>" + marque + "</marquee>";
                                                            window.parent.document.getElementById("notice").style.display = "";
                                                            window.parent.document.getElementById("notice_alert").innerHTML = msg_box;


                                                        }
                                                    }
                                                    else {
                                                        window.parent.frame0.document.getElementById("marquee").innerHTML = "";
                                                        window.parent.document.getElementById("notice").style.display = "none";

                                                    }

                                                    window.parent.document.getElementById("disp_name").value = "";
                                                    window.parent.document.getElementById("sub_disp_name").value = "";
                                                    window.parent.document.getElementById("sub_sub_disp_name").value = "";
                                                }
                                                else if (agentstatus.match("WRAPUP") == "WRAPUP") {
                                                    window.parent.frame0.document.getElementById("btn_Change").disabled = true;
                                                    var currentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                                    var responsesplitt = response.split("~", 20);
                                                    var cd_d = "";
                                                    if (currentstatus.match("WRAPUP") == "WRAPUP") {
                                                        if (document.getElementById("close_call_btn") !== null)
                                                            document.getElementById("close_call_btn").style.pointerEvents = "";

                                                        if (document.getElementById("break_call_btn") !== null)
                                                            document.getElementById("break_call_btn").style.pointerEvents = "";

                                                        if (document.getElementById("manual_dial_btn") !== null)
                                                            document.getElementById("manual_dial_btn").style.pointerEvents = "";

                                                        document.getElementById("statusSince").innerHTML = responsesplitt[16];
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;
                                                        if (document.getElementById("btn") !== null)
                                                            document.getElementById("btn").value = "Break";

                                                        if (responsesplitt[5].match("UNBLOCK") == "UNBLOCK") {
                                                            //alert("in here");
                                                            document.getElementById("statusSince").innerHTML = responsesplitt[2];
                                                            //mins = 15;
                                                        }
                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                        document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                        document.getElementById("callnumber").value = responsesplitt[3];
                                                        //document.getElementById("srvdatetime").value = responsesplitt[20];
                                                        mins = parseInt(mins);
                                                        if (mins > 0) {
                                                            mins = mins - 2;
                                                            if (mins <= 0) {
                                                                document.getElementById("txt_autowrap").value = "autowrap";
                                                                document.getElementById("txt_autodisp").value = disp;
                                                                abc("autowrap");
                                                            }
                                                        }
                                                    }
                                                    else {
                                                        mins = responsesplitt[14];
                                                        if (responsesplitt[5].match("UNBLOCK") == "UNBLOCK") {
                                                            mins = 10;
                                                        }
                                                        disp = responsesplitt[15];
                                                        if (document.getElementById("txt_dial") !== null)
                                                            document.getElementById("txt_dial").value = document.getElementById("txt_callerid").value;
                                                        document.getElementById("agentstatus").style.backgroundColor = "#98FB98";
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;
                                                        document.getElementById("extensionstatus").innerHTML = extstatus;

                                                        var hcallerid = document.getElementById("hidecallerid").value;
                                                        if (hcallerid == 'Y') {
                                                            document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                            var str = responsesplitt[2];
                                                            var n = str.replace(/.(?=.{4})/g, 'x');
                                                            document.getElementById("nocallerid").innerHTML = n;
                                                        }
                                                        else {
                                                            document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                            document.getElementById("nocallerid").innerHTML = responsesplitt[2];
                                                        }

                                                        var sid = "";
                                                        sid = responsesplitt[13];

                                                        if (srvarray.indexOf(sid) > -1) {
                                                            var str = responsesplitt[2];
                                                            var n = str.replace(/.(?=.{4})/g, 'x');
                                                            document.getElementById("nocallerid").innerHTML = n;
                                                        }
                                                        else {
                                                            document.getElementById("nocallerid").innerHTML = responsesplitt[2];
                                                        }

                                                        document.getElementById("callnumber").value = responsesplitt[3];
                                                        document.getElementById("calltype").innerHTML = responsesplitt[4];
                                                        if (responsesplitt[4].match("C") == "C") {
                                                            document.getElementById("calltype").style.backgroundColor = "#FFA500";
                                                            document.getElementById("calltype").innerHTML = "Callback";
                                                        }
                                                        document.getElementById("txt_callerid").value = responsesplitt[2];
                                                        if (document.getElementById("txt_dial") !== null)
                                                            document.getElementById("txt_dial").value = document.getElementById("txt_callerid").value;
                                                        var sid = "";
                                                        sid = responsesplitt[13];
                                                        var ivrinfo = responsesplitt[6];
                                                        document.getElementById("ivrinfo").innerHTML = decodeURIComponent(ivrinfo);

                                                        fncFillDispositions(sid);
                                                        var crm = "";
                                                        if (responsesplitt[10] == "Y")
                                                            crm = responsesplitt[11];

                                                        document.getElementById("txt_lrefid").value = responsesplitt[9];
                                                        document.getElementById("servicename").innerHTML = responsesplitt[12];
                                                        var opentpcrm = document.getElementById("opentpcrm").value;

                                                        if (crm != "" && opentpcrm == 0) {
                                                            document.getElementById("opentpcrm").value = 1;

                                                            //                                    document.getElementById("txt_crm").value = crm+"?callerid="+responsesplitt[2]+"&callnumber="+responsesplitt[3]+"&transinfo="+responsesplitt[8]+"&lrefid="+responsesplitt[9]+"&lsid="+responsesplitt[12]+"&leads="+responsesplitt[13]+"&ctype="+responsesplitt[4]+"&cdnd="+cd_d;
                                                            document.getElementById("txt_crm").value = crm + "?AGENTSTATUS=" + responsesplitt[0] + "&EXTENSIONSTATUS=" + responsesplitt[1] + "&DIALEDNUMBER=" + responsesplitt[2] + "&CALLUNIQUENUMBER=" + responsesplitt[3] + "&CALLTYPE=" + responsesplitt[4] + "&ANYIVRDATA=" + responsesplitt[5] + "&IVRDATAFORCRM=" + responsesplitt[6] + "&CALLTRANSFER=" + responsesplitt[7] + "&AGENTID=" + agnno + "&CALLREFERENCEID=" + responsesplitt[9] + "&AGENTSTATUS=" + responsesplitt[10] + "&CRMURL=" + responsesplitt[11] + "&SERVICENAME=" + responsesplitt[12] + "&SERVICEID=" + responsesplitt[13] + "&STATUSSINCE=" + responsesplitt[14] + "&DIALINGMODE=" + responsesplitt[15] + "&QUEUECOUNT=" + responsesplitt[16] + "&INFOMESSAGESYSTEM=" + responsesplitt[17] + "&AGENTBLOCKSTATUS=" + responsesplitt[18] + "&DISPLAYNUMBERTOCUSTOMER =" + responsesplitt[22] + "&EXTNO=" + extno;
                                                            console.log("WRAPUP LINK URL ----" + document.getElementById("txt_crm").value);
                                                            window.parent.frame3.location.href = document.getElementById("txt_crm").value;

                                                            var ss = window.parent.frame3.document.getElementById("save");
                                                            if (ss == null) {
                                                                window.parent.frame3.location.href = document.getElementById("txt_crm").value;
                                                            }
                                                            var chk01 = window.parent.frame3.document.getElementById("autosave");
                                                            if (chk01 != null) {
                                                                window.parent.frame3.fncAutoSave();
                                                            }
                                                        }
                                                        gTime = gDuration = 0;
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[16];
                                                        //document.getElementById("srvdatetime").value = responsesplitt[20];
                                                    }
                                                    if (responsesplitt[19].match("UNBLOCK") == "UNBLOCK") {
                                                        if (document.getElementById("block") !== null)
                                                            document.getElementById("block").value = "BLOCK";
                                                        $("#block_btn_img").attr("src", "images/greenblock.png");
                                                    }
                                                    else {
                                                        document.getElementById("block").value = "UNBLOCK";
                                                        $("#block_btn_img").attr("src", "images/redblock.png");
                                                    }
                                                    var queue = responsesplitt[17];
                                                    if (queue != "") {
                                                        queue = parseInt(queue);
                                                        if (queue > 0) {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = queue;
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#FF4500";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = "";
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#2364AA";
                                                        }
                                                    }


                                                    //                            var marque = responsesplitt[18].split("111").join("\n");
                                                    var marque = "";
                                                    var actclid = document.getElementById("callerid").innerHTML;
                                                    var maskclid = document.getElementById("nocallerid").innerHTML;
                                                    marque = marque.replace(actclid, maskclid);
                                                    var msg_box = responsesplitt[18].split("111").join("<br />");

                                                    if (marque != "NA") {

                                                        var text = window.parent.frame0.document.getElementById("marquee").innerHTML;
                                                        text = text.replace("<marquee>", "").replace("</marquee>", "");
                                                        var n = marque.localeCompare(text);
                                                        if (n == "0" || msg_box == "") {
                                                            window.parent.document.getElementById("notice").style.display = "none";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("marquee").innerHTML = marque;
                                                            window.parent.document.getElementById("notice").style.display = "";
                                                            window.parent.document.getElementById("notice_alert").innerHTML = msg_box;


                                                        }
                                                    }
                                                    else {
                                                        window.parent.frame0.document.getElementById("marquee").innerHTML = "";
                                                        window.parent.document.getElementById("notice").style.display = "none";



                                                    }
                                                }
                                                else if (agentstatus.match("INCALL") == "INCALL") {
                                                    window.parent.frame0.document.getElementById("btn_Change").style.pointerEvents = "none";

                                                    disabled_all_desktop_btn();

                                                    if (document.getElementById("hangup_call_btn") !== null)
                                                        document.getElementById("hangup_call_btn").style.pointerEvents = "";

                                                    if (document.getElementById("conference_call_btn") !== null)
                                                        document.getElementById("conference_call_btn").style.pointerEvents = "";
                                                    if (agentstatus == "INCALL(CONF)") {

                                                    }
                                                    else {
                                                        if (document.getElementById("transfer_call_btn") !== null)
                                                            document.getElementById("transfer_call_btn").style.pointerEvents = "";

                                                        if (document.getElementById("btn_hold") !== null)
                                                            document.getElementById("btn_hold").style.pointerEvents = "";
                                                    }



                                                    //if(document.getElementById("close_call_btn")!==null)
                                                    //document.getElementById("close_call_btn").style.pointerEvents = "";


                                                    var currentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                                    var responsesplitt = response.split("~", 23);
                                                    var cd_dnd = responsesplitt[22];
                                                    if (currentstatus.match("INCALL") == "INCALL") {
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;

                                                        if (document.getElementById("btn") !== null)
                                                            document.getElementById("btn").value = "Break";

                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[14];
                                                        //document.getElementById("srvdatetime").value = responsesplitt[18];
                                                    }
                                                    else {
                                                        document.getElementById("agentstatus").style.backgroundColor = "#FFFF00";
                                                        document.getElementById("agentstatus").innerHTML = responsesplitt[0];
                                                        document.getElementById("extensionstatus").innerHTML = responsesplitt[1];
                                                        var hcallerid = document.getElementById("hidecallerid").value;
                                                        if (hcallerid == 'Y') {
                                                            document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                            var str = responsesplitt[2];
                                                            var n = str.replace(/.(?=.{4})/g, 'x');
                                                            document.getElementById("nocallerid").innerHTML = n;
                                                        }
                                                        else {
                                                            document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                            document.getElementById("nocallerid").innerHTML = responsesplitt[2];
                                                        }

                                                        var sid = "";
                                                        sid = responsesplitt[13];

                                                        if (srvarray.indexOf(sid) > -1) {
                                                            var str = responsesplitt[2];
                                                            var n = str.replace(/.(?=.{4})/g, 'x');
                                                            document.getElementById("nocallerid").innerHTML = n;
                                                        }
                                                        else {
                                                            document.getElementById("nocallerid").innerHTML = responsesplitt[2];
                                                        }

                                                        document.getElementById("callnumber").value = responsesplitt[3];
                                                        document.getElementById("calltype").innerHTML = responsesplitt[4];
                                                        document.getElementById("call_dnd").value = cd_dnd;
                                                        //document.getElementById("calln").value =responsesplitt[2];;
                                                        if (responsesplitt[4].match("C") == "C") {
                                                            document.getElementById("calltype").style.backgroundColor = "#FFA500";
                                                            document.getElementById("calltype").innerHTML = "Callback";
                                                        }
                                                        document.getElementById("txt_callerid").value = responsesplitt[2];

                                                        if (document.getElementById("txt_dial") !== null)
                                                            document.getElementById("txt_dial").value = document.getElementById("txt_callerid").value;

                                                        var sid = "";
                                                        sid = responsesplitt[13];
                                                        //fncFillDispositions(sid);
                                                        var crm = "";
                                                        if (responsesplitt[10] == "Y")
                                                            crm = responsesplitt[11];

                                                        document.getElementById("txt_lrefid").value = responsesplitt[9];
                                                        document.getElementById("servicename").innerHTML = responsesplitt[12];
                                                        var opentpcrm = document.getElementById("opentpcrm").value;

                                                        if (crm != "" && opentpcrm == 0) {
                                                            document.getElementById("opentpcrm").value = 1;

                                                            var ivrinfo = responsesplitt[6];
                                                            document.getElementById("ivrinfo").innerHTML = decodeURIComponent(ivrinfo);

                                                            var aalevel = document.getElementById("agentlevel").value;
                                                            //document.getElementById("txt_crm").value = crm+"?callerid="+responsesplitt[2]+"&callnumber="+responsesplitt[3]+"&transinfo="+responsesplitt[8]+"&lrefid="+responsesplitt[9]+"&lsid="+responsesplitt[12]+"&leads="+responsesplitt[13]+"&ctype="+responsesplitt[4]+"&cdnd="+cd_dnd;
                                                            document.getElementById("txt_crm").value = crm + "?AGENTSTATUS=" + responsesplitt[0] + "&EXTENSIONSTATUS=" + responsesplitt[1] + "&DIALEDNUMBER=" + responsesplitt[2] + "&CALLUNIQUENUMBER=" + responsesplitt[3] + "&CALLTYPE=" + responsesplitt[4] + "&ANYIVRDATA=" + responsesplitt[5] + "&IVRDATAFORCRM=" + responsesplitt[6] + "&CALLTRANSFER=" + responsesplitt[7] + "&AGENTID=" + agnno + "&CALLREFERENCEID=" + responsesplitt[9] + "&AGENTSTATUS=" + responsesplitt[10] + "&CRMURL=" + responsesplitt[11] + "&SERVICENAME=" + responsesplitt[12] + "&SERVICEID=" + responsesplitt[13] + "&STATUSSINCE=" + responsesplitt[14] + "&DIALINGMODE=" + responsesplitt[15] + "&QUEUECOUNT=" + responsesplitt[16] + "&INFOMESSAGESYSTEM=" + responsesplitt[17] + "&AGENTBLOCKSTATUS=" + responsesplitt[18] + "&DISPLAYNUMBERTOCUSTOMER =" + responsesplitt[22] + "&EXTNO=" + extno;
                                                            console.log("INCALL LINK URL ----" + document.getElementById("txt_crm").value);
                                                            window.parent.frame3.location.href = document.getElementById("txt_crm").value;
                                                            var chk01 = window.parent.frame3.document.getElementById("autosave");
                                                            if (chk01 != null) {
                                                                window.parent.frame3.fncAutoSave();
                                                            }
                                                        }
                                                        gTime = gDuration = 0;
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[14];
                                                        //document.getElementById("srvdatetime").value = responsesplitt[18];
                                                    }
                                                    if (responsesplitt[18].match("UNBLOCK") == "UNBLOCK") {
                                                        if (document.getElementById("block") !== null)
                                                            document.getElementById("block").value = "BLOCK";
                                                        $("#block_btn_img").attr("src", "images/greenblock.png");
                                                    }
                                                    else {
                                                        document.getElementById("block").value = "UNBLOCK";
                                                        $("#block_btn_img").attr("src", "images/redblock.png");
                                                    }
                                                    var queue = responsesplitt[16];
                                                    if (queue != "") {
                                                        queue = parseInt(queue);
                                                        if (queue > 0) {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = queue;
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#FF4500";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = "";
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#2364AA";
                                                        }
                                                    }

                                                    //                            var marque = responsesplitt[17].split("111").join("\n");
                                                    var marque = "";
                                                    var actclid = document.getElementById("callerid").innerHTML;
                                                    var maskclid = document.getElementById("nocallerid").innerHTML;
                                                    marque = marque.replace(actclid, maskclid);

                                                    var msg_box = responsesplitt[17].split("111").join("<br />");

                                                    if (marque != "NA") {
                                                        var text = window.parent.frame0.document.getElementById("marquee").innerHTML;
                                                        text = text.replace("<marquee>", "").replace("</marquee>", "");
                                                        var n = marque.localeCompare(text)
                                                        if (n == "0" || msg_box == "") {
                                                            window.parent.document.getElementById("notice").style.display = "none";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("marquee").innerHTML = marque;
                                                            window.parent.document.getElementById("notice").style.display = "";
                                                            window.parent.document.getElementById("notice_alert").innerHTML = msg_box;
                                                        }


                                                    }
                                                    else {
                                                        window.parent.frame0.document.getElementById("marquee").innerHTML = "";
                                                        window.parent.document.getElementById("notice").style.display = "none";
                                                    }



                                                }
                                                else if (agentstatus.match("RINGING") == "RINGING") {

                                                    window.parent.frame0.document.getElementById("btn_Change").style.pointerEvents = "none";
                                                    if (document.getElementById("hangup_call_btn") !== null)
                                                        document.getElementById("hangup_call_btn").style.pointerEvents = "";

                                                    var currentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                                    var responsesplitt = response.split("~", 23);
                                                    var cd_dnd = responsesplitt[22];
                                                    if (currentstatus.match("RINGING") == "RINGING") {
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[14];
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;

                                                        if (document.getElementById("btn") !== null)
                                                            document.getElementById("btn").value = "Break";

                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                        //document.getElementById("srvdatetime").value = responsesplitt[18];
                                                    }
                                                    else {
                                                        document.getElementById("agentstatus").style.backgroundColor = "#87CEEB";
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;
                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                        var hcallerid = document.getElementById("hidecallerid").value;
                                                        if (hcallerid == 'Y') {
                                                            document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                            var str = responsesplitt[2];
                                                            var n = str.replace(/.(?=.{4})/g, 'x');
                                                            document.getElementById("nocallerid").innerHTML = n;
                                                        }
                                                        else {
                                                            document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                            document.getElementById("nocallerid").innerHTML = responsesplitt[2];
                                                        }

                                                        var sid = "";
                                                        sid = responsesplitt[13];

                                                        if (srvarray.indexOf(sid) > -1) {
                                                            var str = responsesplitt[2];
                                                            var n = str.replace(/.(?=.{4})/g, 'x');
                                                            document.getElementById("nocallerid").innerHTML = n;
                                                        }
                                                        else {
                                                            document.getElementById("nocallerid").innerHTML = responsesplitt[2];
                                                        }

                                                        document.getElementById("callnumber").value = responsesplitt[3];
                                                        document.getElementById("calltype").innerHTML = responsesplitt[4];
                                                        document.getElementById("call_dnd").value = cd_dnd;
                                                        if (responsesplitt[4].match("C") == "C") {
                                                            document.getElementById("calltype").style.backgroundColor = "#FFA500";
                                                            document.getElementById("calltype").innerHTML = "Callback";
                                                        }
                                                        //document.getElementById("srvdatetime").value = responsesplitt[18];
                                                        var sid = "";
                                                        sid = responsesplitt[13];
                                                        var ivrinfo = responsesplitt[6];
                                                        document.getElementById("ivrinfo").innerHTML = decodeURIComponent(ivrinfo);
                                                        //fncFillDispositions(sid);
                                                        var crm = "";
                                                        if (responsesplitt[10] == "Y")
                                                            crm = responsesplitt[11];

                                                        document.getElementById("servicename").innerHTML = responsesplitt[12];
                                                        var opentpcrm = document.getElementById("opentpcrm").value;

                                                        if (crm != "" && opentpcrm == 0) {
                                                            document.getElementById("opentpcrm").value = 1;

                                                            var aalevel = document.getElementById("agentlevel").value;
                                                            //document.getElementById("txt_crm").value = crm+"?callerid="+responsesplitt[2]+"&callnumber="+responsesplitt[3]+"&transinfo="+responsesplitt[8]+"&lrefid="+responsesplitt[9]+"&lsid="+responsesplitt[12]+"&leads="+responsesplitt[13]+"&ctype="+responsesplitt[4]+"&cdnd="+cd_dnd;
                                                            document.getElementById("txt_crm").value = crm + "?AGENTSTATUS=" + responsesplitt[0] + "&EXTENSIONSTATUS=" + responsesplitt[1] + "&DIALEDNUMBER=" + responsesplitt[2] + "&CALLUNIQUENUMBER=" + responsesplitt[3] + "&CALLTYPE=" + responsesplitt[4] + "&ANYIVRDATA=" + responsesplitt[5] + "&IVRDATAFORCRM=" + responsesplitt[6] + "&CALLTRANSFER=" + responsesplitt[7] + "&AGENTID=" + agnno + "&CALLREFERENCEID=" + responsesplitt[9] + "&AGENTSTATUS=" + responsesplitt[10] + "&CRMURL=" + responsesplitt[11] + "&SERVICENAME=" + responsesplitt[12] + "&SERVICEID=" + responsesplitt[13] + "&STATUSSINCE=" + responsesplitt[14] + "&DIALINGMODE=" + responsesplitt[15] + "&QUEUECOUNT=" + responsesplitt[16] + "&INFOMESSAGESYSTEM=" + responsesplitt[17] + "&AGENTBLOCKSTATUS=" + responsesplitt[18] + "&DISPLAYNUMBERTOCUSTOMER =" + responsesplitt[22] + "&EXTNO=" + extno;
                                                            console.log("RINGING LINK URL ----" + document.getElementById("txt_crm").value);
                                                            window.parent.frame3.location.href = document.getElementById("txt_crm").value;
                                                            var chk01 = window.parent.frame3.document.getElementById("autosave");
                                                            if (chk01 != null) {
                                                                window.parent.frame3.fncAutoSave();
                                                            }
                                                        }
                                                        gTime = gDuration = 0;
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[14];
                                                    }
                                                    if (responsesplitt[18].match("UNBLOCK") == "UNBLOCK") {
                                                        if (document.getElementById("block") !== null)
                                                            document.getElementById("block").value = "BLOCK";
                                                        $("#block_btn_img").attr("src", "images/greenblock.png");
                                                    }
                                                    else {
                                                        document.getElementById("block").value = "UNBLOCK";
                                                        $("#block_btn_img").attr("src", "images/redblock.png");
                                                    }
                                                    var queue = responsesplitt[16];
                                                    if (queue != "") {
                                                        queue = parseInt(queue);
                                                        if (queue > 0) {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = queue;
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#FF4500";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = "";
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#2364AA";
                                                        }
                                                    }

                                                    //                            var marque = responsesplitt[17].split("111").join("\n");
                                                    var marque = "";
                                                    var actclid = document.getElementById("callerid").innerHTML;
                                                    var maskclid = document.getElementById("nocallerid").innerHTML;
                                                    marque = marque.replace(actclid, maskclid);

                                                    var msg_box = responsesplitt[17].split("111").join("<br />");

                                                    if (marque != "NA") {
                                                        var text = window.parent.frame0.document.getElementById("marquee").innerHTML;
                                                        text = text.replace("<marquee>", "").replace("</marquee>", "");
                                                        var n = marque.localeCompare(text);
                                                        if (n == "0" || msg_box == "") {
                                                            window.parent.document.getElementById("notice").style.display = "none";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("marquee").innerHTML = marque;
                                                            window.parent.document.getElementById("notice").style.display = "";
                                                            window.parent.document.getElementById("notice_alert").innerHTML = msg_box;
                                                        }


                                                    }
                                                    else {
                                                        window.parent.frame0.document.getElementById("marquee").innerHTML = "";
                                                        window.parent.document.getElementById("notice").style.display = "none";

                                                    }



                                                }
                                                else if (agentstatus.match("DIALING") == "DIALING") {
                                                    window.parent.frame0.document.getElementById("btn_Change").style.pointerEvents = "none";
                                                    var currentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                                    var responsesplitt = response.split("~", 23);
                                                    var cd_dnd = responsesplitt[22];
                                                    if (document.getElementById("hangup_call_btn") !== null)
                                                        document.getElementById("hangup_call_btn").style.pointerEvents = "";

                                                    if (currentstatus.match("DIALING") == "DIALING") {
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[14];
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;

                                                        if (document.getElementById("btn") !== null)
                                                            document.getElementById("btn").value = "Break";

                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                        document.getElementById("callnumber").value = responsesplitt[3];
                                                    }
                                                    else {
                                                        document.getElementById("agentstatus").style.backgroundColor = "#87CEEB";
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;
                                                        document.getElementById("extensionstatus").innerHTML = extstatus;

                                                        var hcallerid = document.getElementById("hidecallerid").value;
                                                        if (hcallerid == 'Y') {
                                                            document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                            var str = responsesplitt[2];
                                                            var n = str.replace(/.(?=.{4})/g, 'x');
                                                            document.getElementById("nocallerid").innerHTML = n;
                                                        }
                                                        else {
                                                            document.getElementById("callerid").innerHTML = responsesplitt[2];
                                                            document.getElementById("nocallerid").innerHTML = responsesplitt[2];
                                                        }

                                                        var sid = "";
                                                        sid = responsesplitt[13];

                                                        if (srvarray.indexOf(sid) > -1) {
                                                            var str = responsesplitt[2];
                                                            var n = str.replace(/.(?=.{4})/g, 'x');
                                                            document.getElementById("nocallerid").innerHTML = n;
                                                        }
                                                        else {
                                                            document.getElementById("nocallerid").innerHTML = responsesplitt[2];
                                                        }

                                                        document.getElementById("callnumber").value = responsesplitt[3];
                                                        document.getElementById("calltype").innerHTML = responsesplitt[4];
                                                        document.getElementById("call_dnd").value = cd_dnd;
                                                        if (responsesplitt[4].match("C") == "C") {
                                                            document.getElementById("calltype").style.backgroundColor = "#FFA500";
                                                            document.getElementById("calltype").innerHTML = "Callback";
                                                        }
                                                        var sid = "";
                                                        sid = responsesplitt[13];
                                                        var ivrinfo = responsesplitt[6];
                                                        document.getElementById("ivrinfo").innerHTML = decodeURIComponent(ivrinfo);

                                                        fncFillDispositions(sid);
                                                        var crm = "";
                                                        if (responsesplitt[10] == "Y")
                                                            crm = responsesplitt[11];

                                                        document.getElementById("servicename").innerHTML = responsesplitt[12];
                                                        var opentpcrm = document.getElementById("opentpcrm").value;

                                                        if (crm != "" && opentpcrm == 0) {
                                                            //                                    document.getElementById("txt_crm").value = crm+"?callerid="+responsesplitt[2]+"&callnumber="+responsesplitt[3]+"&transinfo="+responsesplitt[8]+"&lrefid="+responsesplitt[9]+"&lsid="+responsesplitt[12]+"&leads="+responsesplitt[13]+"&ctype="+responsesplitt[4]+"&cdnd="+cd_dnd;
                                                            document.getElementById("txt_crm").value = crm + "?AGENTSTATUS=" + responsesplitt[0] + "&EXTENSIONSTATUS=" + responsesplitt[1] + "&DIALEDNUMBER=" + responsesplitt[2] + "&CALLUNIQUENUMBER=" + responsesplitt[3] + "&CALLTYPE=" + responsesplitt[4] + "&ANYIVRDATA=" + responsesplitt[5] + "&IVRDATAFORCRM=" + responsesplitt[6] + "&CALLTRANSFER=" + responsesplitt[7] + "&AGENTID=" + agnno + "&CALLREFERENCEID=" + responsesplitt[9] + "&AGENTSTATUS=" + responsesplitt[10] + "&CRMURL=" + responsesplitt[11] + "&SERVICENAME=" + responsesplitt[12] + "&SERVICEID=" + responsesplitt[13] + "&STATUSSINCE=" + responsesplitt[14] + "&DIALINGMODE=" + responsesplitt[15] + "&QUEUECOUNT=" + responsesplitt[16] + "&INFOMESSAGESYSTEM=" + responsesplitt[17] + "&AGENTBLOCKSTATUS=" + responsesplitt[18] + "&DISPLAYNUMBERTOCUSTOMER =" + responsesplitt[22] + "&EXTNO=" + extno;
                                                            console.log("DIALING LINK URL ----" + document.getElementById("txt_crm").value);
                                                            window.parent.frame3.location.href = document.getElementById("txt_crm").value;
                                                            document.getElementById("opentpcrm").value = 1;

                                                        }
                                                        gTime = gDuration = 0;
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[14];
                                                        document.getElementById("srvdatetime").value = responsesplitt[18];
                                                    }
                                                    if (responsesplitt[18].match("UNBLOCK") == "UNBLOCK") {
                                                        if (document.getElementById("block") !== null)
                                                            document.getElementById("block").value = "BLOCK";
                                                        $("#block_btn_img").attr("src", "images/greenblock.png");
                                                    }
                                                    else {
                                                        document.getElementById("block").value = "UNBLOCK";
                                                        $("#block_btn_img").attr("src", "images/redblock.png");
                                                    }
                                                    var queue = responsesplitt[16];
                                                    if (queue != "") {
                                                        queue = parseInt(queue);
                                                        if (queue > 0) {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = queue;
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#FF4500";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = "";
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#2364AA";
                                                        }
                                                    }

                                                    //var marque = responsesplitt[17].split("111").join("\n");
                                                    var marque = "";
                                                    var actclid = document.getElementById("callerid").innerHTML;
                                                    var maskclid = document.getElementById("nocallerid").innerHTML;
                                                    marque = marque.replace(actclid, maskclid);

                                                    var msg_box = responsesplitt[17].split("111").join("<br />");

                                                    if (marque != "NA") {
                                                        var text = window.parent.frame0.document.getElementById("marquee").innerHTML;

                                                        text = text.replace("<marquee>", "").replace("</marquee>", "");
                                                        var n = marque.localeCompare(text);
                                                        if (n == "0" || msg_box == "") {
                                                            window.parent.document.getElementById("notice").style.display = "none";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("marquee").innerHTML = marque;
                                                            window.parent.document.getElementById("notice").style.display = "";
                                                            window.parent.document.getElementById("notice_alert").innerHTML = msg_box;
                                                        }


                                                    }
                                                    else {
                                                        window.parent.frame0.document.getElementById("marquee").innerHTML = "";
                                                        window.parent.document.getElementById("notice").style.display = "none";

                                                    }



                                                }
                                                else if (agentstatus.match("RESERVED") == "RESERVED") {
                                                    var currentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                                    if (currentstatus.match("RESERVED") == "RESERVED") {
                                                        document.getElementById("statusSince").innerHTML = getTimer(nTime, nDuration, gTime, gDuration);
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;

                                                        if (document.getElementById("btn") !== null)
                                                            document.getElementById("btn").value = "Break";

                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                    }
                                                    else {
                                                        document.getElementById("agentstatus").style.backgroundColor = "#E9967A";
                                                        document.getElementById("agentstatus").innerHTML = agentstatus;
                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                        gTime = gDuration = 0;
                                                        document.getElementById("statusSince").innerHTML = getTimer(nTime, nDuration, gTime, gDuration);
                                                    }
                                                }
                                                else if (agentstatus.match("BREAK") == "BREAK") {
                                                    window.parent.frame0.document.getElementById("btn_Change").style.pointerEvents = "none";
                                                    window.parent.frame2.disable_menu();
                                                    disabled_all_desktop_btn();

                                                    if (document.getElementById("break_call_btn") !== null)
                                                        document.getElementById("break_call_btn").style.pointerEvents = "";

                                                    var currentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                                    document.getElementById("btn").value = "Unbreak";
                                                    var responsesplitt = response.split("~", 7);
                                                    var btype = responsesplitt[6];
                                                    if (currentstatus.match("BREAK") == "BREAK") {
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[2];
                                                        document.getElementById("agentstatus").innerHTML = agentstatus + " (" + btype + ")";
                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                    }
                                                    else {

                                                        document.getElementById("agentstatus").style.backgroundColor = "#FF0000";
                                                        document.getElementById("agentstatus").innerHTML = agentstatus + " (" + btype + ")";
                                                        document.getElementById("extensionstatus").innerHTML = extstatus;
                                                        window.parent.frame3.location.href = "idle.jsp?typeee=agent";
                                                        gTime = gDuration = 0;
                                                        document.getElementById("statusSince").innerHTML = responsesplitt[2];
                                                    }
                                                    if (responsesplitt[5].match("UNBLOCK") == "UNBLOCK") {
                                                        if (document.getElementById("block") !== null)
                                                            document.getElementById("block").value = "BLOCK";
                                                        $("#block_btn_img").attr("src", "images/greenblock.png");
                                                    }
                                                    else {
                                                        document.getElementById("block").value = "UNBLOCK";
                                                        $("#block_btn_img").attr("src", "images/redblock.png");
                                                    }
                                                    var queue = responsesplitt[3];
                                                    //alert(responsesplitt[3]);
                                                    if (queue != "") {
                                                        queue = parseInt(queue);
                                                        if (queue > 0) {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = queue;
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#FF4500";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("qcount").innerHTML = "";
                                                            window.parent.frame0.document.getElementById("qcount").style.backgroundColor = "#2364AA";
                                                        }
                                                    }

                                                    var marque = responsesplitt[4].split("111").join("\n");
                                                    var msg_box = responsesplitt[4].split("111").join("<br />");


                                                    if (marque != "NA") {
                                                        var text = window.parent.frame0.document.getElementById("marquee").innerHTML;
                                                        text = text.replace("<marquee>", "").replace("</marquee>", "");
                                                        var n = marque.localeCompare(text);
                                                        if (n == "0" || msg_box == "") {
                                                            window.parent.document.getElementById("notice").style.display = "none";
                                                        }
                                                        else {
                                                            window.parent.frame0.document.getElementById("marquee").innerHTML = "<marquee>" + marque + "</marquee>";
                                                            window.parent.document.getElementById("notice").style.display = "";
                                                            window.parent.document.getElementById("notice_alert").innerHTML = msg_box;


                                                        }
                                                    }
                                                    else {
                                                        window.parent.frame0.document.getElementById("marquee").innerHTML = "";
                                                        window.parent.document.getElementById("notice").style.display = "none";



                                                    }
                                                }
                                                else {
                                                    if (response == "Session Expired") {
                                                        //alert(response);
                                                        window.parent.location.href = "index.jsp";
                                                    }
                                                    else {
                                                        gTime = gDuration = 0;
                                                        clearTimeout(timer);
                                                        clearTimeout(timer1);
                                                        //alert(response);
                                                        //alert("Login Again");
                                                        window.parent.frame0.document.getElementById("btn_logout").value = "Login again";
                                                        window.parent.frame3.location.href = "idle_1.jsp?typeee=agent";
                                                        window.parent.frame0.document.getElementById("marquee").innerHTML = "<b>Login Again</b>";
                                                        window.parent.document.getElementById("notice").style.display = "";
                                                        window.parent.document.getElementById("notice_alert").innerHTML = marque;



                                                        document.getElementById("agentstatus").style.backgroundColor = "#FFFFFF";
                                                        document.getElementById("agentstatus").innerHTML = "IDLE";
                                                        document.getElementById("extensionstatus").innerHTML = "IDLE";
                                                        window.parent.location.href = "index.jsp";
                                                    }
                                                }
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=checkStatus", true);
                                        xmlhttp.send();
                                        timer = setTimeout("getStatus();", 2000);
                                    }
                                    function fncXfer() {
                                        var agentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                        var typee = document.getElementById("pattern").value;
                                        var exten = "";
                                        if (typee == "Service") {
                                            exten = document.getElementById("service").value;
                                        }
                                        else if (typee == "Agent") {
                                            exten = document.getElementById("agent").value;
                                        }
                                        else if (typee == "Extention") {
                                            exten = document.getElementById("xexten").value;
                                        }
                                        else {
                                            alert("Invalid Request.");
                                            return;
                                        }
                                        var remarks = "";
                                        // var chk = window.parent.frame3.document.getElementById("remarks")
                                        // if(chk != null)
                                        //   remarks = window.parent.frame3.document.getElementById("remarks").value;

                                        if (exten == "") {
                                            alert("Invalid Request.");
                                            return;
                                        }
                                        if (remarks == "") {
                                            remarks = "Call Transferred"
                                        }
                                        if (agentstatus.match("INCALL") == "INCALL") {

                                            var xmlhttp = null;
                                            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                                xmlhttp = new XMLHttpRequest();
                                            }
                                            else {// code for IE6, IE5
                                                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                            }
                                            xmlhttp.onreadystatechange = function () {
                                                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                    var response = xmlhttp.responseText;
                                                    alert(response);
                                                    //document.getElementById("tnxto").value=exten;
                                                }
                                            }
                                            xmlhttp.open("GET", "Getstatus?type=transferCall&extension=" + exten + "&remarks=" + remarks, true);
                                            xmlhttp.send();
                                        }
                                        else {
                                            alert("Agent is not Incall");
                                            return;
                                        }
                                    }
                                    function fncHangup() {
                                        var agentstatus = document.getElementById("agentstatus").innerHTML.toString();
                                        if (agentstatus.match("INCALL") == "INCALL" || agentstatus.match("DIALING") == "DIALING" || agentstatus.match("RINGING") == "RINGING") {
                                            var xmlhttp = null;
                                            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                                xmlhttp = new XMLHttpRequest();
                                            }
                                            else {// code for IE6, IE5
                                                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                            }
                                            xmlhttp.onreadystatechange = function () {
                                                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                    var response = xmlhttp.responseText;
                                                    //alert(response);
                                                }
                                            }
                                            xmlhttp.open("GET", "Getstatus?type=hangupCall", true);
                                            xmlhttp.send();
                                        }
                                    }
                                    function abc(autoval) {
                                        //alert("1");
                                        var chk00 = "";
                                        try {
                                            chk00 = window.parent.frame3.document.getElementById("save");
                                        }
                                        catch (err) {
                                            console.log('Error -- ' + err);
                                        }
                                        //alert("2");
                                        if (chk00 != null && chk00 != "") {

                                            if (autoval == "autowrap") {
                                                window.parent.frame3.fncSave('autowrap');
                                            }
                                            else {
                                                $(".dis", parent.document).slideToggle('slow');
                                                // window.parent.frame3.fncSave('');
                                            }
                                        }
                                        else if (chk00 == "") {
                                            $(".dis", parent.document).slideToggle('slow');
                                        }
                                        else {

                                            alert("Please click on Current Call Before Closing");
                                            //fncClose();
                                        }
                                    }



                                    function fncClose() {
                                        var autowrap = document.getElementById("txt_autowrap").value;
                                        var disposition = "";
                                        var disposition1 = "";
                                        if (autowrap == "autowrap") {
                                            disposition = document.getElementById("txt_autodisp").value;
                                            document.getElementById("txt_autowrap").value = "";
                                            document.getElementById("txt_autodisp").value = "";
                                        }
                                        else {
                                            disposition1 = window.parent.document.getElementById("final_disp_code").value;
                                            disposition = window.parent.document.getElementById("cti_disp_code").value;
                                        }
                                        //alert("status"+disposition+"ssst"+disposition1);
                                        //return;
                                        var cbkdate = document.getElementById("demo1").value;

                                        if (disposition.match("0156") == "0156" || disposition.match("CBF") == "CBF" || disposition.match("CBK") == "CBK" || disposition.match("0154") == "0154") {
                                            if (cbkdate == "") {
                                                alert("Please select callback time");
                                                return;
                                            }
                                            var d1 = new Date();
                                            //var d1 = document.getElementById("srvdatetime").value;
                                            d1 = d1.getTime();
                                            var d2 = new Date(cbkdate);
                                            d2 = d2.getTime();
                                            if (d1 > d2) {
                                                alert("Invalid callback time");
                                                return;
                                            }
                                        }

                                        var callnumber = document.getElementById("callnumber").value;
                                        var leads = document.getElementById("serviceref").value;
                                        var leadno = document.getElementById("txt_lrefid").value;
                                        var agnid = document.getElementById("txt_agnid").value;
                                        var remarks = document.getElementById("remarkss").value;
                                        //alert(remarks);
                                        cbkdate = cbkdate.replace("/", "-");
                                        cbkdate = cbkdate.replace("/", "-");
                                        //alert(cbkdate);
                                        var val;
                                        if (document.getElementById("btn_conf") !== null) {
                                            val = document.getElementById("btn_conf").value;
                                            document.getElementById("btn_conf").value = "Conference Call";
                                        }



                                        if (val == "Connect") {
                                            //fncCloseConference();
                                        }
                                        if (document.getElementById("conf_num") !== null)
                                            document.getElementById("conf_num").value = "";

                                        // document.getElementById("btn_conf").value = "Conference Call";
                                        if (disposition == "") {
                                            alert("Please select disposition .........................");
                                            return;
                                        }
                                        if (callnumber == "") {
                                            alert("Callnumber not found");
                                            return;
                                        }
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                document.getElementById("disposition").value = "";
                                                if (autowrap != "autowrap") { }
                                                //alert("disp"+response);
                                            }
                                        }
                                        //disposition = disposition.split("~",2);
                                        var f_sub_disp = window.parent.document.getElementById("sub_disp_name").value;
                                        var f_sub_sub_disp = window.parent.document.getElementById("sub_sub_disp_name").value;
                                        var disp_name = window.parent.document.getElementById("disp_name").value;

                                        var main_disp = window.parent.document.getElementById("first_code").value;
                                        var sub_disp_code = window.parent.document.getElementById("sub_disp_code").value;
                                        var final_disp_name = window.parent.document.getElementById("final_disp_name").value;
                                        if (autowrap == "autowrap") {
                                            disp_name = disposition;
                                            final_disp_name = disposition;
                                        }
                                        var param1 = "";
                                        var value = "";
                                        if (disp_name != "" && f_sub_disp == "" && f_sub_sub_disp == "") {
                                            param1 = "disp_level1";
                                            value = disp_name.trim();
                                        }
                                        else if (disp_name != "" && f_sub_disp != "" && f_sub_sub_disp == "") {
                                            param1 = "disp_level2";
                                            value = disp_name.trim() + "%5E" + f_sub_disp.trim();
                                        }
                                        else if (disp_name != "" && f_sub_disp != "" && f_sub_sub_disp != "") {
                                            param1 = "disp_level3";
                                            value = disp_name.trim() + "%5E" + f_sub_disp.trim() + "%5E" + f_sub_sub_disp.trim();
                                        }
                                        else {
                                            param1 = "disp_level1";
                                            value = disp_name;
                                        }
                                        fncsetcallmastervalue(agnid, param1, value, leadno, leads, callnumber);
                                        //alert("disposition =="+disposition+"------"+"main_dispstn_code =="+disp_name+"----------"+"sub_dispstn_code =="+final_disp_name);
                                        //alert(main_disp+","+disp_name);
                                        //return;
                                        //xmlhttp.open("GET","Getstatus?type=closeCall&disposition="+disposition[0]+"&callnumber="+callnumber+"&remarks="+remarks+"&cbkdate="+cbkdate,true);
                                        xmlhttp.open("GET", "Getstatus?type=closeCall&disposition=" + disposition.split('$')[0] + "&callnumber=" + callnumber + "&remarks=" + remarks + "&cbkdate=" + cbkdate + "&main_dispstn_code=" + disp_name + "&sub_dispstn_code=" + final_disp_name, true);
                                        //reqtype=closecall&user=karvy1&final_dispstn_code=LEDON&calluniqueno=12345&remarks=test&cbkdate=2017-07-24 13:46:53&main_dispstn_code=CT&sub_dispstn_code=INTR&final_submisn=false&host=203.199.211.219
                                        xmlhttp.send();
                                    }


                                    function abc2() {
                                        var btn = "save";
                                        var chk00 = window.parent.frame3.document.getElementById(btn);
                                        if (chk00 != null) {
                                            window.parent.frame3.fncSave('closendial');
                                        }
                                        else {
                                            fncCloseNDial();
                                        }
                                    }
                                    function fncCloseNDial() {
                                        var num = document.getElementById("txt_dial").value;
                                        if (num == "") {
                                            alert("Please enter number to dial");
                                            return;
                                        }
                                        var lrefid = document.getElementById("txt_lrefid").value;
                                        if (lrefid == "") {
                                            alert("lrefid is missing");
                                            return;
                                        }
                                        var disposition = "REDIAL";
                                        //disposition =  document.getElementById("disposition").value;
                                        var dialindex = document.getElementById("dialindex").value;
                                        var callnumber = document.getElementById("callnumber").value;
                                        var remarks = "abc";
                                        var chk = window.parent.frame3.document.getElementById("remarks")
                                        if (chk != null)
                                            remarks = window.parent.frame3.document.getElementById("remarks").value;


                                        if (disposition == "") {
                                            alert("Please select disposition");
                                            return;
                                        }
                                        if (callnumber == "") {
                                            alert("Callnumber not found");
                                            return;
                                        }
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                document.getElementById("disposition").value = "";
                                                alert(response);
                                                window.parent.frame3.location.href = "idle.jsp?typeee=agent";
                                            }
                                        }
                                        disposition = disposition.split("~", 2);
                                        xmlhttp.open("GET", "Getstatus?type=closendial&disposition=" + disposition[0] + "&callnumber=" + callnumber + "&remarks=" + remarks + "&cbkdate=&num=" + num + "&lrefid=" + lrefid + "&dialindex=" + dialindex, true);
                                        xmlhttp.send();
                                    }
                                    function fncCloseNDial1(num1) {
                                        var num = num1;
                                        //alert(num);
                                        if (num == "") {
                                            alert("Please enter number to dial");
                                            return;
                                        }
                                        var lrefid = document.getElementById("txt_lrefid").value;
                                        //alert(lrefid);
                                        if (lrefid == "") {
                                            alert("lrefid is missing");
                                            return;
                                        }
                                        var disposition = "REDIAL";
                                        //disposition =  document.getElementById("disposition").value;
                                        var dialindex = document.getElementById("dialindex").value;
                                        var callnumber = document.getElementById("callnumber").value;
                                        var remarks = "abc";
                                        var chk = window.parent.frame3.document.getElementById("remarks")
                                        if (chk != null)
                                            remarks = window.parent.frame3.document.getElementById("remarks").value;


                                        if (disposition == "") {
                                            alert("Please select disposition");
                                            return;
                                        }
                                        if (callnumber == "") {
                                            alert("Callnumber not found");
                                            return;
                                        }
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                document.getElementById("disposition").value = "";
                                                alert(response);
                                                window.parent.frame3.location.href = "idle.jsp?typeee=agent";
                                            }
                                        }
                                        disposition = disposition.split("~", 2);
                                        xmlhttp.open("GET", "Getstatus?type=closendial&disposition=" + disposition[0] + "&callnumber=" + callnumber + "&remarks=" + remarks + "&cbkdate=&num=" + num + "&lrefid=" + lrefid + "&dialindex=" + dialindex, true);
                                        xmlhttp.send();
                                    }
                                    function fncBreak() {
                                        var status = document.getElementById("agentstatus").innerHTML;
                                        //alert(status);
                                        /*if(status != "IDLE" && status != "BREAK")
                                        {
                                            return;
                                        }*/
                                        //alert(status);
                                        var val = document.getElementById("btn").value;
                                        var val1 = document.getElementById("break").value;
                                        if (val1 == "" && val != "Unbreak") {
                                            alert("Please enter Break type");
                                            document.drop_list.val1.focus();
                                            return;
                                        }
                                        var req = "break_start";
                                        var break_flag = 0;
                                        if (val == "Unbreak") {
                                            var check_break = window.parent.verify_pass('<%= session.getAttribute("password") %>');

                                            if (check_break === true) {
                                                req = "break_end";
                                                break_flag = 0;


                                            }
                                            else {
                                                break_flag = 1;
                                            }
                                        }
                                        else {
                                            req = "break_start";
                                        }

                                        if (break_flag === 0) {
                                            var xmlhttp = null;
                                            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                                xmlhttp = new XMLHttpRequest();
                                            }
                                            else {// code for IE6, IE5
                                                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                            }
                                            xmlhttp.onreadystatechange = function () {
                                                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                    var response = xmlhttp.responseText;
                                                    if (response.match("START") == "START")

                                                        document.getElementById("btn").value = "Unbreak";
                                                    else if (response.match("END") == "END") {
                                                        if (document.getElementById("btn") !== null)
                                                            document.getElementById("btn").value = "Break";
                                                    }
                                                    else
                                                        alert(response);
                                                }
                                            }
                                            xmlhttp.open("GET", "Getstatus?type=break&reqtype=" + req + "&reqtype1=" + val1, true);
                                            xmlhttp.send();
                                            break_flag = 0;
                                        }
                                    }
                                    function fncLogout() {
                                        var req = "logout";
                                        var btnVal = window.parent.frame0.document.getElementById("btn_logout").value;
                                        if (btnVal == "Login again") {
                                            req = "login";
                                        }

                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                if (req == "login") {
                                                    window.location.reload();
                                                }
                                                else {
                                                    if (response.match("SUCCESS") == "SUCCESS")
                                                        window.parent.location.href = "index.jsp";
                                                }
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=" + req, true);
                                        xmlhttp.send();
                                    }
                                    function fncBridge() {
                                        var status = document.getElementById("extensionstatus").innerHTML;
                                        //alert(status);
                                        if (status != "TALK") {
                                            alert("Agent Not On Talk");
                                            //return;
                                        }
                                        req = "Bridge";

                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                alert(response);
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=bridge&reqtype=" + req, true);
                                        xmlhttp.send();
                                    }
                                    function fncHold() {
                                        var status = document.getElementById("extensionstatus").innerHTML;
                                        var astatus = document.getElementById("agentstatus").innerHTML;
                                        if (status != "TALK") {
                                            alert("Agent Not On Talk");
                                            return;
                                        }
                                        var req = "hold_start";
                                        if (astatus == "INCALL") {
                                            $("#interchange").attr('src', 'images/pause.png');
                                            req = "hold_start";
                                        }
                                        else {
                                            req = "hold_stop";
                                            $("#interchange").attr('src', 'images/play.gif');

                                        }

                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                alert(response);
                                                if (response.match("START") == "START")
                                                    document.getElementById("btn_hold").value = "Unhold";
                                                else if (response.match("END") == "END")
                                                    document.getElementById("btn_hold").value = "Hold";
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=hold&reqtype=" + req, true);
                                        xmlhttp.send();
                                    }
                                    function fncMute() {
                                        var status = document.getElementById("extensionstatus").innerHTML;
                                        //alert(status);
                                        if (status != "TALK") {
                                            alert("Agent Not On Talk");
                                            return;
                                        }
                                        var val = document.getElementById("btn_mute").value;
                                        var req = "mute_start";
                                        if (val == "mute") {
                                            req = "mute_stop";
                                            $("#mute_btn_img").attr('src', 'images/unmute.png');

                                        }
                                        else {
                                            $("#mute_btn_img").attr('src', 'images/mute.png');
                                            req = "mute_start";
                                        }

                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                alert(response);
                                                if (response.match("START") == "START")
                                                    document.getElementById("btn_mute").value = "unmute";
                                                else if (response.match("END") == "END")
                                                    document.getElementById("btn_mute").value = "mute";
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=mute&reqtype=" + req, true);
                                        xmlhttp.send();
                                    }

                                    function fncConference(val) {
                                        //var val = document.getElementById("btn_conf").value;
                                        var num = document.getElementById("conf_num").value;
                                        if (num == "") {
                                            if (val == "Initiate Conference") {
                                                alert("Please enter number for conference");
                                                return;
                                            }
                                            else {
                                                num = "9250740685"
                                            }
                                        }

                                        //alert(val);
                                        if (val == "Initiate Conference") {
                                            var req = "conf";
                                        }
                                        else if (val == "Add Conference") {
                                            req = "conf2";
                                        }
                                        else if (val == "Enter Conference") {
                                            req = "conf3";
                                        }
                                        //alert(req);
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                if (response.match("SUCCESS") == "SUCCESS") {
                                                    //if(val == "Conference Call")
                                                    //{
                                                    //    document.getElementById("btn_conf").value = "Connect";
                                                    //}
                                                    //else if(val == "Connect")
                                                    //{
                                                    //    document.getElementById("btn_conf").value = "Conference2";
                                                    //}
                                                    //else
                                                    //{
                                                    //    document.getElementById("btn_conf").value = "Connect";
                                                    //}
                                                }
                                                else {
                                                    alert(response);
                                                }
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=conference&reqtype=" + req + "&num=" + num, true);
                                        xmlhttp.send();
                                    }
                                    function fncKeypad(param) {
                                        var val = document.getElementById("txt_dial").value;
                                        val += param;
                                        document.getElementById("txt_dial").value = val;
                                    }
                                    function fncShow(id) {
                                        var a = ['tbl_trans', 'tbl_conf', 'tbl_dial', 'tbl_1'];
                                        var val = document.getElementById(id).style.display;
                                        var i = 0;
                                        for (i = 0; i < a.length; i++) {
                                            if (a[i] !== val) {
                                                if (document.getElementById(a[i]) !== null)
                                                    document.getElementById(a[i]).style.display = "none";
                                            }
                                        }

                                        //alert(val);
                                        //document.getElementsByClassName('.wind').display=none;
                                        if (val === "none") {
                                            document.getElementById(id).style.display = "";
                                        }
                                        else {
                                            document.getElementById(id).style.display = "none";
                                        }


                                    }
                                    function fncDial() {
                                        document.getElementById("tbl_dial").display = "none";
                                        $("#tbl_dial").hide();
                                        var status = document.getElementById("agentstatus").innerHTML;
                                        if (status != "IDLE") {
                                            //    return;
                                        }
                                        var num = document.getElementById("txt_dial").value;
                                        var serv = document.getElementById("serviceref").value;
                                        //alert(num);
                                        var lead = document.getElementById("ref_lead").value;
                                        var batchid = document.getElementById("ref_ref_id").value;
                                        var batchname = document.getElementById("ref_ref_name").value;
                                        //alert(ref_lead);
                                        //alert(ref_ref_id);
                                        //alert(ref_ref_name);
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                if (response.indexOf("Failed") !== -1) {
                                                    alert(response);
                                                }
                                                //alert(response);
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=mDial&num=" + num + "&refid=" + lead + "&batchname=" + batchname + "&batchid=" + batchid + "&sid=" + serv, true);
                                        xmlhttp.send();

                                    }

                                    function fncDialM(lid) {
                                        var status = document.getElementById("agentstatus").innerHTML;
                                        if (status != "IDLE") {
                                            //    return;
                                        }
                                        var num = lid;
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                //alert(response);
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=mDial&num=" + num, true);
                                        xmlhttp.send();
                                    }
                                    function fncRef() {
                                        var num = document.getElementById("txt_dial").value;
                                        var serviceref = document.getElementById("serviceref").value;
                                        //alert(serviceref);

                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                //alert(response);
                                                if (response.match("failed") != "failed" && response.match("Exception") != "Exception") {
                                                    //alert("swap"+response);
                                                    var split = response.split("||", 3);

                                                    document.getElementById("ref_lead").value = split[0];
                                                    document.getElementById("ref_ref_name").value = split[1];
                                                    document.getElementById("ref_ref_id").value = split[2];
                                                    fncDial();

                                                }
                                            }
                                        }
                                        //alert("kk");
                                        xmlhttp.open("GET", "Getstatus?type=getCrmRef&num=" + num + "&serviceref=" + serviceref, true);
                                        xmlhttp.send();
                                    }
                                    function fncDialMan(number, sid) {
                                        var num = number;
                                        var serviceref = sid;
                                        //alert(serviceref);

                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                //alert(response);
                                                if (response.match("failed") != "failed" && response.match("Exception") != "Exception") {
                                                    //alert("swap"+response);
                                                    var split = response.split("||", 3);

                                                    document.getElementById("ref_lead").value = split[0];
                                                    document.getElementById("ref_ref_name").value = split[1];
                                                    document.getElementById("ref_ref_id").value = split[2];
                                                    fnccallmanual(split[0], number, serviceref, split[1], split[2])

                                                }
                                            }
                                        }
                                        //alert("kk");
                                        xmlhttp.open("GET", "Getstatus?type=getCrmRef&num=" + num + "&serviceref=" + serviceref, true);
                                        xmlhttp.send();
                                    }
                                    function fncCloseConference() {
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                if (response.match("SUCCESS") == "SUCCESS")
                                                    document.getElementById("btn_conf").value = "Connect";
                                                else
                                                    alert(response);
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=closeConference&reqtype=", true);
                                        xmlhttp.send();
                                    }
                                    function fncFillDispositions(sid) {

                                        var agentlevel = document.getElementById("agentlevel").value;
                                        console.log("fncFillDispositions -- " + agentlevel);
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {
                                            // code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                var disp_text = "";
                                                var split1 = response.split("-")[1];
                                                //alert(count);
                                                //document.getElementById('disposition').options.length = 0;
                                                //addOption(document.drop_list.disposition,"Select","");
                                                var split2 = split1.split("||");

                                                for (var i = 0; i < (split2.length) - 1; i++) {
                                                    // var split3 = split2[i].split("$",2);
                                                    var split3 = split2[i].split("~");

                                                    disp_text += "<div id='" + i + "' class='dis_data' onclick='disp_show_hide(\"" + split3[0] + "\",\"" + split3[1] + "\");' ><b>" + split3[0] + "</b></div>";
                                                    addOption(document.drop_list.disposition, split3[1], split3[0]);
                                                }
                                                window.parent.document.getElementById("disp_text").innerHTML = disp_text;
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=fillDispositions&sid=" + sid + "&agentlevel=" + agentlevel, true);
                                        xmlhttp.send();
                                    }
                                    // Changes Done vy Vikas Varshney
                                    function fncFillBreaks(id) {
                                        var sid = document.getElementById('serviceref').value;
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {
                                            // code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                document.getElementById('break').options.length = 0;
                                                var split1 = response.split("-")[1];
                                                var split2 = split1.split("||");
                                                addOption(document.drop_list.break, "Select", "");
                                                for (var i = 0; i < (split2.length) - 1; i++) {
                                                    addOption(document.drop_list.break, split2[i], split2[i]);
                                                }
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=fillBreaks", true);
                                        xmlhttp.send();
                                    }



                                    function addOption(selectbox, text, value) {
                                        //alert(value);
                                        var optn = document.createElement("OPTION");
                                        //alert(optn);
                                        optn.text = text;
                                        optn.value = value;
                                        selectbox.options.add(optn);
                                    }
                                    function fncVisible() {

                                        var disposition = document.getElementById("disposition").value;
                                        if (disposition.match("0156") == "0156" || disposition.match("0154") == "0154") {
                                            /* document.getElementById("tdcbk").style.display = "";
                                             document.getElementById("demo1").style.display = "";
                                              document.getElementById("calLink").style.display = "";  */
                                        }
                                        else {
                                            /*  document.getElementById("tdcbk").style.display = "none";
                                              document.getElementById("demo1").style.display = "none";
                                              document.getElementById("calLink").style.display = "none";  */
                                        }
                                    }
                                    function fncBlock() {
                                        var val = document.getElementById("block").value;
                                        var req = "block_start";
                                        if (val == "BLOCK") {
                                            req = "block_start";
                                            $("#block_btn_img").attr("src", "images/redblock.png");
                                        }
                                        else {
                                            req = "block_end";
                                            $("#block_btn_img").attr("src", "images/greenblock.png");
                                        }

                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                if (response.match("START") == "START") {
                                                    if (document.getElementById("block") !== null)
                                                        document.getElementById("block").value = "UNBLOCK";
                                                }
                                                else if (response.match("END") == "END") {
                                                    if (document.getElementById("block") !== null)
                                                        document.getElementById("block").value = "BLOCK";
                                                }
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=block&reqtype=" + req, true);
                                        xmlhttp.send();
                                    }
                                    function fncSetcmfeild(param1, param2) {
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                //
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=setcmfield&reqtype=setcmfield&fn=" + param1 + "&fv=" + param2, true);
                                        xmlhttp.send();
                                    }
                                    function fncSetremarks(param) {
                                        //alert("2");
                                        document.getElementById("remarkss").value = param;
                                    }
                                    function fncNumbers(param1, param2) {
                                        document.getElementById("txt_dial").value = param2;
                                        document.getElementById("dialindex").value = param1;
                                    }
                                    function Check(val) {
                                        var level = document.getElementById('pattern').value;
                                        //alert(level);
                                        if (level.match("Service") == "Service") {
                                            //alert("1");
                                            document.getElementById('a').style.display = 'block';
                                            document.getElementById('service').style.display = 'block';
                                            document.getElementById('b').style.display = 'none';
                                            document.getElementById('agent').style.display = 'none';
                                            document.getElementById('c').style.display = 'none';
                                            document.getElementById('xexten').style.display = 'none';
                                            document.getElementById('transfer').style.display = 'block';
                                            //element.style.display='block';
                                        }
                                        //else 
                                        // {
                                        // document.getElementById('a').style.display='none';
                                        // document.getElementById('service').style.display='none';
                                        // }
                                        else if (level.match("Agent") == "Agent") {
                                            //alert("2");
                                            document.getElementById('a').style.display = 'block';
                                            document.getElementById('service').style.display = 'block';
                                            document.getElementById('b').style.display = 'block';
                                            document.getElementById('agent').style.display = 'block';
                                            document.getElementById('c').style.display = 'none';
                                            document.getElementById('xexten').style.display = 'none';
                                            document.getElementById('transfer').style.display = 'block';
                                            //element.style.display='block';
                                        }
                                        else if (level.match("Extention") == "Extention") {
                                            //alert("3");
                                            document.getElementById('c').style.display = 'block';
                                            document.getElementById('xexten').style.display = 'block';
                                            document.getElementById('transfer').style.display = 'block';
                                            document.getElementById('a').style.display = 'none';
                                            document.getElementById('service').style.display = 'none';
                                            document.getElementById('b').style.display = 'none';
                                            document.getElementById('agent').style.display = 'none';
                                            //document.getElementById('agent').style.display='block';
                                            //element.style.display='block';
                                        }
                                        else {
                                            document.getElementById('a').style.display = 'none';
                                            document.getElementById('service').style.display = 'none';
                                            document.getElementById('b').style.display = 'none';
                                            document.getElementById('agent').style.display = 'none';
                                            document.getElementById('transfer').style.display = 'none';
                                        }
                                    }
                                    function fillcity() {
                                        var state = document.getElementById("service").value;
                                        //alert(state);
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                var split = response.split("-", 2);
                                                var count = split[0];
                                                //alert(response);
                                                document.getElementById('agent').options.length = 0;
                                                addOption1(document.drop_list.agent, "Select", "");
                                                var split2 = split[1].split("||", count);
                                                //alert(split2);
                                                for (var i = 0; i < split2.length; i++) {
                                                    var split3 = split2[i].split("#", 2);
                                                    addOption1(document.drop_list.agent, split3[0], split3[1]);
                                                }
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=fillcity&state=" + state, true);
                                        xmlhttp.send();
                                    }
                                    function addOption1(selectbox, text, value) {
                                        //alert(value);
                                        var optn = document.createElement("OPTION");
                                        //alert(optn);
                                        optn.text = text;
                                        optn.value = value;
                                        selectbox.options.add(optn);
                                    }
                                    function FncSetIdle() {
                                        var agentid = document.getElementById("aid").innerHTML;
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=setagnidle&agentid=" + agentid.trim(), true);
                                        xmlhttp.send();
                                    }
                                    function fnccallmanual(lead, number, serv, batchname, batchid) {
                                        var status = document.getElementById("agentstatus").innerHTML;

                                        var num = number;
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                //alert(response);
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=mDial&num=" + num + "&refid=" + lead + "&batchname=" + batchname + "&batchid=" + batchid + "&sid=" + serv, true);
                                        xmlhttp.send();
                                    }
                                    function fnctnxto(agentfrom, agentto, mob) {
                                        //var status = document.getElementById("agentstatus").innerHTML;
                                        //alert("hi");
                                        //var num = number;
                                        var agnfrom = agentfrom;
                                        var agnto = agentto;
                                        var mobi = document.getElementById("calln").value;
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                //alert(response);
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=tnxto&agnfrom=" + agnfrom + "&agnto=" + agnto + "&mobi=" + mobi, true);
                                        xmlhttp.send();
                                    }
                                    function showbox() {
                                        window.parent.show_hide();
                                    }
                                    function fncsetcallmastervalue(agentid, param, value, refid, sid, callnumber) {
                                        //alert(agentid+"="+param+"="+value+"="+refid+"="+sid+"="+callnumber);
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                //alert(response);
                                            }
                                        }
                                        xmlhttp.open("GET", "Getstatus?type=setcallmastervalue&agentid=" + agentid + "&param=" + param + "&value=" + value + "&refid=" + refid + "&sid=" + sid + "&callnumber=" + callnumber, true);
                                        xmlhttp.send();
                                    }
                                    function disabled_all_desktop_btn() {

                                        if (document.getElementById("hangup_call_btn") !== null)
                                            document.getElementById("hangup_call_btn").style.pointerEvents = "none";

                                        if (document.getElementById("close_call_btn") !== null)
                                            document.getElementById("close_call_btn").style.pointerEvents = "none";

                                        if (document.getElementById("conference_call_btn") !== null)
                                            document.getElementById("conference_call_btn").style.pointerEvents = "none";

                                        if (document.getElementById("transfer_call_btn") !== null)
                                            document.getElementById("transfer_call_btn").style.pointerEvents = "none";

                                        if (document.getElementById("manual_dial_btn") !== null)
                                            document.getElementById("manual_dial_btn").style.pointerEvents = "none";

                                        if (document.getElementById("break_call_btn") !== null)
                                            document.getElementById("break_call_btn").style.pointerEvents = "none";

                                        if (document.getElementById("btn_hold") !== null)
                                            document.getElementById("btn_hold").style.pointerEvents = "none";

                                        if (document.getElementById("block") !== null)
                                            document.getElementById("block").style.pointerEvents = "none";

                                    }
                                    disabled_all_desktop_btn();


                                    function sendRequest1(requestLink) {
                                        // var confip = document.getElementById("confip").value;
                                        var confip = window.location.hostname + ":9898";
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }

                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                var response = xmlhttp.responseText;
                                                if (response == "") {
                                                }
                                                else {
                                                    alert($(response).find('STATUSDESC').text());
                                                }
                                            }
                                        };

                                        xmlhttp.open("GET", "http://" + confip + "/" + requestLink, true);
                                        xmlhttp.send();

                                    }

                                    function kickparty(user_id, room) {
                                        var link = "reqtype=kickparty&room=" + room.trim() + "&user=" + user_id.trim();
                                        //alert(link);
                                        sendRequest1(link);
                                    }
                                    function holdparty(user_id, room) {
                                        var link = "";
                                        link = "reqtype=holdparty&room=" + room.trim() + "&user=" + user_id.trim();
                                        //alert(link);
                                        sendRequest1(link);
                                    }
                                    function unholdparty(user_id, room) {
                                        var link = "";
                                        link = "reqtype=unholdparty&room=" + room.trim() + "&user=" + user_id.trim();
                                        //alert(link);
                                        sendRequest1(link);

                                    }
                                    function muteparty(user_id, room) {
                                        var link = "";
                                        link = "amicommand~meetme mute " + room.trim() + " " + user_id.trim();
                                        //alert(link);
                                        sendRequest1(link);
                                    }
                                    function unmuteparty(user_id, room) {
                                        var link = "";
                                        link = "amicommand~meetme unmute " + room.trim() + " " + user_id.trim();
                                        //alert(link);
                                        sendRequest1(link);
                                    }

                                    function sendrequest() {

                                        var agnid1 = document.getElementById("aid").innerHTML;
                                        var extension1 = document.getElementById("extennum").innerHTML;
                                        //var confip = document.getElementById("confip").value;	
                                        var confip = window.location.hostname + ":9898";
                                        var xmlhttp = null;
                                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                                            xmlhttp = new XMLHttpRequest();
                                        }
                                        else {// code for IE6, IE5
                                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                        }
                                        var extra_data = "";
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                //var response=xmlhttp.responseText;
                                                xml2 = xmlhttp.responseText;
                                                //alert(xml2);
                                                var xmlDoc = $.parseXML(xml2);
                                                var $xml = $(xmlDoc);
                                                var $room = $xml.find("ENTRY");
                                                var cid = 1;
                                                extra_data += '<tr style="background-color:#73BFB8;color:black;">'
                                                    + '<td>ROOM</td><td>CALLER#</td><td>DROP</td><td>HOLD</td><td>MUTE</td>'
                                                $room.each(function () {
                                                    var roomno = $(this).find('roomno').text();
                                                    var CALLERID = $(this).find('CALLERID').text();
                                                    var uniqueid = $(this).find('UNIQUEID').text();
                                                    var holdstatus = $(this).find('HOLDSTATUS').text();
                                                    var mutestatus = $(this).find('MUTESTATUS').text();
                                                    if (holdstatus.trim() == 'N') {
                                                        if (mutestatus.trim() == 'N') {
                                                            extra_data += '<tr style="background-color:green;">'
                                                                + '<td >' + roomno + '</td>'
                                                                + '<td >' + CALLERID + '</td>'
                                                                + '<td > <a href="#" style="color:white;" onclick="kickparty(\'' + uniqueid + '\',\'' + roomno + '\')"> Drop </a> </td>'
                                                                + '<td > <a href="#" style="color:white;" onclick="holdparty(\'' + uniqueid + '\',\'' + roomno + '\')"> Hold </a> </td>'
                                                                + '<td > <a href="#" style="color:white;" onclick="muteparty(\'' + uniqueid + '\',\'' + roomno + '\')"> Mute </a> </td>'
                                                                + '</tr>';
                                                            cid = cid + 1;
                                                        }
                                                        else {
                                                            extra_data += '<tr style="background-color:green;">'
                                                                + '<td >' + roomno + '</td>'
                                                                + '<td >' + CALLERID + '</td>'
                                                                + '<td > <a href="#" style="color:white;" onclick="kickparty(\'' + uniqueid + '\',\'' + roomno + '\')"> Drop </a> </td>'
                                                                + '<td > <a href="#" style="color:white;" onclick="holdparty(\'' + uniqueid + '\',\'' + roomno + '\')"> Hold </a> </td>'
                                                                + '<td > <a href="#" style="color:white;" onclick="unmuteparty(\'' + uniqueid + '\',\'' + roomno + '\')"> UnMute </a> </td>'
                                                                + '</tr>';
                                                            cid = cid + 1;
                                                        }
                                                    }
                                                    else {
                                                        if (mutestatus.trim() == 'N') {
                                                            extra_data += '<tr style="background-color:orange;">'
                                                                + '<td style="color:black;" >' + roomno + '</td>'
                                                                + '<td style="color:black;" >' + CALLERID + '</td>'
                                                                + '<td > <a href="#" style="color:black;" onclick="kickparty(\'' + uniqueid + '\',\'' + roomno + '\')"> Drop </a> </td>'
                                                                + '<td > <a href="#" style="color:black;" onclick="unholdparty(\'' + uniqueid + '\',\'' + roomno + '\')"> UnHold </a> </td>'
                                                                + '<td > <a href="#" style="color:black;" onclick="muteparty(\'' + uniqueid + '\',\'' + roomno + '\')"> Mute </a> </td>'
                                                                + '</tr>';
                                                            cid = cid + 1;
                                                        }
                                                        else {
                                                            extra_data += '<tr style="background-color:orange;">'
                                                                + '<td style="color:black;" >' + roomno + '</td>'
                                                                + '<td style="color:black;" >' + CALLERID + '</td>'
                                                                + '<td > <a href="#" style="color:black;" onclick="kickparty(\'' + uniqueid + '\',\'' + roomno + '\')"> Drop </a> </td>'
                                                                + '<td > <a href="#" style="color:black;" onclick="unholdparty(\'' + uniqueid + '\',\'' + roomno + '\')"> UnHold </a> </td>'
                                                                + '<td > <a href="#" style="color:black;" onclick="unmuteparty(\'' + uniqueid + '\',\'' + roomno + '\')"> UnMute </a> </td>'
                                                                + '</tr>';
                                                            cid = cid + 1;
                                                        }
                                                    }
                                                });

                                            }

                                            //alert(extra_data);
                                            document.getElementById("table1").innerHTML = extra_data;
                                        };
                                        //alert("here");
                                        xmlhttp.open("GET", "http://" + confip + "/reqtype=confroomstatus&agentid=" + agnid1.trim() + "&extension=" + extension1.trim(), true);
                                        //est-reqtype=confroomstatus
                                        xmlhttp.send();
                                        timer1 = setTimeout("sendrequest();", 5000);
                                    }

                                </script>
                                <form action="status.jsp" method="POST" name="drop_list">
                                    <div class="logo"
                                        style="height:auto;width:100%;margin:0px;padding:0px;border:none;box-shadow:1px 1px 1px grey;background-color:#2364AA;">
                                        <img src="img/sap.png" style="height:1%;width:52.8%;margin-left:3%"
                                            title="Sampark" />

                                    </div>
                                    <input type='text' style='display:none' id='ref_lead'>
                                    <input type='text' style='display:none' id='ref_ref_id'>
                                    <input type='text' style='display:none' id='ref_ref_name'>
                                    <input type='text' style='display:none' id='call_dnd'>
                                    <input type='text' style='display:none' id='tnxto'>
                                    <input type='text' style='display:none' id='calln'>
                                    <input type='text' style='display:none' id='callerid'>
                                    <div id="agentmain" class="agent">
                                        <div class="agent_details">
                                            <div class="heading">Agent ID &nbsp;:</div>
                                            <div id="aid" class="heading_data">
                                                <%=session.getAttribute("agentid") %>
                                            </div>
                                        </div>
                                        <div id="aidmain1" class="agent_details">
                                            <div class="heading">Extension &nbsp;:</div>
                                            <div class="heading_data" id="extennum">
                                                <%=session.getAttribute("extension") %>
                                            </div>
                                        </div>
                                        <div class="agent_details">
                                            <div class="heading">Agent Status &nbsp;:</div>
                                            <div class="heading_data" id="agentstatus"> </div>
                                        </div>
                                        <div id="aidmain2" class="agent_details">
                                            <div class="heading">Exten Status &nbsp;:</div>
                                            <div class="heading_data" id="extensionstatus"></div>
                                        </div>
                                        <div id="aidmain3" class="agent_details">
                                            <div class="heading">Status Since &nbsp;:</div>
                                            <div id="statusSince" class="heading_data"> </div>
                                        </div>
                                        <div id="aidmain4" class="agent_details">
                                            <div class="heading">Caller ID &nbsp;:</div>
                                            <div id="nocallerid" class="heading_data"> </div>
                                        </div>
                                        <div id="aidmain5" class="agent_details">
                                            <div class="heading">Call Type &nbsp;:</div>
                                            <div id="calltype" class="heading_data"> </div>
                                        </div>
                                        <div id="aidmain6" class="agent_details">
                                            <div class="heading">Service Name &nbsp;:</div>
                                            <div id="servicename" class="heading_data"> </div>
                                        </div>
                                        <div id="aidmain7" class="agent_details">
                                            <div class="heading">Info &nbsp;:</div>
                                            <div id="ivrinfo" class="heading_data"> </div>
                                        </div>
                                        <div class="agent_details" style="display:none">
                                            <div class="heading">Disposition &nbsp;:</div>
                                            <div class="heading_data">
                                                <div id="new_disposition" class="btn_design"
                                                    style="width:90%;height:auto;color:black;margin-left:9%;"
                                                    onclick="showbox()"> Select Disposition</div>
                                                <select style="width:90%;display:none;" id='disposition'
                                                    onchange="fncVisible();">
                                                    <option>Select</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="agent_details" id="tdcbk" style="display:none">
                                            <div class="heading" style="display:none">Date&Time &nbsp;:</div>
                                            <div class="heading_data" style="display:none">

                                                <input type="text" id="demo1" readonly maxlength="28" size="18" />
                                                <a id="calLink" href="javascript:NewCal('demo1','yyyymmdd',true,24)">
                                                    <img src="images/cal.gif" width="16" height="16" border="0"
                                                        alt="Pick a date"></a>


                                            </div>
                                        </div>

                                        <div class="main_call">

                                            <% // String sql="SELECT id,enable FROM tbl_desktop_menu" ; String
                                                sql="SELECT a_hangup_enable,a_closecall_enable,a_conference_enable,a_transfer_enable,a_manual_enable,a_break_enable,a_hold_enable,a_block_enable FROM tbl_agent_master where a_login_id='"
                                                +session.getAttribute("agentid")+"'"; System.out.println(sql);
                                                Connection conn23=config2.getconnection(); Statement
                                                statement23=conn23.createStatement(); ResultSet
                                                resultset23=statement23.executeQuery(sql); String menu_auth;
                                                while(resultset23.next()) { //String
                                                menu_id=resultset23.getString("id");
                                                menu_auth=resultset23.getString("a_hangup_enable");
                                                if(menu_auth.equalsIgnoreCase("Y")) { %>
                                                <!------------------------------------------------: Desktop Menu 1:-------------------------------------------------------  --->
                                                <div id="hangup_call_btn" class="side_btn"
                                                    onclick="javascript:fncHangup()" title="Hangup Call"
                                                    style="box-shadow:none;">
                                                    <div style="box-shadow:none;float:left;display: block;"><img
                                                            src="images/hangup.png"
                                                            style="box-shadow:none;height:43px;width:43px;" /></div>
                                                    <div
                                                        style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                        Hangup Call</div>
                                                </div>
                                                <!-------------------------------------------------------------------------------------------------------  --->


                                                <% } menu_auth=resultset23.getString("a_closecall_enable");
                                                    if(menu_auth.equalsIgnoreCase("Y")) { %>


                                                    <!------------------------------------------------: Desktop Menu 2:-------------------------------------------------------  --->


                                                    <div id="close_call_btn" class="side_btn"
                                                        onclick="javascript:abc('')" title="Dispose Call"
                                                        style="box-shadow:none;">
                                                        <div style="box-shadow:none;float:left;display: block;"> <img
                                                                src="images/wrapup2.png"
                                                                style="box-shadow:none;height:43px;width:43px" /></div>
                                                        <div
                                                            style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                            Dispose Call</div>
                                                    </div>


                                                    <% } menu_auth=resultset23.getString("a_conference_enable");
                                                        if(menu_auth.equalsIgnoreCase("Y")) { %>

                                                        <!------------------------------------------------: Desktop Menu 3:-------------------------------------------------------  --->

                                                        <div id="conference_call_btn" class="side_btn"
                                                            onclick="javascript:fncShow('tbl_conf')"
                                                            title="Conference call" style="box-shadow:none;">
                                                            <div style="box-shadow:none;float:left;display: block;"><img
                                                                    src="images/conference.png"
                                                                    style="height:43px;width:43px" /></div>
                                                            <div
                                                                style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                                ConferenceCall</div>
                                                        </div>




                                                        <% } menu_auth=resultset23.getString("a_transfer_enable");
                                                            if(menu_auth.equalsIgnoreCase("Y")) { %>

                                                            <!------------------------------------------------: Desktop Menu 4:-------------------------------------------------------  --->
                                                            <div id="transfer_call_btn" class="side_btn"
                                                                onclick="javascript:fncShow('tbl_trans')"
                                                                title="Transfer Call" style="box-shadow:none;">
                                                                <div style="box-shadow:none;float:left;display: block;">
                                                                    <img src="images/transfer.png"
                                                                        style="height:43px;width:43px" /></div>
                                                                <div
                                                                    style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                                    Transfer Call</div>
                                                            </div>
                                                            <div class="wind" id="tbl_trans" style="display:none">
                                                                <div class="win-border"
                                                                    style="background-color:midnightblue;width:100%;height:13%;color:white;float:left;">
                                                                    <div id="win-title"
                                                                        style="width:100%;text-align:left;float:left;background-color:#2364AA;">
                                                                        Transfer Call</div>

                                                                </div>
                                                                <div
                                                                    style="height:98%;width:100%;background-color:white;text-align: center;">
                                                                    <table>
                                                                        <tr>
                                                                            <td style="width:70px;color:black;">Type:
                                                                            </td>
                                                                            <td>
                                                                                <select style="width:190px;height:25px"
                                                                                    name='pattern'
                                                                                    onchange='Check(this.value)'
                                                                                    id='pattern'>
                                                                                    <option value=''>Select</option>
                                                                                    <option value='Service'>Service
                                                                                    </option>
                                                                                    <option value='Agent'>Agent</option>
                                                                                    <option value='Extention'>Extention
                                                                                    </option>
                                                                                </select>

                                                                            </td>
                                                                            <!--<td><input type="number" name="xexten" id="xexten" placeholder="Extension" style="width: 100%"></td>-->
                                                                        </tr>
                                                                        <% String output="" ; output+="<tr>" +"<td
                                                                            style='display:none;color:black;' id='a'>
                                                                            Service</td>"
                                                                            +"<td><select id='service'
                                                                                    style='display:none;width:190px;height:25px'
                                                                                    onchange='javascript:fillcity();'>";
                                                                                    Connection conn =
                                                                                    config2.getconnection();
                                                                                    Statement statement =
                                                                                    conn.createStatement();
                                                                                    resultset
                                                                                    =statement.executeQuery("select case
                                                                                    when srv_from_dni1 = '49861255' then
                                                                                    '700' when srv_from_dni1 =
                                                                                    '10000000' then '800' else
                                                                                    srv_from_dni1 end as
                                                                                    srv_from_dni1,srv_name from
                                                                                    tbl_service_master where srv_enabled
                                                                                    = 'Y'");
                                                                                    output+="<option id='citysel'>Select
                                                                                    </option>";
                                                                                    while(resultset.next())
                                                                                    {
                                                                                    output+="<option
                                                                                        value="+resultset.getString("
                                                                                        srv_from_dni1")+">
                                                                                        "+resultset.getString("srv_name")+"
                                                                                    </option>";
                                                                                    }
                                                                                    output+="</select></td>";
                                                                            //conn.close();
                                                                            output+="</tr>";
                                                                            output+="<tr>"
                                                                                +"<td style='display:none;color:black;'
                                                                                    id='b'>Agent:</td>"
                                                                                +"<td><select id='agent'
                                                                                        style='display:none;width:190px;height:25px'>";
                                                                                        //Connection conn =
                                                                                        config2.getconnection();
                                                                                        //Statement statement =
                                                                                        conn.createStatement();
                                                                                        resultset
                                                                                        =statement.executeQuery("select
                                                                                        as_agent_id from
                                                                                        tbl_agent_service_mapping where
                                                                                        1=2") ;
                                                                                        output+="<option id='ssssss'>
                                                                                            Select</option>";
                                                                                        while(resultset.next())
                                                                                        {
                                                                                        output+="<option
                                                                                            value="+resultset.getString("
                                                                                            as_agent_id")+">
                                                                                            "+resultset.getString("as_agent_id")+"
                                                                                        </option>";
                                                                                        }
                                                                                        output+="</select></td>";
                                                                                conn.close();
                                                                                output+="</tr>";
                                                                            out.println(output);
                                                                            %>
                                                                            <tr>
                                                                                <td style='display:none;color:black;'
                                                                                    id='c'>Transfer:</td>
                                                                                <td><input type="number" name="xexten"
                                                                                        id="xexten"
                                                                                        placeholder="Extension"
                                                                                        style="display:none;width:190px;height:20px">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td></td>
                                                                                <td><input class="btn_design"
                                                                                        type="button" id="transfer"
                                                                                        onclick="javascript:fncXfer()"
                                                                                        value="Transfer Call"
                                                                                        style="display:none;width:100%">
                                                                                </td>
                                                                            </tr>
                                                                    </table>
                                                                </div>

                                                            </div>

                                                            <!------------------------------------------------------------------------------------------------------  --->



                                                            <!-------------------------------------------------------------------------------------------------------  --->


                                                            <% } menu_auth=resultset23.getString("a_manual_enable");
                                                                if(menu_auth.equalsIgnoreCase("Y") ) { %>

                                                                <!------------------------------------------------: Desktop Menu 5:-------------------------------------------------------  --->



                                                                <div id="manual_dial_btn" class="side_btn"
                                                                    onclick="javascript:fncShow('tbl_dial')"
                                                                    title="Manual Call" style="box-shadow:none;">
                                                                    <div
                                                                        style="box-shadow:none;float:left;display: block;">
                                                                        <img src="images/manualdial.png"
                                                                            style="height:43px;width:43px;" /></div>
                                                                    <div
                                                                        style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                                        Manual Call</div>
                                                                </div>
                                                                <div class="wind" id="tbl_dial" style="display:none">
                                                                    <div class="win-border"
                                                                        style="background-color:midnightblue;width:100%;height:13%;color:white;float:left;">
                                                                        <div id="win-title"
                                                                            style="width:100%;text-align:left;float:left;background-color:green;">
                                                                            Manual Call</div>

                                                                    </div>
                                                                    <div
                                                                        style="height:98%;width:100%;background-color:white;">

                                                                        <center>


                                                                            <!------------------------------------------------------------- : New Dial Pad :--------------------------------------------- --->


                                                                            <div class="number"
                                                                                style="box-shadow:none;">
                                                                                <input type="number" id="txt_dial"
                                                                                    style="width:96%;margin:1%;" />
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('1')">
                                                                                    1
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('2')">
                                                                                    2
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('3')">
                                                                                    3
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('4')">
                                                                                    4
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('5')">
                                                                                    5
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('6')">
                                                                                    6
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('7')">
                                                                                    7
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('8')">
                                                                                    8
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('9')">
                                                                                    9
                                                                                </div>
                                                                                <div class="num" id="dialing11"
                                                                                    style="background: linear-gradient(lightgreen,green, lightgreen);color:white;"
                                                                                    onclick="javascript:fncRef()">
                                                                                    Dial
                                                                                </div>
                                                                                <div class="num"
                                                                                    onclick="javascript:fncKeypad('0')">
                                                                                    0
                                                                                </div>
                                                                                <div class="num c_d"
                                                                                    style="background: linear-gradient(firebrick,red, firebrick);color:white;"
                                                                                    onclick="javascript:abc2()"
                                                                                    title="Close & Dial">
                                                                                    Cl & D
                                                                                </div>
                                                                            </div>






                                                                            <!-------------------------------------------------------------------------------------------------------------------------- ---->

                                                                            <!--   : OLD DIALPAD:--****
                                 <table>
                                <tr>
                                    <td colspan="3"><input type="number" id="txt_dial" style="width:100%"></td>
                                    <td><input type="button" onclick="javascript:fncDial()" style="width:100%" value="Dial"></td>
                                    
                                </tr>
                                <tr>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('1')" value="1"></td>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('2')" value="2"></td>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('3')" value="3"></td>
                                    <td>
                                        <input type="button" onclick="javascript:abc2()" value="Close&DialAgain" style="width:100%;display:none;">
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('4')" value="4"></td>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('5')" value="5"></td>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('6')" value="6"></td>
                                </tr>
                                <tr>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('7')" value="7"></td>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('8')" value="8"></td>
                                    <td><input type="button" style="width:100%" onclick="javascript:fncKeypad('9')" value="9"></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><input class="btn_design" type="button" style="width:100%" onclick="javascript:fncKeypad('0')" value="0"></td>
                                </tr>
                            </table>    --->
                                                                        </center>
                                                                    </div>
                                                                </div>
                                                                <!-------------------------------------------------------------------------------------------------------  --->

                                                                <% } menu_auth=resultset23.getString("a_break_enable");
                                                                    if(menu_auth.equalsIgnoreCase("Y")) { %>



                                                                    <!------------------------------------------------: Desktop Menu 6:-------------------------------------------------------  --->


                                                                    <div id="break_call_btn" class="side_btn"
                                                                        onclick="javascript:fncShow('tbl_1')"
                                                                        title='Break' style="box-shadow:none;">
                                                                        <div
                                                                            style="box-shadow:none;float:left;display: block;">
                                                                            <img src="images/break.png"
                                                                                style="height:43px;width:43x" /></div>
                                                                        <div
                                                                            style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                                            Break Call</div>
                                                                    </div>
                                                                    <div class="wind" id="tbl_1" style="display:none">
                                                                        <div class="win-border"
                                                                            style="background-color:midnightblue;width:100%;height:13%;color:white;float:left;">
                                                                            <div class="win-title"
                                                                                style="width:100%;text-align:left;float:left;background-color:#2364AA;">
                                                                                Break </div>

                                                                        </div>
                                                                        <div
                                                                            style="height:98%;width:100%;background-color:white;color:black;">
                                                                            <table align="center">
                                                                                <tr>
                                                                                    <td style="width:70px"
                                                                                        title="Break">Break</td>
                                                                                    <td>
                                                                                        <select
                                                                                            style="width:190px;height:25px"
                                                                                            name='break' id='break'>
                                                                                            <!--option value=''>Select</option>
                                            <option value='Lunch'>Lunch</option>
                                            <option value='Tea'>Tea</option>
                                            <option value='After Call'>After Call</option>
                                            <option value='Meeting'>Meeting</option>
                                            <option value='Other'>Other</option-->
                                                                                        </select>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr align="center">
                                                                                    <td></td>
                                                                                    <td><input class="btn_design"
                                                                                            type="button"
                                                                                            onclick="javascript:fncBreak()"
                                                                                            id="btn" value="Break"
                                                                                            style="width:100%"></td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </div>

                                                                    <!-------------------------------------------------------------------------------------------------------  --->
                                                                    <% } menu_auth=resultset23.getString("a_hold_enable");
                                                                        if(menu_auth.equalsIgnoreCase("Y")) { %>


                                                                        <!------------------------------------------------: Desktop Menu 7:-------------------------------------------------------  --->

                                                                        <div class="side_btn" id="btn_hold"
                                                                            onclick="javascript:fncHold()"
                                                                            title="Hold/Unhold Call"
                                                                            style="box-shadow:none;">
                                                                            <div
                                                                                style="box-shadow:none;float:left;display: block;">
                                                                                <img id="interchange"
                                                                                    src="images/play.gif"
                                                                                    style="height:43px;width:43px" />
                                                                            </div>
                                                                            <div
                                                                                style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                                                Hold Call</div>
                                                                        </div>





                                                                        <% } menu_auth=resultset23.getString("a_block_enable");
                                                                            if(menu_auth.equalsIgnoreCase("Y")) { %>

                                                                            <!------------------------------------------------: Desktop Menu 8:-------------------------------------------------------  --->
                                                                            <div class="side_btn" id="block"
                                                                                onclick="javascript:fncBlock()"
                                                                                title="Block/Unblock"
                                                                                style="box-shadow:none;">
                                                                                <div
                                                                                    style="box-shadow:none;float:left;display: block;">
                                                                                    <img id="block_btn_img"
                                                                                        src="images/greenblock.png"
                                                                                        style="height:43px;width:43px" />
                                                                                </div>
                                                                                <div
                                                                                    style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                                                    Auto Call</div>
                                                                            </div>


                                                                            <% } } //while close resultset23.close();
                                                                                conn23.close(); %>
                                                                                <div class="side_btn" id="mute"
                                                                                    onclick="javascript:fncMute()"
                                                                                    title="Mute/Unmute"
                                                                                    style="display:none;box-shadow:none;">
                                                                                    <div
                                                                                        style="box-shadow:none;float:left;display: block;">
                                                                                        <img id="mute_btn_img"
                                                                                            src="images/unmute.png"
                                                                                            style="height:43px;width:43px" />
                                                                                    </div>
                                                                                    <div
                                                                                        style="box-shadow:none;height:5px;width:70px;float:left;color:black;font-size:10px;display:block;">
                                                                                        Mice</div>
                                                                                </div>
                                                                                <div class="wind1" id="tbl_conf"
                                                                                    style="display:none">
                                                                                    <div class="win-border"
                                                                                        style="background-color:midnightblue;width:100%;height:28%;color:white;float:left;">
                                                                                        <div id="win-title"
                                                                                            style="width:100%;text-align:left;float:left;background-color:green;">
                                                                                            Conference-Panel</div>

                                                                                    </div>
                                                                                    <div
                                                                                        style="height:98%;width:100%;background-color:white;text-align: center;color:black;">

                                                                                        <table align="center">
                                                                                            <tr>







                                                                                                <td colspan="1">
                                                                                                    Conference:</td>


                                                                                                <td colspan="2"><input
                                                                                                        type="number"
                                                                                                        id="conf_num"
                                                                                                        maxlength="10"
                                                                                                        style="width:100%">
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                        <table align="center">
                                                                                            <tr>
                                                                                                <td>
                                                                                                <td colspan="1"><input
                                                                                                        class="btn_design1"
                                                                                                        type="button"
                                                                                                        id="btn_conf"
                                                                                                        onclick="javascript:fncConference('Initiate Conference')"
                                                                                                        value="Call">
                                                                                                </td>
                                                                                                </td>
                                                                                                <td>
                                                                                                <td colspan="1"><input
                                                                                                        class="btn_design1"
                                                                                                        type="button"
                                                                                                        id="btn_conf2"
                                                                                                        onclick="javascript:fncConference('Add Conference')"
                                                                                                        value="Add">
                                                                                                </td>
                                                                                                </td>
                                                                                                <td>
                                                                                                <td colspan="1"><input
                                                                                                        class="btn_design1"
                                                                                                        type="button"
                                                                                                        id="btn_conf3"
                                                                                                        onclick="javascript:fncConference('Enter Conference')"
                                                                                                        value="Drop All">
                                                                                                </td>

                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </div>
                                                                                    <div class="main_call1">
                                                                                        <table id="table1" name="table1"
                                                                                            style="width:100%;padding:0px;margin-top:0px;text-align:center">
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                        </div>


                                </form>

                                <% String typeee="" ; String confip=config2.confip.toString(); String
                                    hidecallerid=config2.hidecallerid.toString(); String logoutondown="N" ;
                                    logoutondown=config2.logoutondown.toString(); out.println("<input type='hidden'
                                    id='logoutondown' name='logoutondown' value='"+logoutondown+"' />");

                                String serviceref = session.getAttribute("service").toString();
                                //String agnid ="h";
                                out.println("<input type='text' style='display:none' id='serviceref'
                                    value='"+serviceref+"'>");
                                String ipaddress = session.getAttribute("ipaddress").toString();
                                //String agnid ="h";
                                out.println("<input type='text' style='display:none' id='ipaddress'
                                    value='"+ipaddress+"'>");
                                String agentlevel = session.getAttribute("agentlevel").toString();
                                //String agnid ="h";
                                out.println("<input type='text' style='display:none' id='agentlevel'
                                    value='"+agentlevel+"'>");
                                out.println("<input type='text' style='display:none' id='confip' value='"+confip+"'>");
                                out.println("<input type='hidden' id='hidecallerid' value='"+hidecallerid+"'>");
                                out.println("<input type='hidden' id='opentpcrm' value='0'>");

                                if(request.getParameterMap().containsKey("typeee"))
                                {
                                typeee = request.getParameter("typeee");
                                //out.println(typeee);
                                out.println("<input type='text' style='display:none' id='typeee' value='"+typeee+"'>");
                                }
                                else
                                {
                                typeee = "";
                                //out.println(typeee);
                                out.println("<input type='text' style='display:none' id='typeee' value='"+typeee+"'>");

                                }
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("callnumber")+"' id='callnumber'>");
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("callerid")+"' id='txt_callerid'>");
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("crmurl")+"' id='txt_crm'>");
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("lrefid")+"' id='txt_lrefid'>");
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("mins")+"' id='txt_mins'>");
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("disp")+"' id='txt_disp'>");
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("agentid")+"' id='txt_agnid'>");
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("extension")+"' id='txt_ex'>");
                                out.println("<input type='text' style='display:none' value='' id='txt_autowrap'>");
                                out.println("<input type='text' style='display:none' value='' id='txt_autodisp'>");
                                out.println("<input type='text' style='display:none' value='' id='remarkss'>");
                                out.println("<input type='text' style='display:none' value='1' id='dialindex'>");
                                out.println("<input type='text' style='display:none' value='unmute' id='btn_mute'>");
                                out.println("<input type='text' style='display:none'
                                    value='"+session.getAttribute("srvdatetime")+"' id='srvdatetime'>");

                                %>
                                <script src="js/jquery.corner.js">
                                    //    $('.side_btn').corner("round 50%"); 



                                </script>
                                <script type="text/javascript">


                                    $('#txt_dial').keypress(function (e) {
                                        if (e.which === 13)
                                            $('#dialing11').click();
                                    });


                                </script>
                            </body>

                            </html>
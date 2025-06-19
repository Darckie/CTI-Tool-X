<%-- Document : calldetails Created on : Mar 12, 2016, 4:46:35 PM Author : ishaan --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@page import="java.sql.*" %>
            <%@page import="mypack.config2" %>
                <%@page import="java.util.*" %>
                    <%@page import="java.text.*" %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                            <title>JSP Page</title>
                            <script language="javascript">
                                function fncDial(lead, sid, number, batch_id, batch_name) {
                                    //alert(lead+'-------'+sid+'---------'+number+'---------'+lid+'-------'+batch_id+'----------'+batch_name);
                                    var status = window.parent.document.getElementById("agentstatus").innerHTML;
                                    if (status.match("Idle") == "Idle" || status.match("IDLE") == "IDLE") {

                                    } else {
                                        alert("Call Not Allowed");
                                        return;
                                    }
                                    window.parent.fnccallmanual(lead, number, sid, batch_name, batch_id);
                                }

                                function filter_hide() {
                                    $("#filter_content").toggle();
                                    (($("#head-sign").html().includes("+")) ? $("#head-sign").html("[-]") : $("#head-sign").html("[+]"));

                                }
                            </script>
                            <style>
                                @font-face {
                                    font-family: myfont;
                                    src: url(OpenSans-Regular.ttf);
                                }

                                body {
                                    font-family: myfont;
                                    font-size: 13px;
                                }

                                table {
                                    width: 100%;
                                    border-collapse: collapse;
                                }

                                /* Zebra striping */
                                tr:nth-of-type(odd) {
                                    background: #eee;
                                }

                                th {
                                    background: #2364AA;
                                    color: white;
                                    font-weight: bold;
                                }

                                td,
                                th {
                                    padding: 6px;
                                    border: 1px solid #ccc;
                                    text-align: left;
                                }
                            </style>
                        </head>

                        <body>
                            <form action="calldetails.jsp" method="get">
                                <!--<input type="submit" name="btn" value="Show All"/>-->
                            </form>
                            <table style="width:100%">
                                <tr colspan="9">
                                    <marquee width='100%' behavior='alternate' style="color:midnightblue;"
                                        bgcolor='#eee'>
                                        <b>
                                            <font style="color:#2364AA;">Call Details</font>
                                        </b>
                                    </marquee>
                                </tr>
                                <tr>
                                    <th>ACTION</th>
                                    <th>CALL DATE</th>
                                    <th>Customer Name</th>
                                    <th>PHONE</th>
                                    <th>CALL TYPE</th>
                                    <th>AGENT ID</th>
                                    <th>EXTEN</th>
                                    <th>SERVICE</th>
                                    <th>DISPOSITION</th>
                                    <th>SUBDISP</th>
                                </tr>
                                <%! String getTable(String name) { Calendar currentDate=Calendar.getInstance();
                                    SimpleDateFormat formatter=new SimpleDateFormat("yyyy_MM_dd"); String
                                    dateNow=formatter.format(currentDate.getTime()); return "cdr." + name + "_" +
                                    dateNow; } %>
                                    <% String typeee="" ; String hidecallerid=config2.hidecallerid.toString(); try {
                                        String aid=session.getAttribute("agentid").toString(); String
                                        sid=session.getAttribute("service").toString(); String
                                        tableName=getTable("tbl_call_master"); String output="" ; String crmTable="" ;
                                        String
                                        tablesql="SELECT crm_table_name FROM asterisk.tbl_service_crm where crm_id='" +
                                        sid + "'" ; Connection conn=config2.getconnection(); if (conn==null) {
                                        out.println("Error : Could not connect to database"); return; }
                                        PreparedStatement prest=conn.prepareStatement(tablesql); ResultSet
                                        rs=prest.executeQuery(); if (rs.next()) {
                                        crmTable=rs.getString("crm_table_name"); } rs.close(); prest.close(); String
                                        sql="SELECT c_date, case when c_type = 'I' then c_clid else c_dst end as c_clid,"
                                        + "c_type,c_agent_id,c_agent_exten,"
                                        + "c_srv_name,ifnull(c_disp_level1,'') as c_disp_level1,ifnull(c_disp_level2,'') as c_disp_level2,"
                                        + "c_remarks FROM " + tableName + " where c_agent_id='" + aid
                                        + "' order by c_date desc limit 50" ; if
                                        (request.getParameterMap().containsKey("btn")) { String
                                        val=request.getParameter("btn"); if (val.equals("Show All")) {
                                        sql="SELECT * FROM " + tableName + "" ; } } prest=conn.prepareStatement(sql);
                                        rs=prest.executeQuery(); String phone="" ; while (rs.next()) { output +="<tr>" ;
                                        output +="<td align='center'>" + rs.getString("c_date") + "</td>" ;
                                        phone=rs.getString("c_clid"); if (hidecallerid.equalsIgnoreCase("Y")) { //
                                        phone="XXXXXX" +phone.substring(6); } String
                                        sql2="select ifnull(first_name,'') as fname from " + crmTable
                                        + " where caller_clid='" + phone + "' order by id desc limit 1" ;
                                        PreparedStatement prest2=conn.prepareStatement(sql2); ResultSet
                                        rs2=prest2.executeQuery(); String fname="" ; if (rs2.next()) {
                                        fname=rs2.getString("fname"); } rs2.close(); prest2.close(); output
                                        +="<td align='center'>" + fname + "</td>" ; output +="<td align='center'>" +
                                        phone + "</td>" ; output +="<td align='center'>" + rs.getString("c_type")
                                        + "</td>" ; output +="<td align='center'>" + rs.getString("c_agent_id")
                                        + "</td>" ; output +="<td align='center'>" + rs.getString("c_agent_exten")
                                        + "</td>" ; output +="<td align='center'>" + rs.getString("c_srv_name")
                                        + "</td>" ; output +="<td align='center'>" + rs.getString("c_disp_level1")
                                        + "</td>" ; output +="<td align='center'>" + rs.getString("c_disp_level2")
                                        + "</td>" ; output +="</tr>" ; } output +="</table>" ; out.println(output);
                                        conn.close(); } catch (Exception e) { out.println("no data found"); } %>
                        </body>

                        </html>
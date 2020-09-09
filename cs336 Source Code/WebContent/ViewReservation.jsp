<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservation History</title>
</head>
<body>
		

	<div align="center">
		<form action="ReservationCancel.jsp" method="post">
        <table id = "result" border="1" cellpadding="5">
            <caption><h2>Current and past reservations</h2></caption>
            <THEAD>
            <tr>
                
                <th>Reservation Number</th>
                <th>Transit Line Name</th>
                <th>Departure Date Time</th>
                <th>Departure Stop</th>
                <th>Arrival Date Time</th>
                <th>Arrival Stop</th>
                <th>Seat Class</th>
                <th>Seat Number</th>
            </tr>
            </THEAD>
            <TBODY>
            <%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String origin = request.getParameter("origin");
			String destination = request.getParameter("destination");
			String date_of_travel = request.getParameter("date_of_travel");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = String.format("SELECT R.ReservationNumber,R.TransitLineName,R.ReservationDate,T3.BeginName,T1.EndTime,T2.EndName,R.Seat_Class,R.Seat_Number FROM project_336_aws.Reservation R JOIN (SELECT S.StationID,S.Name as BeginName FROM project_336_aws.Stations S) T3 ON R.StationID = T3.StationID JOIN (SELECT S.StationID, S.Name as EndName FROM project_336_aws.Stations S) T2 ON R.StationID2 = T2.StationID JOIN (Select A.StationID as abc, A.`Arrival Time` as EndTime From project_336_aws.Arrange A) T1 ON T1.abc = T2.StationID where R.Username = '%s';",session.getAttribute("username"));
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			while(result.next()){
				%>
                <tr>
                 <%
                 for(int i = 1; i<=8;i++)
                    { %>
                     <td>
                     <%= result.getString(i)%>
                     </td>
                <% 
                    }
                %>
    
                                   
                </tr>
            <% 
			}

			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%> </TBODY>
        </table>
        <input type="hidden" name="ReservationNumber" value=""/>
        <input type="submit" value="Cancel selected reservation"/>
      </form>
      <form  action="search.jsp" method="post" name="SearchFrom">
	<center><input type="submit" value="Go to Search"/></center>
		</form>	
    </div>
	<br>Selected Reservation Number:
	<label id="ReservationNumber"></label>
	<script>
		(function () {
    if (window.addEventListener) {
        window.addEventListener('load', run, false);
    } else if (window.attachEvent) {
        window.attachEvent('onload', run);
    }

    function run() {
        var t = document.getElementById('result');
        t.onclick = function (event) {
            event = event || window.event; 
            var target = event.target || event.srcElement;
            while (target && target.nodeName != 'TR') {
                target = target.parentElement;
            }
            var cells = target.cells; 
            if (!cells.length || target.parentNode.nodeName == 'THEAD') {
                return;
            }
            var f1 = document.getElementById('ReservationNumber');
            f1.innerHTML = cells[0].innerHTML;
            var inputs = document.getElementsByTagName("input"), len = inputs.length, i;
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "ReservationNumber") {
                    inputs[i].value = cells[0].innerHTML;
                    break;
                }
            }
            
        };
    }

})();
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TS View</title>
</head>
<body>
		

	<div align="center">
		<form action="CRDeleteTS.jsp" method="post">
        <table id = "result" border="1" cellpadding="5">
            <caption><h2>Current Trains</h2></caption>
            <THEAD>
            <tr>
                
                <th>Transit Line Name</th>
                <th>Stops</th>
                <th>Available Seats</th>
                <th>Arrival Date</th>
                <th>Arrival Time</th>
                <th>Departure Date</th>
                <th>Departure Time</th>
                <th>Travel Time</th>
                <th>Start At</th>
                <th>End At</th>
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
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = String.format("SELECT * FROM project_336_aws.Train_Schedule TS JOIN project_336_aws.Stations S1 ON TS.StartAt = S1.StationID JOIN project_336_aws.Stations S ON TS.EndAt = S.StationID;");
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
    			
                     <td>
                     <%= result.getString(12)%>
                     </td>
                     <td>
                     <%= result.getString(16)%>
                     </td>
            
                                   
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
        <input type="hidden" name="TransitLineName" value=""/>
        <input type="submit" value="Delete TransitLine"/>
      </form>
		<form  action="CRAddTS.jsp" method="post" name="SearchFrom">
		Enter TransitName:<input type = "text" id = "NTransitName" name = "TransitName" value = "">
		<br>
		Enter Stops:<input type = "text" id = "NStops" name = "Stops" value = "">
		<br>
		Enter Seats:<input type = "text" id = "NSeats" name = "Seats" value = "">
		<br>
		Enter Arrival Date:<input type = "text" id = "NArrivalDate" name = "ArrivalDate" value = "">
		<br>
		Enter Arrival Time:<input type = "text" id = "NArrivalTime" name = "ArrivalTime" value = "">
		<br>
		Enter Departure Date:<input type = "text" id = "NDepartureDate" name = "DepartureDate" value = "">
		<br>
		Enter Departure Time:<input type = "text" id = "NDepartureTime" name = "DepartureTime" value = "">
		<br>
		Enter Start At:<input type = "text" id = "NStartAt" name = "StartAt" value = "">
		<br>
		Enter End At:<input type = "text" id = "NEndAt" name = "EndAt" value = "">
		<br>
	<center><input type="submit" value="Add Train Schedule"/></center>
		</form>	
		<form  action="CREditTS.jsp" method="post" name="SearchFrom">
		Choose A column to edit:<select onchange="GetSelectedValue()" id = 'edit'>
			<option value = "1" selected>Transit Line Name</option>
			<option value = "2">Stops</option>
			<option value = "3">Seats</option>
			<option value = "4">Arrival Date</option>
			<option value = "5">Arrival Time</option>
			<option value = "6">Departure Date</option>
			<option value = "7">Departure Time</option>
			<option value = "8">StartAt</option>
			<option value = "9">EndAt</option>
		</select>
		<input type = "hidden" id = "es" name = "editSelection" value = "1">
		<input type = "hidden" id = "TL" name = "TL" value = "">
		<br>
		Enter desired data:<input type = "text" id = "exTS" name = "desire" value = "">
	<center><input type="submit" value="Edit Train Schedule"/></center>
		</form>	
    </div>
	<br>Selected Transit Line Name:
	<label id="TTransitLineName"></label>
	<script>
	function GetSelectedValue(){
		var e = document.getElementById("edit");
		var result = e.options[e.selectedIndex].value;
		document.getElementById("es").value = result;
	}
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
            var f1 = document.getElementById('TTransitLineName');
            f1.innerHTML = cells[0].innerHTML;
            var inputs = document.getElementsByTagName("input"), len = inputs.length, i;
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "TransitLineName") {
                    inputs[i].value = cells[0].innerHTML;
                    document.getElementById('TL').value = cells[0].innerHTML;
                    break;
                }
            }
            
        };
    }

})();
	</script>
	<form  action="CRViewReservation.jsp" method="post">
			<input type="submit" value="Reservation View" />
	</form>
	<form  action="CRViewTS.jsp" method="post">
			<input type="submit" value="Train Schedule View" />
	</form>
	<form  action="CRMyQuestion.jsp" method="post">
			<input type="submit" value="View Customers Question" />
	</form>
<form  action="CRGood.jsp" method="post" name="ReserveFrom">
	<center><input type="submit" value="Back To Home"/></center>
</form>
</body>
</html>
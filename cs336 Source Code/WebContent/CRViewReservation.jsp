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
		<form action="CRDeleteReservation.jsp" method="post">
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
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = String.format("SELECT R.ReservationNumber,R.TransitLineName,R.ReservationDate,T3.BeginName,T1.EndTime,T2.EndName,R.Seat_Class,R.Seat_Number FROM project_336_aws.Reservation R JOIN (SELECT S.StationID,S.Name as BeginName FROM project_336_aws.Stations S) T3 ON R.StationID = T3.StationID JOIN (SELECT S.StationID, S.Name as EndName FROM project_336_aws.Stations S) T2 ON R.StationID2 = T2.StationID JOIN (Select A.StationID as abc, A.`Arrival Time` as EndTime From project_336_aws.Arrange A) T1 ON T1.abc = T2.StationID ;");
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
        <input type="submit" value="Delete Reservation"/>
      </form>
		<form  action="CRAddReservation.jsp" method="post" name="SearchFrom">
		Enter ReservationDate:<input type = "text" id = "NReservationDate" name = "ReservationDate" value = "">
		<br>
		Enter Seat_Class:<input type = "text" id = "NSeat_Class" name = "Seat_Class" value = "">
		<br>
		Enter Username:<input type = "text" id = "NUsername" name = "Username" value = "">
		<br>
		Enter Departure Time:<input type = "text" id = "NDeparture" name = "Departure" value = "">
		<br>
		Enter Arrival Time:<input type = "text" id = "NArrival" name = "Arrival" value = "">
		<br>
		Enter Departure Station:<input type = "text" id = "NStationID" name = "Origin" value = "">
		<br>
		Enter Arrival Station:<input type = "text" id = "NStationID2" name = "Destination" value = "">
		<br>
		Enter TransitLineName:<input type = "text" id = "NTransitLineName" name = "Route" value = "">
		<br>
		<input type="radio" id="Adults" name="discount" value="Adults">
		<label for="Adults">Adults</label>
		<input type="radio" id="Senior_Discount" name="discount" value="Senior_Discount">
		<label for="Senior">Senior</label>
		<input type="radio" id="Children_Discount" name="discount" value="Children_Discount">
		<label for="Children">Children</label>
		<input type="radio" id="Disabled_Discount" name="discount" value="Disabled_Discount">
		<label for="Disabled">Disabled</label><br>
		<input type="radio" id="One-Way" name="way" value="One-Way" >
		<label for="One-Way">One-Way</label>
		<input type="radio" id="Round-trip" name="way" value="Round-trip" >
		<label for="Round-trip">Round-trip</label>
		<input type="radio" id="Monthly" name="way" value="Monthly">
		<label for="Monthly">Monthly</label>
		<input type="radio" id="Weekly" name="way" value="Weekly">
		<label for="Weekly">Weekly</label>
	<center><input type="submit" value="Add Reservation"/></center>
		</form>	
		<form  action="CREditReservation.jsp" method="post" name="SearchFrom">
		Choose A column to edit:<select onchange="GetSelectedValue()" id = 'edit'>
			<option value = "1" selected>Reservation Number</option>
			<option value = "2">Transit Line Name</option>
			<option value = "4">Departure Stop</option>
			<option value = "6">Arrival Stop</option>
			<option value = "7">Seat Class</option>
			<option value = "8">Seat Number</option>
		</select>
		<input type = "hidden" id = "es" name = "editSelection" value = "1">
		<input type = "hidden" id = "RN" name = "RN" value = "">
		<br>
		Enter desired data:<input type = "text" id = "extext" name = "desire" value = "">
	<center><input type="submit" value="Edit Reservation"/></center>
		</form>	
    </div>
	<br>Selected Reservation Number:
	<label id="ReservationNumber"></label>
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
            var f1 = document.getElementById('ReservationNumber');
            f1.innerHTML = cells[0].innerHTML;
            var inputs = document.getElementsByTagName("input"), len = inputs.length, i;
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "ReservationNumber") {
                    inputs[i].value = cells[0].innerHTML;
                    document.getElementById('RN').value = cells[0].innerHTML;
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
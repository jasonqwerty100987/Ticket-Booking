<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<p>Please Click on one row from the table to make a selection!!</p>
	<p style="display: none;" id = "Status">
	0
	</p>
	<div align="center">
		<form action="ReservationGood.jsp" method="post">
        <table id = "result" border="1" cellpadding="5">
            <caption><h2>Available Trains</h2></caption>
            <THEAD>
            <tr>
                <th>Transit Line Name</th>
                <th>Stops</th>
                <th>Available Seats</th>
                <th>Departure Date Time</th>
                <th>Arrival Date Time</th>
                <th>Travel Time</th>
                <th>Train ID</th>
                <th>One Way Price</th>
                <th>Round Trip Price</th>
                <th>Monthly Price</th>
                <th>Weekly Price</th>
                <th>Start At</th>
                <th>End At</th>
            </tr>
            </THEAD>
            <TBODY>
            <%
            
            ArrayList<String> arraylist = new ArrayList<String>();
		try {
			if(request.getParameter("search")!=null && (Integer.parseInt(request.getParameter("search")) == 1|| Integer.parseInt(request.getParameter("search")) == 2)){
			
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			int search = Integer.parseInt(request.getParameter("search"));
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String origin = "";
			String destination = "";
			String date_of_travel = request.getParameter("date_of_travel");
			if(search == 2){
				origin = request.getParameter("origin");
				destination = request.getParameter("destination");
			}
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "";
			int sort = 0;
			int order = 0;
			String sortorder = "";
			if(request.getParameter("sort")!= null && Integer.parseInt(request.getParameter("sort")) > 0){
				sort = Integer.parseInt(request.getParameter("sort"));
				if(!request.getParameter("order").isEmpty() && Integer.parseInt(request.getParameter("order")) > 0){
					order = Integer.parseInt(request.getParameter("order"));
				}
			}
			
			switch(sort){
			case 1:
				if(search == 1){
					sortorder = "ORDER BY TS.ArrivalTime";
					if(order == 0 || order == 1){
						sortorder += " ASC";
					}else{
						sortorder += " DESC";
					}
					str = String.format("select TS.TransitLineName, TS.Stops AS Stops, TS.AvailableSeats, TS.DepartureTime, TS.ArrivalTime, TIMEDIFF(TS.ArrivalTime, TS.DepartureTime) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount, S.Name AS BeginAt, T1.Name2 AS EndAt FROM project_336_aws.Train_Schedule TS JOIN project_336_aws.Stations S ON S.StationID = TS.StartAt JOIN (SELECT S.StationID, S.Name AS Name2 FROM project_336_aws.Stations S) T1 ON T1.StationID = TS.EndAt, project_336_aws.Runs R, project_336_aws.Fare F where TS.DepartureDate = '%s' AND TS.DepartureDate LIKE '%s' AND TS.ArrivalDate LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TS.StartAt AND F.End = TS.EndAt %s;",date_of_travel,date_of_travel+"%",date_of_travel+"%",sortorder);
				}else if(search == 2){
					sortorder = "ORDER BY TA2.`Arrival Time`";
					if(order == 0 || order == 1){
						sortorder += " ASC";
					}else{
						sortorder += " DESC";
					}
				str = String.format("select TS.TransitLineName, TA2.StationID - TA1.StationID AS Stops, TS.AvailableSeats, TA1.`Departure Time`, TA2.`Arrival Time`, TIMEDIFF(TA2.`Arrival Time`, TA1.`Departure Time`) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount FROM project_336_aws.Train_Schedule TS, project_336_aws.Arrange TA1, project_336_aws.Arrange TA2, project_336_aws.Runs R, project_336_aws.Fare F where TS.TransitLineName = ( select A.TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.TransitLineName = ( select TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.DepartureDate = '%s' AND TA1.`Departure Time` LIKE '%s' AND TA2.`Arrival Time` LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TA1.StationID AND F.End = TA2.StationID AND TA1.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) AND TA2.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s') %s;",origin, destination,date_of_travel,date_of_travel+"%",date_of_travel+"%",origin,destination, sortorder);
				}
				break;
			case 2:
				if(search == 1){
					sortorder = "ORDER BY TS.DepartureTime";
					if(order == 0 || order == 1){
						sortorder += " ASC";
					}else{
						sortorder += " DESC";
					}
					str = String.format("select TS.TransitLineName, TS.Stops AS Stops, TS.AvailableSeats, TS.DepartureTime, TS.ArrivalTime, TIMEDIFF(TS.ArrivalTime, TS.DepartureTime) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount, S.Name AS BeginAt, T1.Name2 AS EndAt FROM project_336_aws.Train_Schedule TS JOIN project_336_aws.Stations S ON S.StationID = TS.StartAt JOIN (SELECT S.StationID, S.Name AS Name2 FROM project_336_aws.Stations S) T1 ON T1.StationID = TS.EndAt, project_336_aws.Runs R, project_336_aws.Fare F where TS.DepartureDate = '%s' AND TS.DepartureDate LIKE '%s' AND TS.ArrivalDate LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TS.StartAt AND F.End = TS.EndAt %s;",date_of_travel,date_of_travel+"%",date_of_travel+"%",sortorder);
				}else if(search == 2){
					sortorder = "ORDER BY TA1.`Departure Time`";
					if(order == 0 || order == 1){
						sortorder += " ASC";
					}else{
						sortorder += " DESC";
					}
				str = String.format("select TS.TransitLineName, TA2.StationID - TA1.StationID AS Stops, TS.AvailableSeats, TA1.`Departure Time`, TA2.`Arrival Time`, TIMEDIFF(TA2.`Arrival Time`, TA1.`Departure Time`) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount FROM project_336_aws.Train_Schedule TS, project_336_aws.Arrange TA1, project_336_aws.Arrange TA2, project_336_aws.Runs R, project_336_aws.Fare F where TS.TransitLineName = ( select A.TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.TransitLineName = ( select TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.DepartureDate = '%s' AND TA1.`Departure Time` LIKE '%s' AND TA2.`Arrival Time` LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TA1.StationID AND F.End = TA2.StationID AND TA1.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) AND TA2.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s') %s;",origin, destination,date_of_travel,date_of_travel+"%",date_of_travel+"%",origin,destination, sortorder);
				}
				break;
			case 3: // sort by origin
				sortorder = "ORDER BY BeginAt";
				if(order == 0 || order == 1){
					sortorder += " ASC";
				}else{
					sortorder += " DESC";
				}
				if(search == 1){
					str = String.format("select TS.TransitLineName, TS.Stops AS Stops, TS.AvailableSeats, TS.DepartureTime, TS.ArrivalTime, TIMEDIFF(TS.ArrivalTime, TS.DepartureTime) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount, S.Name AS BeginAt, T1.Name2 AS EndAt FROM project_336_aws.Train_Schedule TS JOIN project_336_aws.Stations S ON S.StationID = TS.StartAt JOIN (SELECT S.StationID, S.Name AS Name2 FROM project_336_aws.Stations S) T1 ON T1.StationID = TS.EndAt, project_336_aws.Runs R, project_336_aws.Fare F where TS.DepartureDate = '%s' AND TS.DepartureDate LIKE '%s' AND TS.ArrivalDate LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TS.StartAt AND F.End = TS.EndAt %s;",date_of_travel,date_of_travel+"%",date_of_travel+"%",sortorder);
				}else if(search == 2){
				str = String.format("select TS.TransitLineName, TA2.StationID - TA1.StationID AS Stops, TS.AvailableSeats, TA1.`Departure Time`, TA2.`Arrival Time`, TIMEDIFF(TA2.`Arrival Time`, TA1.`Departure Time`) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount FROM project_336_aws.Train_Schedule TS, project_336_aws.Arrange TA1, project_336_aws.Arrange TA2, project_336_aws.Runs R, project_336_aws.Fare F where TS.TransitLineName = ( select A.TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.TransitLineName = ( select TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.DepartureDate = '%s' AND TA1.`Departure Time` LIKE '%s' AND TA2.`Arrival Time` LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TA1.StationID AND F.End = TA2.StationID AND TA1.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) AND TA2.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s') ;",origin, destination,date_of_travel,date_of_travel+"%",date_of_travel+"%",origin,destination);
				}
				break;
			case 4: // sort by destination
				sortorder = "ORDER BY EndAt";
				if(order == 0 || order == 1){
					sortorder += " ASC";
				}else{
					sortorder += " DESC";
				}
				if(search == 1){
					str = String.format("select TS.TransitLineName, TS.Stops AS Stops, TS.AvailableSeats, TS.DepartureTime, TS.ArrivalTime, TIMEDIFF(TS.ArrivalTime, TS.DepartureTime) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount, S.Name AS BeginAt, T1.Name2 AS EndAt FROM project_336_aws.Train_Schedule TS JOIN project_336_aws.Stations S ON S.StationID = TS.StartAt JOIN (SELECT S.StationID, S.Name AS Name2 FROM project_336_aws.Stations S) T1 ON T1.StationID = TS.EndAt, project_336_aws.Runs R, project_336_aws.Fare F where TS.DepartureDate = '%s' AND TS.DepartureDate LIKE '%s' AND TS.ArrivalDate LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TS.StartAt AND F.End = TS.EndAt %s;",date_of_travel,date_of_travel+"%",date_of_travel+"%",sortorder);
				}else if(search == 2){
				str = String.format("select TS.TransitLineName, TA2.StationID - TA1.StationID AS Stops, TS.AvailableSeats, TA1.`Departure Time`, TA2.`Arrival Time`, TIMEDIFF(TA2.`Arrival Time`, TA1.`Departure Time`) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount FROM project_336_aws.Train_Schedule TS, project_336_aws.Arrange TA1, project_336_aws.Arrange TA2, project_336_aws.Runs R, project_336_aws.Fare F where TS.TransitLineName = ( select A.TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.TransitLineName = ( select TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.DepartureDate = '%s' AND TA1.`Departure Time` LIKE '%s' AND TA2.`Arrival Time` LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TA1.StationID AND F.End = TA2.StationID AND TA1.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) AND TA2.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s') ;",origin, destination,date_of_travel,date_of_travel+"%",date_of_travel+"%",origin,destination);
				}
				break;
			case 5: // Fare
				if(search == 1){
					sortorder = "ORDER BY F.OneWay";
					if(order == 0 || order == 1){
						sortorder += " ASC";
					}else{
						sortorder += " DESC";
					}
					str = String.format("select TS.TransitLineName, TS.Stops AS Stops, TS.AvailableSeats, TS.DepartureTime, TS.ArrivalTime, TIMEDIFF(TS.ArrivalTime, TS.DepartureTime) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount, S.Name AS BeginAt, T1.Name2 AS EndAt FROM project_336_aws.Train_Schedule TS JOIN project_336_aws.Stations S ON S.StationID = TS.StartAt JOIN (SELECT S.StationID, S.Name AS Name2 FROM project_336_aws.Stations S) T1 ON T1.StationID = TS.EndAt, project_336_aws.Runs R, project_336_aws.Fare F where TS.DepartureDate = '%s' AND TS.DepartureDate LIKE '%s' AND TS.ArrivalDate LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TS.StartAt AND F.End = TS.EndAt %s;",date_of_travel,date_of_travel+"%",date_of_travel+"%",sortorder);
				}else if(search == 2){
					sortorder = "ORDER BY F.OneWay";
					if(order == 0 || order == 1){
						sortorder += " ASC";
					}else{
						sortorder += " DESC";
					}
				str = String.format("select TS.TransitLineName, TA2.StationID - TA1.StationID AS Stops, TS.AvailableSeats, TA1.`Departure Time`, TA2.`Arrival Time`, TIMEDIFF(TA2.`Arrival Time`, TA1.`Departure Time`) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount FROM project_336_aws.Train_Schedule TS, project_336_aws.Arrange TA1, project_336_aws.Arrange TA2, project_336_aws.Runs R, project_336_aws.Fare F where TS.TransitLineName = ( select A.TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.TransitLineName = ( select TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.DepartureDate = '%s' AND TA1.`Departure Time` LIKE '%s' AND TA2.`Arrival Time` LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TA1.StationID AND F.End = TA2.StationID AND TA1.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) AND TA2.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s') %s;",origin, destination,date_of_travel,date_of_travel+"%",date_of_travel+"%",origin,destination, sortorder);
				}
				break;
			default:
				if(search == 1){
					str = String.format("select TS.TransitLineName, TS.Stops AS Stops, TS.AvailableSeats, TS.DepartureTime, TS.ArrivalTime, TIMEDIFF(TS.ArrivalTime, TS.DepartureTime) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount, S.Name AS BeginAt, T1.Name2 AS EndAt FROM project_336_aws.Train_Schedule TS JOIN project_336_aws.Stations S ON S.StationID = TS.StartAt JOIN (SELECT S.StationID, S.Name AS Name2 FROM project_336_aws.Stations S) T1 ON T1.StationID = TS.EndAt, project_336_aws.Runs R, project_336_aws.Fare F where TS.DepartureDate = '%s' AND TS.DepartureDate LIKE '%s' AND TS.ArrivalDate LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TS.StartAt AND F.End = TS.EndAt;",date_of_travel,date_of_travel+"%",date_of_travel+"%");
				}else if(search == 2){
				str = String.format("select TS.TransitLineName, TA2.StationID - TA1.StationID AS Stops, TS.AvailableSeats, TA1.`Departure Time`, TA2.`Arrival Time`, TIMEDIFF(TA2.`Arrival Time`, TA1.`Departure Time`) AS TravelTime, R.TrainID, F.OneWay, F.RoundTrip, F.WeeklyFare, F.MonthlyFare, F.Senior_Discount, F.Children_Discount, F.Disabled_Discount FROM project_336_aws.Train_Schedule TS, project_336_aws.Arrange TA1, project_336_aws.Arrange TA2, project_336_aws.Runs R, project_336_aws.Fare F where TS.TransitLineName = ( select A.TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.TransitLineName = ( select TransitLineName from project_336_aws.Arrange A where A.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) ) AND TS.DepartureDate = '%s' AND TA1.`Departure Time` LIKE '%s' AND TA2.`Arrival Time` LIKE '%s' AND TS.TransitLineName = R.TransitName AND F.Begin = TA1.StationID AND F.End = TA2.StationID AND TA1.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s' ) AND TA2.StationID = ( select StationID from project_336_aws.Stations S where S.Name = '%s') ;",origin, destination,date_of_travel,date_of_travel+"%",date_of_travel+"%",origin,destination);
				}
				break;
			}
			
			
			//Run the query against the database.
			System.out.println(str);
			ResultSet result = stmt.executeQuery(str);
			int j = 0;
			while(result.next()){
				%>
                <tr>
                 <%
                 for(int i = 1; i<=11;i++)
                    { %>
                     <td>
                     <%= result.getString(i)%>
                     </td>
                <% 
                    }
                 if(search == 1){
                %>
                <td><%= result.getString(15) %></td>
                <td><%= result.getString(16) %></td>
                <% 
                 }else if(search == 2){
                	 %>
                     <td><%= origin %></td>
                     <td><%= destination %></td>
                     <% 
                 }
                 if(!arraylist.contains(result.getString(1))){
                	arraylist.add(result.getString(1));
                } 
                %>
                <td style="display: none;"><%= result.getDouble(12) %></td>
                <td style="display: none;"><%= result.getDouble(13) %></td>
                <td style="display: none;"><%= result.getDouble(14) %></td>                   
                </tr>
            <% 
			}
			//close the connection.
			db.closeConnection(con);
			}else{
				
			}
		} catch (Exception e) {
			out.print(e);
		}
	%> </TBODY>
        </table>
        <input type="radio" id="Adults" name="discount" value="Adults" onclick="radioCheck()" >
		<label for="Adults">Adults</label>
		<input type="radio" id="Senior_Discount" name="discount" value="Senior_Discount" onclick="radioCheck()">
		<label for="Senior">Senior</label>
		<input type="radio" id="Children_Discount" name="discount" value="Children_Discount" onclick="radioCheck()">
		<label for="Children">Children</label>
		<input type="radio" id="Disabled_Discount" name="discount" value="Disabled_Discount" onclick="radioCheck()">
		<label for="Disabled">Disabled</label><br>
		<input type="radio" id="One-Way" name="way" value="One-Way" onclick="radioCheck()">
		<label for="One-Way">One-Way</label>
		<input type="radio" id="Round-trip" name="way" value="Round-trip" onclick="radioCheck()">
		<label for="Round-trip">Round-trip</label>
		<input type="radio" id="Monthly" name="way" value="Monthly" onclick="radioCheck()">
		<label for="Monthly">Monthly</label>
		<input type="radio" id="Weekly" name="way" value="Weekly" onclick="radioCheck()">
		<label for="Weekly">Weekly</label><br>
		<input type="hidden" name="Route" value=""/>
		<input type="hidden" name="Origin" value=""/>
		<input type="hidden" name="Destination" value=""/>
		<input type="hidden" name="Departure" value=""/>
		<input type="hidden" name="Arrival" value=""/>
        <input type = 'submit' id = 'submit' value = 'Confirm Reservation!'>
        
      </form>
    </div>
    <div align="center">
    <%
    try{
    	if(arraylist.size() > 0){
    	ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String selection = "("; 
		for(String route : arraylist){
			selection += "'" + route + "',";
		}
		selection = selection.substring(0, selection.length()-1) + ")";
		String str = String.format("SELECT (select COUNT(*) FROM project_336_aws.Arrange A JOIN project_336_aws.Stations S ON A.StationID = S.StationID WHERE A.TransitLineName in %s ORDER BY A.TransitLineName )AS count, A.TransitLineName, S.Name FROM project_336_aws.Arrange A JOIN project_336_aws.Stations S ON A.StationID = S.StationID WHERE A.TransitLineName in %s ORDER BY A.TransitLineName;", selection,selection);
		System.out.println(str);
		ResultSet result = stmt.executeQuery(str);
		boolean status = true;
		String previousone = "";
		int rsLen = 0;
		int counter = 0;
		while(result.next()){
			if(status){
				rsLen = result.getInt("count");
				System.out.println("rsLen = " + rsLen);
			}
			System.out.println(counter);
			System.out.println(result.getString("TransitLineName") .equals( previousone));
			if(!result.getString("TransitLineName").equals(previousone)){
				if(!status){
					%></tr></table><%
				}else{
					status = false;
				}
				previousone = result.getString("TransitLineName");
			%><table><tr><td><%= result.getString("TransitLineName") + " || "%></td><td>
                     <%= result.getString("Name") + " ||"%>
                     </td><%
			}else{
				%>
                     <td>
                     <%= result.getString("Name") + " || "%>
                     </td>
                	<% 
             result.getString("TransitLineName");
             if(++counter == rsLen - 1){
				%></tr></table><%
				System.out.println("break at counter");
             }
			}
			
			
		}
    	}else{
    		%>
            <p>
            	No Available Result Depends On Your Selection.
            <p>
       	<% 
    	}
    }catch(Exception e) {
		out.print(e);
    }
    
    
    
    
    
    %>
    
    </div>
    <br>Selected Train ID:
	<label id="Train_ID1"></label>
	<br>Selected Route:
	<label id="Route1"></label>
	<br>Selected origin:
	<label id="Origin1"></label>
	<br>Selected Destination:
	<label id="Destination1"></label>
	<br>Selected Departure Time:
	<label id="Departure1"></label>
	<br>Selected Arrival Time:
	<label id="Arrival1"></label>
	<br>Senior_Discount:
	<label id="SD"></label>
	<br>Children_Discount:
	<label id="CD"></label>
	<br>Disabled_Discount:
	<label id="DD"></label>
	<script>
		(function () {
    if (window.addEventListener) {
        window.addEventListener('load', run, false);
    } else if (window.attachEvent) {
        window.attachEvent('onload', run);
    }

    function run() {
    	document.getElementById("submit").disabled = true;
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
            document.getElementById("Status").innerHTML = "1";
            var f1 = document.getElementById('Train_ID1');
            var f2 = document.getElementById('Route1');
            var f3 = document.getElementById('Origin1');
            var f4 = document.getElementById('Destination1');
            var f5 = document.getElementById('Departure1');
            var f6 = document.getElementById('Arrival1');
            var f7 = document.getElementById('SD');
            var f8 = document.getElementById('CD');
            var f9 = document.getElementById('DD');
            
            f1.innerHTML = cells[6].innerHTML;
            f2.innerHTML = cells[0].innerHTML;
            f3.innerHTML = cells[7].innerHTML;
            f4.innerHTML = cells[8].innerHTML;
            f5.innerHTML = cells[3].innerHTML;
            f6.innerHTML = cells[4].innerHTML;
            f7.innerHTML = 100-cells[13].innerHTML*100 + "% OFF";
            f8.innerHTML = 100-cells[14].innerHTML*100 + "% OFF";
            f9.innerHTML = 100-cells[15].innerHTML*100 + "% OFF";
            
            var inputs = document.getElementsByTagName("input"), len = inputs.length, i;
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "Route") {
                    inputs[i].value = cells[0].innerHTML;
                    break;
                }
            }
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "Origin") {
                    inputs[i].value = cells[7].innerHTML;
                    break;
                }
            }
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "Destination") {
                    inputs[i].value = cells[8].innerHTML;
                    break;
                }
            }
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "Departure") {
                    inputs[i].value = cells[3].innerHTML;
                    break;
                }
            }
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "Arrival") {
                    inputs[i].value = cells[4].innerHTML;
                    break;
                }
            }
            radioCheck();
        };
    }

})();
		function radioCheck() {
			if(document.getElementById("Status").innerHTML == "1" && document.querySelector('input[name="discount"]:checked') != null && document.querySelector('input[name="way"]:checked') != null){
				document.getElementById("submit").disabled = false;
			}else{
				document.getElementById("submit").disabled = true;
			}
	    }
		
	</script>
	<br>
	<form  action="search.jsp" method="post">
			<input type="submit" value="Back To Search" />
	</form>
</body>
</html>
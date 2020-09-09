<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Random"%>
<%@ page import="java.util.concurrent.ThreadLocalRandom"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Schedule Add Successfully!</title>
</head>
<body>
<p>Update Successfully!</p>
<form  action="CRViewTS.jsp" method="post" name="ReserveFrom">
	<center><input type="submit" value="View Transchedule"/></center>
</form>
	<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			
			String Begin = request.getParameter("StartAt");
			String End = request.getParameter("EndAt");
			
			String str = String.format("Select StationID from project_336_aws.Stations where Name = '%s'",Begin);
			System.out.println(Begin);
			ResultSet result = stmt.executeQuery(str);
			int BeginID;
			if(result.next()){
				BeginID = result.getInt("StationID");
			}else{
				throw new Exception("no begin detected.");
			}
			String str1 = String.format("Select StationID from project_336_aws.Stations where Name = '%s'",End);
			ResultSet result1 = stmt.executeQuery(str1);
			int EndID;
			if(result1.next()){
				EndID = result1.getInt("StationID");
			}else{
				throw new Exception("no end detected.");
			}
			String TransitLineName = request.getParameter("TransitName");
			String Stops = request.getParameter("Stops");
			String AvailableSeats = request.getParameter("Seats");
			String ArrivalDate = request.getParameter("ArrivalDate");
			String ArrivalTime = request.getParameter("ArrivalTime");
			String DepartureDate = request.getParameter("DepartureDate");
			String DepartureTime = request.getParameter("DepartureTime");
			
			String temp2 = String.format("INSERT INTO project_336_aws.Train_Schedule(TransitLineName, Stops, AvailableSeats, ArrivalDate, ArrivalTime, DepartureDate, DepartureTime,StartAt, EndAt,TravelTime ) VALUES('%s','%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s','00:00:00');",TransitLineName, Stops, AvailableSeats, ArrivalDate, ArrivalTime, DepartureDate, DepartureTime, BeginID, EndID);
			//stmt.executeUpdate(temp2);
			System.out.println(temp2);
			//Run the query against the database.
			Calendar calendar = Calendar.getInstance();
			
			if(stmt.executeUpdate(temp2)>0){
				str = String.format("SELECT TIMEDIFF( ( SELECT ArrivalTime FROM project_336_aws.Train_Schedule TS WHERE TS.TransitLineName = '%s' ), ( SELECT DepartureTime FROM project_336_aws.Train_Schedule TS WHERE TS.TransitLineName = '%s' ) )",TransitLineName,TransitLineName);
				System.out.println(str);
				String timeDiff = "";
				result = stmt.executeQuery(str);
				if(result.next()){
					timeDiff = result.getString(1);
				}
				str = String.format("Update project_336_aws.Train_Schedule SET TravelTime = '%s' WHERE TransitLineName = '%s';", timeDiff, TransitLineName);
				stmt.executeUpdate(str);
			}
			//close the connection.
			db.closeConnection(con);
			
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>
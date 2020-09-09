<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>TS Edit</title>
</head>
<body>
<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String fieldName = request.getParameter("editSelection");
			int sel = Integer.parseInt(fieldName);
			switch(sel){
			case 1:
				fieldName = "TransitLineName";
				break;
			case 2:
				fieldName = "Stops";
				break;
			case 3:
				fieldName = "AvailableSeats";
				break;
			case 4:
				fieldName = "ArrivalDate";
				break;
			case 5:
				fieldName = "ArrivalTime";
				break;
			case 6:
				fieldName = "DepartureDate";
				break;
			case 7:
				fieldName = "DepartureTime";
				break;
			case 8:
				fieldName = "StartAt";
				break;
			case 9:
				fieldName = "EndAt";
				break;
			}
			String Content = request.getParameter("desire");
			String TS = request.getParameter("TL");
			TS = TS.trim().replaceAll(" +", " ");
			Content = Content.trim().replaceAll(" +", " ");
			String str;
			if(sel == 8 || sel == 9){
				str = String.format("Update project_336_aws.Train_Schedule SET %s = (SELECT S.StationID FROM project_336_aws.Stations S WHERE S.Name = '%s') where TransitLineName = '%s';",fieldName,Content,TS); 
				
			}else{
			str = String.format("Update project_336_aws.Train_Schedule SET %s = '%s' where TransitLineName = '%s';",fieldName,Content,TS);
			}
			System.out.println(str);
			//Run the query against the database.
			stmt.executeUpdate(str);
			if(sel == 5 || sel == 7){
				str = String.format("SELECT TIMEDIFF( ( SELECT ArrivalTime FROM project_336_aws.Train_Schedule TS WHERE TS.TransitLineName = '%s' ), ( SELECT DepartureTime FROM project_336_aws.Train_Schedule TS WHERE TS.TransitLineName = '%s' ) )",TS,TS);
				System.out.println(str);
				String timeDiff = "";
				ResultSet result = stmt.executeQuery(str);
				if(result.next()){
					timeDiff = result.getString(1);
				}
				str = String.format("Update project_336_aws.Train_Schedule SET TravelTime = '%s' WHERE TransitLineName = '%s';", timeDiff, TS);
				stmt.executeUpdate(str);
			}
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
<p>Schedule Modified successfully!</p>
<form  action="CRViewTS.jsp" method="post" name="ViewFrom">
		<table width="60%" bgcolor="66CCFF" align="center">
		</table>
		<center><input type="submit" value="View TrainSchedule"/></center>
</form>
<form  action="CRViewReservation.jsp" method="post" name="SearchFrom">
	<center><input type="submit" value="View Reservation"/></center>
</form>

</body>
</html>
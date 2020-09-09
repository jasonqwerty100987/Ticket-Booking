<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation Cancel</title>
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
				fieldName = "ReservationNumber";
				break;
			case 2:
				fieldName = "TransitLineName";
				break;
			case 4:
				fieldName = "StationID";
				break;
			case 6:
				fieldName = "StationID2";
				break;
			case 7:
				fieldName = "Seat_Class";
				break;
			case 8:
				fieldName = "Seat_Number";
				break;
			}
			String Content = request.getParameter("desire");
			String ReservationNumber = request.getParameter("RN");
			ReservationNumber = ReservationNumber.trim().replaceAll(" +", " ");
			String str;
			if(sel == 4 || sel == 6){
				str = String.format("Update project_336_aws.Reservation SET %s = (SELECT S.StationID FROM project_336_aws.Stations S WHERE S.Name = '%s') where ReservationNumber = %s;",fieldName,Content,ReservationNumber); 
				
			}else{
			str = String.format("Update project_336_aws.Reservation SET %s = '%s' where ReservationNumber = '%s';",fieldName,Content,ReservationNumber);
			}
			System.out.println(str);
			//Run the query against the database.
			stmt.executeUpdate(str);
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
<p>Reservation Modified successfully!</p>
<form  action="CRViewReservation.jsp" method="post" name="ViewFrom">
		<table width="60%" bgcolor="66CCFF" align="center">
		</table>
		<center><input type="submit" value="View my reservation"/></center>
</form>


</body>
</html>
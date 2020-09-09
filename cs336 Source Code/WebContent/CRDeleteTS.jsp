<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Schedule Cancel</title>
</head>
<body>
<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String TS = request.getParameter("TransitLineName");
			TS = TS.trim().replaceAll(" +", " ");
			String str = String.format("DELETE FROM project_336_aws.Train_Schedule where TransitLineName = '%s'",TS);
			//Run the query against the database.
			stmt.executeUpdate(str);
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
<p>Train Schedule cancelled successfully!</p>
<form  action="CRViewReservation.jsp" method="post" name="ViewFrom">
		<table width="60%" bgcolor="66CCFF" align="center">
		</table>
		<center><input type="submit" value="Go to Reservation View"/></center>
</form>
<form  action="CRViewTS.jsp" method="post" name="SearchFrom">
	<center><input type="submit" value="Go to Transchedule View"/></center>
</form>

</body>
</html>
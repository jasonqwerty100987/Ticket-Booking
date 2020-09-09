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
			String Reserve1 = request.getParameter("ReservationNumber");
			String str = String.format("DELETE FROM Reservation where ReservationNumber = %s",Reserve1);
			//Run the query against the database.
			stmt.executeUpdate(str);
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
<p>Reservation cancelled successfully!</p>
<form  action="ViewReservation.jsp" method="post" name="ViewFrom">
		<table width="60%" bgcolor="66CCFF" align="center">
		</table>
		<center><input type="submit" value="View my reservation"/></center>
</form>
<form  action="search.jsp" method="post" name="SearchFrom">
	<center><input type="submit" value="Go to Search"/></center>
</form>

</body>
</html>
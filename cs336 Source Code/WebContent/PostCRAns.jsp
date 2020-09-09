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
			String Content = request.getParameter("ans");
			String QID = request.getParameter("Qid");
			QID = QID.trim().replaceAll(" +", " ");
			String str = String.format("update project_336_aws.QA set QA.Answer = '%s' Where QA.QAID = '%s'",Content, QID);
			System.out.println(str);
			//Run the query against the database.
			stmt.executeUpdate(str);
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
<p>Answer Updated successfully!</p>
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
	<input type="submit" value="Back To Home"/>
</form>

</body>
</html>
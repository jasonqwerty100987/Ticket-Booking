<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String ssn = request.getParameter("SSN");
			String lastname = request.getParameter("lastname");
			String firstname = request.getParameter("firstname");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String admin = request.getParameter("admin");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = String.format("INSERT INTO project_336_aws.Employee (`SSN`, `LastName`, `FirstName`, `Username`, `Password`, `admin`) VALUES ('%s','%s','%s','%s','%s','%s');", ssn, lastname, firstname, username, password, admin);
			//Run the query against the database.
			stmt.executeUpdate(str);
			response.sendRedirect("acc_manage.jsp");
			

			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html>
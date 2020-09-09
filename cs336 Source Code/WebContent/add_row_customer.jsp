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
			String username = request.getParameter("username");
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String telephone = request.getParameter("telephone");
			String city = request.getParameter("city");
			String email = request.getParameter("email");
			String state = request.getParameter("state");
			String address = request.getParameter("address");
			String zipcode = request.getParameter("zipcode");
			String password = request.getParameter("password");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = String.format("INSERT INTO project_336_aws.Customer (`Username`, `FirstName`, `LastName`, `Telephone`, `City`, `Email`, `State`, `Address`, `ZipCode`, `Password`) VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s');", username, firstname, lastname, telephone, city, email, state, address, zipcode, password);
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
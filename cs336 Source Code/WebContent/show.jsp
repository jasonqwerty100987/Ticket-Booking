<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
			String Username = request.getParameter("userid");
			String Password = request.getParameter("password");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = String.format("SELECT FirstName, LastName from project_336_aws.Customer WHERE Customer.Username = '%s' AND Customer.Password = '%s';",Username, Password);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			if(result.next()){
				if(!result.getString("FirstName").isEmpty() && !result.getString("LastName").isEmpty()){
					session.setAttribute("FullName", result.getString("FirstName") + " " + result.getString("LastName"));
					session.setAttribute("username", Username);
					response.sendRedirect("good.jsp");
				}
			}else{
				response.sendRedirect("Notgood.jsp");
			}

			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
	
</body>
</html>
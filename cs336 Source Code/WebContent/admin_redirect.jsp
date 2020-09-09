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
			//Get the selected radio button from the admin_login.jsp
			String Username = request.getParameter("admin_id");
			String Password = request.getParameter("admin_pwd");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = String.format("SELECT FirstName, LastName,admin from project_336_aws.Employee WHERE Employee.Username = '%s' AND Employee.Password = '%s';",Username, Password);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			if(result.next()){
				if(!result.getString("FirstName").isEmpty() && !result.getString("LastName").isEmpty()){
					if(result.getString("admin").equals("1")){
						//session.setAttribute("FullName", result.getString("FirstName") + " " + result.getString("LastName"));
						//session.setAttribute("username", Username);
						response.sendRedirect("admin_page.jsp");
					}
					else{
						response.sendRedirect("not_permitted.jsp");
					}
				}
			}else{
				response.sendRedirect("not_employee.jsp");
			}

			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
	
</body>
</html>
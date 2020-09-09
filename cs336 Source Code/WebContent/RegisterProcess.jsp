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
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String Username = request.getParameter("Username");
			String Email = request.getParameter("Email").isEmpty() ? String.valueOf((int)(Math.random()*100000)) : request.getParameter("Email");
			String Password = request.getParameter("Password");
			String FirstName = request.getParameter("FirstName").isEmpty() ? "Test" : request.getParameter("FirstName");
			String LastName = request.getParameter("LastName").isEmpty() ? "User": request.getParameter("LastName");
			String Telephone = request.getParameter("Telephone").isEmpty() ? String.valueOf((int)(Math.random()*100000)) : request.getParameter("Telephone");
			String City = request.getParameter("City").isEmpty() ? "0" : request.getParameter("City");
			String State = request.getParameter("State").isEmpty() ? "0" : request.getParameter("State");
			String Address = request.getParameter("Address").isEmpty() ? "0" : request.getParameter("Address");
			String ZipCode = request.getParameter("ZipCode").isEmpty() ? "0" : request.getParameter("ZipCode");
			
			String statement = String.format("INSERT into `Customer` (Username, Email, Password, FirstName, LastName, Telephone, City, State, Address, ZipCode) Values('%s','%s','%s','%s','%s','%s','%s','%s','%s',%s);",Username,Email,Password,FirstName,LastName,Telephone,City,State,Address,ZipCode);
			System.out.println(statement);
			System.out.println(stmt.executeUpdate(statement));
			session.setAttribute("username", Username);
			session.setAttribute("FullName", FirstName + " " + LastName);
			System.out.println("register successfully!");
			con.close();
			response.sendRedirect("good.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("Notgood.jsp");
		}
	%>

</body>
</html>
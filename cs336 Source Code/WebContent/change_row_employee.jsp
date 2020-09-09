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
			String fieldName = request.getParameter("editSelection");
			int sel = Integer.parseInt(fieldName);
			switch(sel){
			case 1:
				fieldName = "LastName";
				break;
			case 2:
				fieldName = "FirstName";
				break;
			case 3:
				fieldName = "Username";
				break;
			case 4:
				fieldName = "Password";
				break;
			case 5:
				fieldName = "admin";
				break;
			}
			String Content = request.getParameter("desire");
			String username = request.getParameter("SSN");
			String str = "";
			str = String.format("UPDATE project_336_aws.Employee SET %s = '%s' WHERE (SSN = '%s')",fieldName ,Content,username );
			System.out.println(str);
			//Run the query against the database.
			stmt.executeUpdate(str);
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
	
	<p>Information Modified successfully!</p>
<form  action="acc_manage.jsp" method="post" name="ViewFrom">
		
		<input type="submit" value="back"/>
</form>

</body>
</html>
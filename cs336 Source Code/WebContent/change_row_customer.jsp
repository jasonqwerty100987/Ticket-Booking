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
				fieldName = "FirstName";
				break;
			case 2:
				fieldName = "LastName";
				break;
			case 3:
				fieldName = "Telephone";
				break;
			case 4:
				fieldName = "City";
				break;
			case 5:
				fieldName = "Email";
				break;
			case 6:
				fieldName = "State";
				break;
			case 7:
				fieldName = "Address";
				break;
			case 8:
				fieldName = "Zipcode";
				break;
			case 9:
				fieldName = "Password";
				break;
			}
			String Content = request.getParameter("desire");
			String username = request.getParameter("username");
			String str = "";
			str = String.format("UPDATE project_336_aws.Customer SET %s = '%s' WHERE (Username = '%s')",fieldName ,Content,username );
			
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome To Train Ticket Purchase Website\n</title>
	</head>
<body>
Welcome CR! Please enter your credential below to log in or press the sign up button to sign up<!-- the usual HTML way -->
						  
<br>

 <!-- Show html form to i) display something, ii) choose an action via a 
  | radio button -->
<!-- forms are used to collect user input 
	The default method when submitting form data is GET.
	However, when GET is used, the submitted form data will be visible in the page address field-->
	<%
	String userName;  
	if (session!= null ){
		if(session.getAttribute("username")!= null && !session.getAttribute("username").equals("")){
			response.sendRedirect("CRGood.jsp");
		}
	}
	%>
<form  action="CRShow.jsp" method="post">
			Login Page
			<br>
			Username:<input type="text" size=25 name="userid">
			<br>
			Password:<input type="text" size=25 name="password">
			<br>
			<input type="submit" value="Sign In" />
</form>


</body>
</html>
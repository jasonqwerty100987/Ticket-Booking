<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CR </title>
</head>
<body>
	<font size = 5>Hello <%= session.getAttribute("FullName") %></font>
	
	<form  action="CRSignout.jsp" method="post">
			<input type="submit" value="Sign Out" />
	</form>
	<form  action="CRViewReservation.jsp" method="post">
			<input type="submit" value="Reservation View" />
	</form>
	<form  action="CRViewTS.jsp" method="post">
			<input type="submit" value="Train Schedule View" />
	</form>
	<form  action="CRMyQuestion.jsp" method="post">
			<input type="submit" value="View Customers Question" />
	</form>
	<form  action="ScheduleByOD.jsp" method="post">
			<input type="submit" value="Schedule By Origin To Destination" />
	</form>
	<form  action="ScheduleByStation.jsp" method="post">
			<input type="submit" value="Schedule By One Station" />
	</form>

</body>
</html>
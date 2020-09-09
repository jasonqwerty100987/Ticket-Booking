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
		
	
	<form  action="searchResult.jsp" method="post">
			Searching Page
			<br>
			origin:<input type="text" size=25 name="origin">
			<br>
			destination:<input type="text" size=25 name="destination">
			<br>
			<br>
			date of travel:<input type="date" value="2020-04-30" size=25 name="date_of_travel">
			<br>
			<input type="radio" name="search" value="1">View All by date
			<br>
			<input type="radio" name="search" value="2">Search with Origin and Destination
			<br>
			Sort by:
			<br>
			<input type="radio" name="sort" value="1">arrival time
			<br>
			<input type="radio" name="sort" value="2">departure time
			<br>
			<input type="radio" name="sort" value="3">origin (This sort works only when view all)
			<br>
			<input type="radio" name="sort" value="4">destination (This sort works only when view all)
			<br>
			<input type="radio" name="sort" value="5">Fare
			<br>
			Order by: (By default ascending)
			<br>
			<input type="radio" name="order" value="1">ascending
			<br>
			<input type="radio" name="order" value="2">descending
			<br>
			<input type="submit" value="Search Now!" />
	</form>
	
	   	<form  action="good.jsp" method="post">
			<input type="submit" value="Back to Home" />
		</form>
</body>
</html>
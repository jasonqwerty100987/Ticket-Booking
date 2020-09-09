<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<font size = 5>Hello <%= session.getAttribute("FullName") %></font>
	<form  action="index.jsp" method="post">
			<input type="submit" value="Refresh" />
	</form>
	<form  action="Signout.jsp" method="post">
			<input type="submit" value="Signout" />
	</form>
	<form  action="search.jsp" method="post">
			<input type="submit" value="Search Now" />
	</form>
	<form  action="ViewReservation.jsp" method="post">
			<input type="submit" value="My Reservation" />
	</form>
	<form  action="CustomerService.jsp" method="post">
			<input type="submit" value="HELP needed? Contact us!" />
	</form>
	<form  action="MyQuestion.jsp" method="post">
			<input type="submit" value="My Question" />
	</form>
</body>
</html>
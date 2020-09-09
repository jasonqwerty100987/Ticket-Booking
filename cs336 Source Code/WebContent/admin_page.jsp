<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>This is admin management page</title>
</head>
<body>
<p> Welcome Admin! </p>
<form action="acc_manage.jsp" method="post">
	<input type="submit" value="Manage Account" />
</form>

<br>
Get sales report:
<form action="sales_report.jsp" method="post">
	Please Specify Month:<input type="date" value="2020-04" size=25 name="report_month">
	<br>
	<input type="submit" value="Get Report" />
</form>

<br>
Get reservations:
<form action="get_reservation.jsp" method="post">
	<input type="radio" name="res_type" value="transit_line">transit line: <input type="text" size=25 name="line_res">
	<br>
	<input type="radio" name="res_type" value="train_num">train number: <input type="text" size=25 name="train_res">
	<br>
	<input type="radio" name="res_type" value="customer_name">First name: <input type="text" size=10 name="first_name">
	Last name: <input type="text" size=10 name="last_name">
	<br>
	<input type="submit" value="Get reservation" />
</form>

<br>
Get Revenue:
<form action="get_revenue.jsp" method="post">
	<input type="radio" name="revenue_type" value="transit_line">transit line: <input type="text" size=25 name="line_revenue">
	<br>
	<input type="radio" name="revenue_type" value="city">destination city: <input type="text" size=25 name="city_revenue">
	<br>
	<input type="radio" name="revenue_type" value="customer_name">First name: <input type="text" size=10 name="first_name_rev">
	Last name: <input type="text" size=10 name="last_name_rev">
	<br>
	<input type="submit" value="Get reservation" />
</form>

<br>
<form action="get_best_customer.jsp" method="post">
	<input type="submit" value="Get best customer" />
</form>

<br>

<form action="get_best_5_line.jsp" method="post">
	<input type="submit" value="Get best 5 line" />
</form>
<br>
<form action="admin_login.jsp" method="post">
	<input type="submit" value="logout" />
</form>
</body>
</html>
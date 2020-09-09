<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<table id = "customer_info" border="1" cellpadding="5">
            <caption><h2>Customer Info</h2></caption>
            <THEAD>
            <tr>
                <th>Username</th>
                <th>FirstName</th>
                <th>LastName</th>
                <th>Telephone</th>
                <th>City</th>
                <th>Email</th>
                <th>State</th>
                <th>Address</th>
                <th>Zipcode</th>
                <th>Password</th>
            </tr>
            </THEAD>
            <TBODY>
            
            <%
            try {
    			
    			//Get the database connection
    			ApplicationDB db = new ApplicationDB();	
    			Connection con = db.getConnection();		
    			//Create a SQL statement
    			Statement stmt = con.createStatement();
    			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
    			String str = String.format("SELECT * FROM project_336_aws.Customer;");
    			//Run the query against the database.
    			ResultSet result = stmt.executeQuery(str);
    			
    			while(result.next()){
    				%>
                    <tr>
                     <%
                     for(int i = 1; i<=10;i++)
                        { %>
                         <td>
                         <%= result.getString(i)%>
                         </td>
                    <% 
                        }
                    
    			}%>
    			<%
    			//close the connection.
    			db.closeConnection(con);
            }
            catch (Exception e) {
    			out.print(e);
    		} %>
            </TBODY>
            </table>
<br>
Username  &nbsp  &nbsp 
FirstName &nbsp&nbsp  &nbsp 
LastName &nbsp &nbsp &nbsp
Telephone  &nbsp &nbsp &nbsp &nbsp
City &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
Email &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
State &nbsp &nbsp &nbsp  &nbsp &nbsp
Address &nbsp &nbsp &nbsp &nbsp 
Zipcode &nbsp &nbsp &nbsp 
Password
<br>

<form  action="add_row_customer.jsp" method="post">
		<input type="text" size=8 name="username">  
	<input type="text" size=8 name="firstname">
	<input type="text" size=8 name="lastname">
	<input type="text" size=8 name="telephone">
	<input type="text" size=8 name="city">
	<input type="text" size=8 name="email">
	<input type="text" size=8 name="state">
	<input type="text" size=8 name="address">
	<input type="text" size=8 name="zipcode">
	<input type="text" size=8 name="password">
	<br>
			<input type="submit" value="add row" />
</form>
<br>
<form  action="delete_row_customer.jsp" method="post">
		Please enter the username you want to delete:<input type="text" size=8 name="username">  
	<br>
			<input type="submit" value="delete row" />
</form>
<br>
<form  action="change_row_customer.jsp" method="post">
		Please enter the username you want to change:<input type="text" size=8 name="username">  
			<br>
			Please choose a column you want to change:<select onchange="GetSelectedValue()" id = 'scroll'>
			<option value = "1" selected>First Name</option>
			<option value = "2">Last Name</option>
			<option value = "3">Telephone</option>
			<option value = "4">City</option>
			<option value = "5">Email</option>
			<option value = "6">State</option>
			<option value = "7">address</option>
			<option value = "8">Zipcode</option>
			<option value = "9">Password</option>
			</select>
			<br>
			Please Enter desired data: <input type = "text" id = "extext" name = "desire" value = ""/>
			<br>
			<input type="submit" value="Edit" />
			<input type = "hidden" id = "es" name = "editSelection" value = "1">
</form>
<script>
function GetSelectedValue(){
	var e = document.getElementById("scroll");
	var result = e.options[e.selectedIndex].value;
	document.getElementById("es").value = result;
}
</script>



<table id = "employee_info" border="1" cellpadding="5">
            <caption><h2>Employee Info</h2></caption>
            <THEAD>
            <tr>
                <th>SSN</th>
                <th>LastName</th>
                <th>FirstName</th>
                <th>Username</th>
                <th>Password</th>
                <th>admin</th>
            </tr>
            </THEAD>
            <TBODY>
            
            <%
            try {
    			
    			//Get the database connection
    			ApplicationDB db = new ApplicationDB();	
    			Connection con = db.getConnection();		
    			//Create a SQL statement
    			Statement stmt = con.createStatement();
    			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
    			String str = String.format("SELECT * FROM project_336_aws.Employee;");
    			//Run the query against the database.
    			ResultSet result = stmt.executeQuery(str);
    			
    			while(result.next()){
    				%>
                    <tr>
                     <%
                     for(int i = 1; i<=6;i++)
                        { %>
                         <td>
                         <%= result.getString(i)%>
                         </td>
                    <% 
                        }
                    
    			}%>
    			<%
    			//close the connection.
    			db.closeConnection(con);
            }
            catch (Exception e) {
    			out.print(e);
    		} %>
            </TBODY>
            </table>
            
<br>
&nbsp &nbsp &nbsp SSN &nbsp &nbsp &nbsp &nbsp &nbsp 
Lastname &nbsp &nbsp &nbsp 
Firstname &nbsp &nbsp 
username &nbsp &nbsp &nbsp 
password &nbsp &nbsp &nbsp
admin &nbsp &nbsp 
<br>

<form  action="add_row_employee.jsp" method="post">
		<input type="text" size=8 name="SSN">  
		<input type="text" size=8 name="lastname">
		<input type="text" size=8 name="firstname">
		<input type="text" size=8 name="username">
		<input type="text" size=8 name="password">
		<input type="text" size=8 name="admin">
		<br>
			<input type="submit" value="add row" />
</form>
<br>
<form  action="delete_row_employee.jsp" method="post">
		Please enter the username you want to delete:<input type="text" size=8 name="username">  
	<br>
			<input type="submit" value="delete row" />
</form>

<br>
<form  action="change_row_employee.jsp" method="post">
		Please enter the SSN you want to delete:<input type="text" size=8 name="SSN">  
			<br>
			Please choose a column you want to change:<select onchange="GetSelectedValue2()" id = 'scroll2'>
			<option value = "1" selected>Last Name</option>
			<option value = "2">First Name</option>
			<option value = "3">Username</option>
			<option value = "4">Password</option>
			<option value = "5">admin</option>
			</select>
			<br>
			Please Enter desired data: <input type = "text" id = "extext" name = "desire" value = ""/>
			<br>
			<input type="submit" value="Edit" />
			<input type = "hidden" id = "es2" name = "editSelection" value = "1">
</form>
<script>
function GetSelectedValue2(){
	var e = document.getElementById("scroll2");
	var result = e.options[e.selectedIndex].value;
	document.getElementById("es2").value = result;
}
</script>



<br>
<form action="admin_page.jsp" method="post">
<input type="submit" value="Back to admin page" />
</form>

</body>
</html>
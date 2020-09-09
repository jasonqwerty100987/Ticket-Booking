<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Customers</title>
</head>
<body>
		

	<div align="center">
		<form action="good.jsp" method="post">
        <table id = "result" border="1" cellpadding="5">
            <caption><h2>Current and past reservations</h2></caption>
            <THEAD>
            <tr>
                
                <th>Username</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Seat Number</th>
                <th>Transit Line Name</th>
                <th>Train ID</th>
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
			//Get the selected radio button from the index.jsp
			String TransitLineName = request.getParameter("TransitLineName");
			String TrainID = request.getParameter("TrainID");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = String.format("SELECT c.Username, c.FirstName, c.LastName, r.Seat_Number, r.TransitLineName, t.TrainID FROM project_336_aws.Customer c JOIN Reservation r ON c.Username = r.Username JOIN Runs R ON R.TransitName = r.TransitLineName JOIN Trains t ON R.TrainID = t.TrainID WHERE r.TransitLineName = '%s' AND t.TrainID = %d;",TransitLineName, TrainID);
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
                %>
    
                                   
                </tr>
            <% 
			}

			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%> </TBODY>
        </table>
        <input type="hidden" name="ReservationNumber" value=""/>
        <input type="submit" value="Go back to home"/>
      </form>
    </div>
	<script>
	</script>
</body>
</html>
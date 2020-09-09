<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
<body>

 

<table id = "sales_report" border="1" cellpadding="5">
            <caption><h2>Sales Report</h2></caption>
            <THEAD>
            <tr>
                <th>ReservationDate</th>
                <th>BookingFee</th>
                <th>Fare</th>
                <th>SSN</th>
                <th>Username</th>
                <th>TransitLineName</th>
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
    			String date = request.getParameter("report_month");
    			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
    			String str = String.format("SELECT ReservationDate,BookingFee,Fare,SSN,Username,TransitLineName FROM project_336_aws.Reservation WHERE ReservationDate like '%s" ,date);
    			str = str+"%';";
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
            
            
            
<form action="admin_page.jsp" method="post">
<input type="submit" value="Back to admin page" />
</form>

</body>
</html>
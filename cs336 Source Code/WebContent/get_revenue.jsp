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

<table id = "revenue_list" border="1" cellpadding="5">
            <caption><h2>revenue List</h2></caption>
            <THEAD>
            <tr>
                <th>BookingFee</th>
                <th>Fare</th>
                <th>SSN</th>
                <th>Username</th>
                <th>StationID</th>
                <th>StationID2</th>
                <th>TransitLineName</th>
            </tr>
            </THEAD>
            <TBODY>

	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String choice = request.getParameter("revenue_type");
		String str = "";
        if(choice.equals("transit_line")){
        	String line_revenue = request.getParameter("line_revenue");
        	str = String.format("SELECT BookingFee, Fare, SSN, Username, StationID, StationID2, TransitLineName FROM project_336_aws.Reservation WHERE TransitLineName = '%s'", line_revenue);
        }
        else if(choice.equals("city")){
        	String city_revenue = request.getParameter("city_revenue");
        	str = String.format("select R.BookingFee, R.Fare, R.SSN, R.Username, R.StationID, R.StationID2, R.TransitLineName FROM project_336_aws.Reservation R, project_336_aws.Stations S WHERE R.stationID2 = S.stationID and S.City = '%s'", city_revenue);
        }
        else if(choice.equals("customer_name")){
        	String firstname = request.getParameter("first_name_rev");
        	String lastname = request.getParameter("last_name_rev");
        	str = String.format("select R.BookingFee, R.Fare, R.SSN, R.Username, R.StationID, R.StationID2, R.TransitLineName FROM project_336_aws.Reservation R, project_336_aws.Customer C WHERE R.Username = C.Username and C.FirstName = '%s' and C.LastName = '%s'", firstname, lastname);
        }
        
        ResultSet result = stmt.executeQuery(str);
		
        while(result.next()){
			%>
            <tr>
             <%
             for(int i = 1; i<=7;i++)
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
		}
	
	
	
	%>
	
<form action="admin_page.jsp" method="post">
<input type="submit" value="Back to admin page" />
</form>

</body>
</html>
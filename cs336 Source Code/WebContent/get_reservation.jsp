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

<table id = "reservation_list" border="1" cellpadding="5">
            <caption><h2>Reservation List</h2></caption>
            <THEAD>
            <tr>
            	<th>ReservationNumber</th>
                <th>ReservationDate</th>
                <th>BookingFee</th>
                <th>Fare</th>
                <th>Seat_Class</th>
                <th>Seat_Number</th>
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
			
			String choice = request.getParameter("res_type");
			String str = "";
            if(choice.equals("transit_line")){
            	String line_res = request.getParameter("line_res");
            	str = String.format("SELECT * FROM project_336_aws.Reservation WHERE TransitLineName = '%s'", line_res);
            }
            else if(choice.equals("train_num")){
            	String train_res = request.getParameter("train_res");
            	str = String.format("select R.ReservationNumber, R.ReservationDate, R.BookingFee, R.Fare, R.Seat_Class, R.Seat_Number, R.SSN, R.Username, R.StationID, R.StationID2, R.TransitLineName FROM project_336_aws.Reservation R, project_336_aws.Runs Rs, project_336_aws.Train_Schedule TS WHERE TS.TransitLineName = Rs.TransitName AND R.TransitLineName = TS.TransitLineName AND Rs.TrainID = '%s';",train_res);
            }
            else if(choice.equals("customer_name")){
            	String firstname = request.getParameter("first_name");
            	String lastname = request.getParameter("last_name");
            	str = String.format("select R.ReservationNumber, R.ReservationDate, R.BookingFee, R.Fare, R.Seat_Class, R.Seat_Number, R.SSN, R.Username, R.StationID, R.StationID2, R.TransitLineName FROM project_336_aws.Reservation R, project_336_aws.Customer C WHERE R.Username = C.Username and C.FirstName = '%s' and C.LastName = '%s'", firstname, lastname);
            }
            
            ResultSet result = stmt.executeQuery(str);
			
            while(result.next()){
				%>
                <tr>
                 <%
                 for(int i = 1; i<=11;i++)
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
	<input type="submit" value="Back to admin Page" />
</form>
			
</body>
</html>
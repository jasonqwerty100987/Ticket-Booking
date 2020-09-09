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

<table id = "best_customer" border="1" cellpadding="5">
            <caption><h2>Best Customer</h2></caption>
            <THEAD>
            <tr>
            	<th>Username</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Total Fare</th>
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
    			
    			
                
                String str = String.format("SELECT C.Username,C.FirstName,C.LastName,Sum(R.Fare) as total_fare FROM project_336_aws.Customer C, project_336_aws.Reservation R  WHERE C.Username = R.Username Group by C.Username Order by Total_fare DESC");
                
                
                ResultSet result = stmt.executeQuery(str);
    			
                while(result.next()){
    				%>
                    <tr>
                     <%
                     for(int i = 1; i<=4;i++)
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
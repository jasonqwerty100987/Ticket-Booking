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

<table id = "top5_line" border="1" cellpadding="5">
            <caption><h2> TOP 5 most active transit lines </h2></caption>
            <THEAD>
            <tr>
            	<th>TransitLineName</th>
                <th>Total Times</th>
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
    			
    			
                
                String str = String.format("SELECT TransitLineName, count(*) as total_time FROM project_336_aws.Reservation GROUP BY TransitLineName ORDER BY total_time DESC LIMIT 5");
                
                
                ResultSet result = stmt.executeQuery(str);
    			
                while(result.next()){
    				%>
                    <tr>
                     <%
                     for(int i = 1; i<=2;i++)
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
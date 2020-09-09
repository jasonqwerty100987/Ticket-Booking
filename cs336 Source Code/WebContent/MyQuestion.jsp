<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Random"%>
<%@ page import="java.util.concurrent.ThreadLocalRandom"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Questions</title>
</head>
<body>
	<div align="center">
		<form action="good.jsp" method="post">
        <table id = "result" border="1" cellpadding="5">
            <caption><h2>Questions and Answers browsing</h2></caption>
            <THEAD>
            <tr>
                <th>Questions ID</th>
                <th>Your Questions</th>
                <th>Answers</th>
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
			String question = request.getParameter("question");
			if(question != null){
				String Username = (String)session.getAttribute("username");
				
				ThreadLocalRandom random = ThreadLocalRandom.current();
				long QAID = random.nextLong(100000000L, 1000000000L);
				
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str = String.format("INSERT INTO QA(QAID,Question,Username) VALUES(%d,'%s','%s')",QAID, question, Username);
				//Run the query against the database.
				stmt.executeUpdate(str);
				//close the connection.
				String str1 = String.format("SELECT Q.QAID, Q.Question, Q.Answer FROM project_336_aws.QA Q WHERE Username='%s';",Username);
				//Run the query against the database.
				stmt.executeQuery(str1);
				ResultSet result = stmt.executeQuery(str1);
				while(result.next()){
					%>
	                <tr>
	                 <%
	                 for(int i = 1; i<=3;i++)
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
			}else{
				String Username = (String)session.getAttribute("username");
				ThreadLocalRandom random = ThreadLocalRandom.current();
				long QAID = random.nextLong(100000000L, 1000000000L);
				String str1 = String.format("SELECT Q.QAID, Q.Question, Q.Answer FROM project_336_aws.QA Q WHERE Username='%s';",Username);
				//Run the query against the database.
				stmt.executeQuery(str1);
				ResultSet result = stmt.executeQuery(str1);
				while(result.next()){
					%>
	                <tr>
	                 <%
	                 for(int i = 1; i<=3;i++)
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
			}
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%> </TBODY>
	</table>
	</form>
	</div>
	   	<form  action="good.jsp" method="post">
			<input type="submit" value="Back to Home" />
		</form>
</body>
</html>
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
<title>CR Questions</title>
</head>
<body>
	<div align="center">
		<form action="PostCRAns.jsp" method="post">
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
				
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				//close the connection.
				String str1 = String.format("SELECT Q.QAID, Q.Question, Q.Answer FROM project_336_aws.QA Q;");
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
				db.closeConnection(con);
			
		} catch (Exception e) {
			out.print(e);
		}
	%> </TBODY>
	</table>
	
	<input type = "text" name = "ans" value = "">
	<input type= "submit" value = "Answer Now">
	<input type = "hidden" name = "Qid" value = "">
	</form>
	<br>Selected Question ID:
	<label id="QID"></label>
	
	</div>
		<form  action="CRViewReservation.jsp" method="post">
			<input type="submit" value="Reservation View" />
	</form>
	<form  action="CRViewTS.jsp" method="post">
			<input type="submit" value="Train Schedule View" />
	</form>
	<form  action="CRMyQuestion.jsp" method="post">
			<input type="submit" value="View Customers Question" />
	</form>
	   	<form  action="CRGood.jsp" method="post">
			<input type="submit" value="Back to Home" />
		</form>
		
		<script>
		(function () {
    if (window.addEventListener) {
        window.addEventListener('load', run, false);
    } else if (window.attachEvent) {
        window.attachEvent('onload', run);
    }

    function run() {
        var t = document.getElementById('result');
        t.onclick = function (event) {
            event = event || window.event; 
            var target = event.target || event.srcElement;
            while (target && target.nodeName != 'TR') {
                target = target.parentElement;
            }
            var cells = target.cells; 
            if (!cells.length || target.parentNode.nodeName == 'THEAD') {
                return;
            }
            var f1 = document.getElementById('QID');
            f1.innerHTML = cells[0].innerHTML;
            var inputs = document.getElementsByTagName("input"), len = inputs.length, i;
            for (i = 0; i < len; i++) {
                if (inputs[i].name == "Qid") {
                    inputs[i].value = cells[0].innerHTML;
                    break;
                }
            }
            
        };
    }

})();
	</script>
</body>
</html>
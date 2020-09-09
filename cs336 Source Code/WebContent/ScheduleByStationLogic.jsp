<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head><title>Schedules</title></head>
<body>
	<form method="get" action="CRIndex.jsp">
		<button type="submit">Home</button>
	</form>
	<p id="demo"></p>
	<h3>Results for station <%=request.getParameter("point")%>:</h3>
	
	<%
	String back = "<form method=\"get\" action=\"ScheduleByStation.jsp\"><button type=\"submit\" id=\"button2\">Back</button></form>";
	out.print(back);
	
		try{
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement(
				"SELECT t.TransitLineName, t.DepartureTime, t.DepartureDate, t.TravelTime FROM Train_Schedule t, Stations s WHERE t.Stops=s.StationID AND s.StationID = ?"
			);
			String P = request.getParameter("point");
			ps.setString(1, P);
			ResultSet rs = ps.executeQuery();%>
				<table border='1' id="table">
					<tr>
						<th>Line Name</th>
						<th>Train ID</th>
						<th>Starting Time</th>
						<th>Schedule Date</th>
						<th></th>
						<th></th>
					</tr>
					<%while (rs.next()) {
					%>
						<tr>
							<td>
								<%String a = rs.getString("t.TransitLineName");
								out.print(a);%>
							</td>
							<td>
								<%String c = rs.getString("t.DepartureTime");
								out.print(c);%>
							</td>
							<td>
								<%String d = rs.getString("t.DepartureDate");
								out.print(d);%>
							</td>
						</tr>
					<%}%>
				</table>
				<script>
				    function sort(j) { 
				        var table, i, x, y; 
				        table = document.getElementById("table"); 
				        var switching = true; 
				
				        while (switching) { 
				            switching = false; 
				            var rows = table.rows; 
				            
				            for (i = 1; i < (rows.length - 1); i++) { 
				                var makeSwitch = false; 
				                x = rows[i].getElementsByTagName("TD")[j]; 
				                y = rows[i + 1].getElementsByTagName("TD")[j]; 
				
				                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()){ 
				                    makeSwitch = true; 
				                    break; 
				                } 
				            } 
				            if (makeSwitch) { 
				                // Function to switch rows and mark switch as completed 
				                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]); 
				                switching = true; 
				            } 
				        } 
				    } 
				</script>
			<%conn.close();
		}catch(Exception e){
			System.out.println(e);
		}%>
	
	<br>
	
	<form method="get" action="ScheduleByStation.jsp">
		<button type="submit">Search another trip</button>
	</form>
	

</body>
</html>
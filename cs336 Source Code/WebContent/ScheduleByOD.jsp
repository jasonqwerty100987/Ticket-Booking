<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Schedules by Origin and Destination</title>
</head>
<body>
	<%
		//get date
		java.util.Date utilDate = new java.util.Date();
		// Convert it to java.sql.Date
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	%>
	<form method="get" action="CRIndex.jsp">
		<button type="submit">Home</button>
	</form>
	<div id = "wrapper">
		<div id = "browseSquare">
			<div id = "browseText">
				<h3>Search schedules by station:</h3>
				<!--drop down select current origins/destinations in db-->
				<%
				    try{
						ApplicationDB db = new ApplicationDB();
						Connection conn = db.getConnection();
						PreparedStatement o = conn.prepareStatement("SELECT StationID FROM Stations");
						ResultSet os = o.executeQuery();
						PreparedStatement d = conn.prepareStatement("SELECT StationID FROM Stations");
						ResultSet ds = d.executeQuery();
				%>
				<form action="ScheduleByODLogic.jsp" class="browse">
					<div class = "browse">
					    Origin StationID: <select name="point1">
						    <%  while(os.next()){ %>
						        <option><%= os.getString(1)%></option>
						    <% } %>
					    </select>
					    Destination StationID: <select name="point2">
					    	<% while(ds.next()){ %>
					    		<option><%= ds.getString(1) %></option>
					    	<% } %>
					    </select>
					</div>
					<br>
					<button type="submit" id = "button" >View Schedules</button>
				</form>
				<%}
			        catch(Exception e)
					{
			               out.println(e);
			          }
			  	%>
			</div>
		</div>
	</div>

</body>
</html>
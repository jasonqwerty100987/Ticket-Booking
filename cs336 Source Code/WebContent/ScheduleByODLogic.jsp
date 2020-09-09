<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head><title>Schedules</title></head>
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
	<p id="demo"></p>
	<h3>Results for <%=request.getParameter("point1")%> to <%=request.getParameter("point2")%>:</h3>
	
	
	<%
	String back = "<form method=\"get\" action=\"ScheduleByOD.jsp\"><button type=\"submit\" id=\"button2\">Back</button></form>";
	out.print(back);
	
		try{
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement(
					"SELECT t.TransitLineName, t.DepartureTime, t.DepartureDate, t.TravelTime FROM Train_Schedule t, Stations s WHERE t.Stops=s.StationID AND s.StationID = ?"
			);
			String B = request.getParameter("point2");
			ps.setString(1, B);
			String A = request.getParameter("point1");
			ps.setString(1, A);
			ResultSet rs = ps.executeQuery();%>
				<table border='1' id="table">
					<tr>
						<th>Line Name/Stops</th>
						<th>Starting Time</th>
						<th>Schedule Date</th>
						<th></th>
					</tr>
					<%while (rs.next()) {%>
						<tr>
							<td>
								<%=rs.getString("t.TransitLineName")%>
							</td>
							<td>
								<%=rs.getString("t.DepartureTime")%>
							</td>
							<td>
								<%=rs.getString("t.DepartureDate")%>
							</td>
							<td>
								<form method="get" action="CRViewReservation.jsp">
									<button type="submit">Edit</button>
								</form>
							</td>
							<td>
								<form method="get" action="CRViewReservation.jsp">
									<button type="submit">Delete</button>
								</form>
							</td>
						</tr>
					<%}%>
				</table>
			<%conn.close();
		}catch(Exception e){
			System.out.println(e);
		}%>
	
	<br>
	
	<form method="get" action="ScheduleByOD.jsp">
		<button type="submit">Search another trip</button>
	</form>
	

</body>
</html>
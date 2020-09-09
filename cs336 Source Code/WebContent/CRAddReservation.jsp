<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Random"%>
<%@ page import="java.util.concurrent.ThreadLocalRandom"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reserve Successfully!</title>
</head>
<body>
<p>Reserve Successfully!</p>
<form  action="CRViewReservation.jsp" method="post" name="ReserveFrom">
	<center><input type="submit" value="review"/></center>
</form>
	<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String Username = request.getParameter("Username");
			
			String Begin = request.getParameter("Origin");
			String End = request.getParameter("Destination");
			
			String str = String.format("Select StationID from project_336_aws.Stations where Name = '%s'",Begin);
			System.out.println(Begin);
			ResultSet result = stmt.executeQuery(str);
			int BeginID;
			if(result.next()){
				BeginID = result.getInt("StationID");
			}else{
				throw new Exception("no begin detected.");
			}
			String str1 = String.format("Select StationID from project_336_aws.Stations where Name = '%s'",End);
			ResultSet result1 = stmt.executeQuery(str1);
			int EndID;
			if(result1.next()){
				EndID = result1.getInt("StationID");
			}else{
				throw new Exception("no end detected.");
			}
			
			String TransitLineName = request.getParameter("Route");
			
			String ReservationDate = request.getParameter("Departure");
			String Arrival = request.getParameter("Arrival");
			//Calendar time = Calendar.getInstance();
			//java.sql.Timestamp ReservationDate = new java.sql.Timestamp(time.getTime().getTime());
			
			ThreadLocalRandom random = ThreadLocalRandom.current();
			long ReservationNumber = random.nextLong(10000000000L, 100000000000L);
			
			double BookingFee = 10.25;
			
			String Discount = request.getParameter("discount");
			if(Discount.equals("Senior_Discount")){
				Discount = "Senior";
			}else if(Discount.equals("Disabled_Discount")){
				Discount = "Disabled";
			}else if(Discount.equals("Children_Discount")){
				Discount = "Children";
			}
				
			String Way = request.getParameter("way");
			
			if(Way.equals("One-Way")){
				Way = "OneWay";
			}else if(Way.equals("Round-trip")){
				Way = "RoundTrip";
			}else if(Way.equals("Monthly")){
				Way = "MonthlyFare";
			}else if(Way.equals("Weekly")){
				Way = "WeeklyFare";
			}
			
			double Fare = 0;
			if(Way.equals("One-Way")){
				String temp = String.format("SELECT OneWay from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
				ResultSet OneWay = stmt.executeQuery(temp);
				double OneWayFee;
				if(OneWay.next()){
					OneWayFee = OneWay.getDouble(1);
				}else{
					throw new Exception("no fare detected.");
				}
				if(Discount == "Senior"){
					String temp2 = String.format("SELECT Senior_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Senior = stmt.executeQuery(temp2);
					double Senior_Discount;
					if(Senior.next()){
						Senior_Discount = Senior.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = OneWayFee*Senior_Discount;
				}else if(Discount == "Disabled"){
					String temp2 = String.format("SELECT Disabled_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Disabled = stmt.executeQuery(temp2);
					double Disabled_Discount;
					if(Disabled.next()){
						Disabled_Discount = Disabled.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = OneWayFee*Disabled_Discount;
				}else if(Discount == "Child"){
					String temp2 = String.format("SELECT Children_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Children = stmt.executeQuery(temp2);
					double Children_Discount;
					if(Children.next()){
						Children_Discount = Children.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = OneWayFee*Children_Discount;
				}
			}else if (Way.equals("Round-trip")){
				String temp = String.format("SELECT RoundTrip from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
				ResultSet RoundTrip = stmt.executeQuery(temp);
				double RoundTripFee;
				if(RoundTrip.next()){
					RoundTripFee = RoundTrip.getDouble(1);
				}else{
					throw new Exception("no fare detected.");
				}
				if(Discount == "Senior"){
					String temp2 = String.format("SELECT Senior_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Senior = stmt.executeQuery(temp2);
					double Senior_Discount;
					if(Senior.next()){
						Senior_Discount = Senior.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = RoundTripFee*Senior_Discount;
				}else if(Discount == "Disabled"){
					String temp2 = String.format("SELECT Disabled_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Disabled = stmt.executeQuery(temp2);
					double Disabled_Discount;
					if(Disabled.next()){
						Disabled_Discount = Disabled.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = RoundTripFee*Disabled_Discount;
				}else if(Discount == "Children"){
					String temp2 = String.format("SELECT Children_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Children = stmt.executeQuery(temp2);
					double Children_Discount;
					if(Children.next()){
						Children_Discount = Children.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = RoundTripFee*Children_Discount;
				}
			}else if (Way.equals("Monthly")){
				String temp = String.format("SELECT MonthlyFare from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
				ResultSet MonthlyFare = stmt.executeQuery(temp);
				double MonthlyFareFee;
				if(MonthlyFare.next()){
					MonthlyFareFee = MonthlyFare.getDouble(1);
				}else{
					throw new Exception("no fare detected.");
				}
				if(Discount == "Senior"){
					String temp2 = String.format("SELECT Senior_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Senior = stmt.executeQuery(temp2);
					double Senior_Discount;
					if(Senior.next()){
						Senior_Discount = Senior.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = MonthlyFareFee*Senior_Discount;
				}else if(Discount == "Disabled"){
					String temp2 = String.format("SELECT Disabled_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Disabled = stmt.executeQuery(temp2);
					double Disabled_Discount;
					if(Disabled.next()){
						Disabled_Discount = Disabled.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = MonthlyFareFee*Disabled_Discount;
				}else if(Discount == "Children"){
					String temp2 = String.format("SELECT Children_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet Children = stmt.executeQuery(temp2);
					double Children_Discount;
					if(Children.next()){
						Children_Discount = Children.getDouble(1);
					}else{
						throw new Exception("no discount detected.");
					}
					Fare = MonthlyFareFee*Children_Discount;
					}
				}else if (Way.equals("Weekly")){
					String temp = String.format("SELECT WeeklyFare from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
					ResultSet WeeklyFare = stmt.executeQuery(temp);
					double WeeklyFareFee;
					if(WeeklyFare.next()){
						WeeklyFareFee = WeeklyFare.getDouble(1);
					}else{
						throw new Exception("no fare detected.");
					}
					if(Discount == "Senior"){
						String temp2 = String.format("SELECT Senior_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
						ResultSet Senior = stmt.executeQuery(temp2);
						double Senior_Discount;
						if(Senior.next()){
							Senior_Discount = Senior.getDouble(1);
						}else{
							throw new Exception("no discount detected.");
						}
						Fare = WeeklyFareFee*Senior_Discount;
					}else if(Discount == "Disabled"){
						String temp2 = String.format("SELECT Disabled_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
						ResultSet Disabled = stmt.executeQuery(temp2);
						double Disabled_Discount;
						if(Disabled.next()){
							Disabled_Discount = Disabled.getDouble(1);
						}else{
							throw new Exception("no discount detected.");
						}
						Fare = WeeklyFareFee*Disabled_Discount;
					}else if(Discount == "Children"){
						String temp2 = String.format("SELECT Children_Discount from project_336_aws.Fare WHERE Fare.TransitLineName = '%s' AND Fare.Begin = '%d' AND Fare.End = '%d';",TransitLineName, BeginID, EndID);
						ResultSet Children = stmt.executeQuery(temp2);
						double Children_Discount;
						if(Children.next()){
							Children_Discount = Children.getDouble(1);
						}else{
							throw new Exception("no discount detected.");
						}
						Fare = WeeklyFareFee*Children_Discount;
						}
					}
			
			String Seat_Class;
			Random rand = new Random();
			Seat_Class = request.getParameter("Seat_Class");
			
			String temp3 = String.format("SELECT * FROM project_336_aws.Seat_Number_Template a WHERE NOT EXISTS ( SELECT 1 FROM project_336_aws.Reservation b WHERE b.Seat_Number = a.Seat_Number AND b.TransitLineName='Route 1') limit 1;");
			ResultSet Seat_Num = stmt.executeQuery(temp3);
			
			String Seat_Number;
			if(Seat_Num.next()){
				Seat_Number = Seat_Num.getString(1);
			}else{
				throw new Exception("no Seat Number detected.");
			}
			
			String temp1 = String.format("SELECT SSN from project_336_aws.CustormerRepresentative;");
			ResultSet RoundTrip = stmt.executeQuery(temp1);
			Random rand1 = new Random();
			int SSN;
			for(int i=0;i<rand1.nextInt(2)+1;i++){
				RoundTrip.next();
				
			}
			
				SSN = RoundTrip.getInt(1);
			TransitLineName = TransitLineName.trim().replaceAll(" +", " ");
			ReservationDate = ReservationDate.trim().replaceAll(" +", " ");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String temp2 = String.format("INSERT INTO project_336_aws.Reservation(ReservationNumber, ReservationDate, BookingFee, Fare, Seat_Class, Seat_Number, SSN, Username, StationID, StationID2, TransitLineName) VALUES(%d,'%s', %f, %f, '%s', '%s', %d, '%s', %d, %d,'%s');",ReservationNumber, ReservationDate, BookingFee, Fare, Seat_Class, Seat_Number, SSN, Username, BeginID, EndID, TransitLineName);
			//stmt.executeUpdate(temp2);
			System.out.println(temp2);
			//Run the query against the database.
			Calendar calendar = Calendar.getInstance();
			
			if(stmt.executeUpdate(temp2)>0){
				String abc =String.format("Mr.%s makes a reservation on %s for the route from %s station on %s to %s Station %s. ",session.getAttribute("FullName"),calendar.getTime(),Begin, ReservationDate, End, Arrival);
				%>
				<p><%= abc %> </p>
				<%
			}
			//close the connection.
			db.closeConnection(con);
			
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>
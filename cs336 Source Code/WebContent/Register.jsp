<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<title> Register Page </title>
	</head>
	<body>
	<form  action="RegisterProcess.jsp" method="post" name="RegisterFrom">
		<table width="60%" bgcolor="66CCFF" align="center">
		<tr>
			<td colspan="4"><center><font size=6><b>Create account</b></font></center></td>
		</tr>
		<tr>
			<td>Username:*</td>
			<td><input type="text" size=25 name="Username" id="Username" onchange="Validateusername()"><label id="UserText"></label></td>
		</tr>
		<tr>
			<td>(For Test Purpose, Currently Optional)Email:</td>
			<td><input type="text" size=25 name = "Email" id="Email" onchange="ValidateEmail()"><label id="EmailText"></label></td>
		</tr>
		<tr>
			<td>Password:*</td>
			<td><input type="text" size=25 name="Password" id="Password" onchange="IsEmptyPassword()"><label id="PassText"></label></td>
		</tr>
		<tr>
			<td>Re-enter password:*</td>
			<td><input type="text" size=25 name="Re-enter-password" id="Re-enter-password" onchange="ValidateReenter()"><label id="RePassText"></label></td>
		</tr>
		<tr>
			<td>(For Test Purpose, Currently Optional)FirstName:</td>
			<td><input type="text" size=25 name="FirstName" id="FirstName" onchange="IsEmptyPassword()"></td>
		</tr>
		<tr>
			<td>(For Test Purpose, Currently Optional)LastName:</td>
			<td><input type="text" size=25 name="LastName" id="LastName" onchange="IsEmptyPassword()"></td>
		</tr>
		<tr>
			<td>(For Test Purpose, Currently Optional)Telephone:</td>
			<td><input type="text" size=25 name="Telephone" id="Telephone" onchange="IsEmptyPassword()"></td>
		</tr>
		<tr>
			<td>(For Test Purpose, Currently Optional)City:</td>
			<td><input type="text" size=25 name="City" id="City" onchange="IsEmptyPassword()"></td>
		</tr>
		<tr>
			<td>(For Test Purpose, Currently Optional)State:</td>
			<td><input type="text" size=25 name="State" id="State" onchange="IsEmptyPassword()"></td>
		</tr>
		<tr>
			<td>(For Test Purpose, Currently Optional)Address:</td>
			<td><input type="text" size=25 name="Address" id="Address" onchange="IsEmptyPassword()"></td>
		</tr>
		<tr>
			<td>(For Test Purpose, Currently Optional)ZipCode:</td>
			<td><input type="text" size=25 name="ZipCode"><label id="male">Only 5 digits Zipcode is acceptable</label></td>
		</tr>
	</table>
	<center><input type="submit" value="register"/></center>
</form>

<center><p>Already have an account?</p></center>
<br>
<form action="index.jsp" method="post">
    <center><input type="submit" value="SignIn" 
         name="SignIn" id="frm1_submit" /></center> 
</form>
<script type="text/javascript">
document.getElementById("Email").addEventListener("keydown", ValidateEmail);
document.getElementById("Username").addEventListener("keydown", Validateusername);
document.getElementById("Password").addEventListener("keydown", IsEmptyPassword);
document.getElementById("Re-enter-password").addEventListener("keydown", ValidateReenter);


function ValidateReenter(){
	if(document.getElementById("Password").value != document.getElementById("Re-enter-password").value){
		document.getElementById("Re-enter-password").style.backgroundColor = "tomato";
		document.getElementById("RePassText").innerHTML = "Not The Same";
	}else{
		document.getElementById("Re-enter-password").style.backgroundColor = "white";
		document.getElementById("RePassText").innerHTML = "";
	}
}

function IsEmptyPassword(){
	if(document.getElementById("Password").value.length > 20){
		document.getElementById("Password").style.backgroundColor = "tomato";
		document.getElementById("PassText").innerHTML = "Too Long(Do not exceed 20 characters)";
	}else{
		document.getElementById("PassText").innerHTML = "";
		document.getElementById("Password").style.backgroundColor = "white";
	}
}


function Validateusername(){
	if(document.getElementById("Username").value.length > 20){
		document.getElementById("Username").style.backgroundColor = "tomato";
		document.getElementById("UserText").innerHTML = "Too Long(Do not exceed 20 characters)";
	}else{
		document.getElementById("UserText").innerHTML = "";
		document.getElementById("Username").style.backgroundColor = "white";
	}
}

function ValidateEmail() {
  var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;
	if(document.getElementById('Email').value.match(mailformat)){
		document.getElementById("Email").style.backgroundColor = "white";
		document.getElementById("EmailText").innerHTML = "";
	}else{
		document.getElementById("Email").style.backgroundColor = "tomato";
		document.getElementById("EmailText").innerHTML = "Wrong Email Format, Please check!";
	}
}
</script>

</body>
</html>

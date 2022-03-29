<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.clothes.demo.models.customer.CustomerDetails"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Profile</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Profile Card -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- End -->
<!-- Links for Error messages -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Links for Error messages end-->
<style>
.card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	max-width: 300px;
	margin: auto;
	text-align: center;
	font-family: arial;
}

.card .title {
	color: grey;
	font-size: 18px;
}

.card button {
	border: none;
	outline: 0;
	display: inline-block;
	padding: 8px;
	color: white;
	background-color: #000;
	text-align: center;
	cursor: pointer;
	width: 100%;
	font-size: 18px;
}

.card a {
	text-decoration: none;
	font-size: 22px;
	color: black;
}

.card button:hover, .card a:hover {
	opacity: 0.7;
}
</style>


</head>
<body>

	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // this is for HTTP version 1.1 not work for lesser version
	response.setHeader("Pragma", "no-cache"); // this is for HTTP version 1.0
	response.setHeader("Expires", "0"); // this is for proxies server
	%>

	<!-- Navbar -->
	<%@include file="../navfooter/navbar.jsp"%>
	<!-- Navbar end -->

	<!-- Error Handling -->
	<%
	 String error_message = (String)session.getAttribute("ERROR");
	 String success_message = (String)session.getAttribute("SUCCESS");
	%>
	<% if(null != error_message){%>
		<div class="alert alert-danger alert-dismissible fade show" role="alert">
  			<strong><%= error_message %></strong>
  			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	<%
	session.removeAttribute("ERROR");
	}else if(null != success_message){ 
	%>
		<div class="alert alert-success alert-dismissible fade show" role="alert">
  			<strong><%= success_message %></strong>
  			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	<%
	session.removeAttribute("SUCCESS");
	} %>
	<!-- Error Handling -->

	<%
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	Long cid = customer.getCustomer_id();
	String cimage = customer.getProfile_image();
	String cname = customer.getCustomer_name();
	String emailid = customer.getCustomer_email_id();
	String contact = customer.getCustomer_contact_number();
	String dob = formatter.format(customer.getCustomer_dob());
	String joiningdate = formatter.format(customer.getCustomer_joiningdate());
	%>
	<br><br>
	<h2 style="text-align: center">My Profile</h2>
	<div class="card">
		<img src="<%=cimage%>" alt="profilepic" style="width: 100%">
		<h1><%=cname%></h1>
		<p class="title"><%=emailid%></p>
		<p class="title"><%=contact%></p>
		<p class="title">
			DOB :-
			<%=dob%></p>
		<p class="title">
			Joining Date :-
			<%=joiningdate%></p>
		<!-- Edit Details -->
		<div class="w3-container">
			<button
				onclick="document.getElementById('editprofile').style.display='block'"
				class="w3-button w3-black">Edit</button>

			<div id="editprofile" class="w3-modal">
				<div class="w3-modal-content w3-animate-zoom w3-card-4">
					<header class="w3-container w3-black">
						<span
							onclick="document.getElementById('editprofile').style.display='none'"
							class="w3-button w3-display-topright">&times;</span>
						<h2>Edit Profile</h2>
					</header>
					<form action="fashion-factory/editProfile" method="post">
						<div class="w3-container w3-grey">
							<br> 
							<input type="number" name="customer_id" value="<%=cid%>" hidden="hidden" required>
							<input type="text" name="customer_name" placeholder="Name" value="<%=cname%>" pattern="[A-Za-z0-9]+" title="Only Characters Accepted">
							<input type="url" name="profile_image" placeholder="Enter Profile Url" value="<%=cimage%>">
							<input type="email" name="customer_email_id" placeholder="Enter Email Address" value="<%=emailid%>">
							<input type="tel" name="customer_contact_number" placeholder="Enter Contact Numer" value="<%=contact%>" pattern="[6789][0-9]{9}" title="mobile number should be 10 digit only and started with 6,7,8 or 9 digit otherwise not valid">
							<input type="date" name="customer_dob" placeholder="Enter Date of Birth" value="<%=dob%>">
							<%-- <input type="date" name="customer_joiningdate" placeholder="Enter Joining Date" value="<%=joiningdate%>"> --%>
							
							<button type="submit">Edit Profile</button>
						</div>
						<footer class="w3-container w3-black">
							<button type="button"
								onclick="document.getElementById('editprofile').style.display='none'"
								class="cancelbtn">Cancel</button>
						</footer>
					</form>
				</div>
			</div>
		</div>
		

		<div class="w3-container">
			<button
				onclick="document.getElementById('deleteprofile').style.display='block'"
				class="w3-button w3-black">Delete Account</button>

			<div id="deleteprofile" class="w3-modal">
				<div class="w3-modal-content w3-animate-opacity w3-card-4">
					<header class="w3-container w3-red">
						<span
							onclick="document.getElementById('deleteprofile').style.display='none'"
							class="w3-button w3-display-topright">&times;</span>
						<h2>Delete Account?</h2>
					</header>
					<form action="fashion-factory/deleteProfile" method="post">
						<div class="w3-container w3-red">
							<br> 
							<input type="number" name="customer_id" value="<%=cid%>" hidden="hidden" required>
							<input type="email" name="customer_email_id" placeholder="Enter Email Id">
							<input type="password" name="password" placeholder="Enter Password">
							
							<button type="submit">Delete Profile</button>
						</div>
						<footer class="w3-container w3-red">
							<button type="button"
								onclick="document.getElementById('deleteprofile').style.display='none'"
								class="cancelbtn">Cancel</button>
						</footer>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- Footer -->
	<%@include file="../navfooter/footer.jsp"%>
	<!-- Footer end -->
</body>
</html>
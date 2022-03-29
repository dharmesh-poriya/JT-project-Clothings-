<%@page import="com.clothes.demo.models.vendor.BillingAddress"%>
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
	Long vid = vendor.getVendor_id();
	String simage = vendor.getImage();
	String vname = vendor.getVendor_name();
	String emailid = vendor.getVendor_email_id();
	String contact = vendor.getVendor_contact_number();
	String shopname = vendor.getVendor_shop_name();
	String joiningdate = formatter.format(vendor.getVendor_joiningdate());
	
	BillingAddress baddress = vendor.getBilling_address();
	Long bid = baddress.getAid();
	String hno = baddress.getHouse_no();
	String street = baddress.getStreet();
	String city = baddress.getCity();
	String district = baddress.getDistrict();
	String state = baddress.getState();
	String pincode = baddress.getPincode();
	
	String billingaddress = hno + ", " + street + ", " + city + ", " + district + ", " + state + ", " + pincode + ".";
	%>
	<br>
	<h2 style="text-align: center">My Profile</h2>
	<br>
	<div class="card">
		<img src="<%=simage%>" alt="profilepic" style="width: 100%">
		<hr style="border: 2px solid black;">
		<h1><%=shopname%></h1>
		<hr style="border: 2px solid black;">
		<p class="title"><%=vname %></p>
		<p class="title"><%=emailid%></p>
		<p class="title"><%=contact%></p>
		<p class="title"></p>
		<p class="title">Joining Date :- <%=joiningdate%></p>
		<hr style="border: 2px solid black;">
		<p class="title">Billing Address :- <%=billingaddress%></p>
		<hr style="border: 2px solid black;">
		<!-- Edit Details -->
		<div class="w3-container">
			<button
				onclick="document.getElementById('editvendorprofile').style.display='block'"
				class="w3-button w3-black">Edit Profile</button>

			<div id="editvendorprofile" class="w3-modal">
				<div class="w3-modal-content w3-animate-right w3-card-4">
					<header class="w3-container w3-black">
						<span
							onclick="document.getElementById('editvendorprofile').style.display='none'"
							class="w3-button w3-display-topright">&times;</span>
						<h2>Edit Profile</h2>
					</header>
					<form action="fashion-factory/editVendorProfile" method="post">
						<div class="w3-container w3-grey">
							<br> 
							<input type="number" name="vendor_id" value="<%=vid%>" hidden="hidden" required>
							<input type="text" name="vendor_name" placeholder="Name" value="<%=vname%>" pattern="[A-Za-z0-9]+" title="Only Characters Accepted">
							<input type="text" name="vendor_shop_name" placeholder="Shop Name" value="<%=shopname%>" required>
							<input type="url" name="image" placeholder="Enter Shop Photo" value="<%=simage%>">
							<input type="email" name="vendor_email_id" placeholder="Enter Email Address" value="<%=emailid%>">
							<input type="tel" name="vendor_contact_number" placeholder="Enter Contact Number" value="<%=contact%>" pattern="[6789][0-9]{9}" title="mobile number should be 10 digit only and started with 6,7,8 or 9 digit otherwise not valid">
							<button type="submit">Save Changes</button>
						</div>
						<footer class="w3-container w3-black">
							<button type="button"
								onclick="document.getElementById('editvendorprofile').style.display='none'"
								class="cancelbtn">Cancel</button>
						</footer>
					</form>
				</div>
			</div>
		</div>
		<!-- Edit Billing Address -->
		<div class="w3-container">
			<button
				onclick="document.getElementById('editbillingaddress').style.display='block'"
				class="w3-button w3-black">Edit Billing Address</button>

			<div id="editbillingaddress" class="w3-modal">
				<div class="w3-modal-content w3-animate-left w3-card-4">
					<header class="w3-container w3-black">
						<span
							onclick="document.getElementById('editbillingaddress').style.display='none'"
							class="w3-button w3-display-topright">&times;</span>
						<h2>Edit Billing Address</h2>
					</header>
					<form action="fashion-factory/editBillingAddress" method="post">
						<div class="w3-container w3-grey">
							<br> 
							<input type="number" name="aid" value="<%=bid%>" hidden="hidden" required>
							<input type="number" name="vendor_id" value="<%=vid%>" hidden="hidden" required>
							<input type="text" name="house_no" placeholder="House No." value="<%=hno%>">
							<input type="text" name="street" placeholder="Street" value="<%=street%>" required>
							<input type="text" name="city" placeholder="City" value="<%=city%>">
							<input type="text" name="district" placeholder="District" value="<%=district%>">
							<input type="text" name="state" placeholder="state" value="<%=state%>">
							<input type="text" name="pincode" placeholder="Pincode" value="<%=pincode%>">
							<button type="submit">Save Changes</button>
						</div>
						<footer class="w3-container w3-black">
							<button type="button"
								onclick="document.getElementById('editbillingaddress').style.display='none'"
								class="cancelbtn">Cancel</button>
						</footer>
					</form>
				</div>
			</div>
		</div>
	</div>

<br><br>
	<!-- Footer -->
	<%@include file="../navfooter/footer.jsp"%>
	<!-- Footer end -->
</body>
</html>
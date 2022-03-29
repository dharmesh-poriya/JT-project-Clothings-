<%@page import="com.clothes.demo.models.vendor.BillingAddress"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<!-- Links for Error messages -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Links for Error messages end-->
<style>
@charset "ISO-8859-1";
.sellergallery .content h3 {
	text-align: center;
	font-size: 30px;
	margin: 0;
	padding-top: 10px;
}

.sellergallery .content a {
	text-decoration: none;
}

.sellergallery {
	display: flex;
	flex-wrap: wrap;
	width: 100%;
	justify-content: center;
	align-items: center;
	margin: 50px 0;
}

.sellergallery .content  {
	width: 24%;
	margin: 15px;
	box-sizing: border-box;
	float: left;
	text-align: center;
	border-radius: 10px;
	border-top-right-radius: 10px;
	border-bottom-right-radius: 10px;
	padding-top: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	transition: .4s;
}

.sellergallery .content:hover {
	box-shadow: 0 0 11px rgba(33, 33, 33, .2);
	transform: translate(0px, -8px);
	transition: .6s;
}

.sellergallery .content img {
	width: 200px;
	height: 200px;
	text-align: center;
	margin: 0 auto;
	display: block;
}

.sellergallery .content p {
	text-align: center;
	color: #b2bec3;
	padding: 0 8px;
	font-weight: bold;
}

.sellergallery .content h6 {
	font-size: 26px;
	text-align: center;
	color: #222f3e;
	margin: 0;
}

.sellergallery .content button {
	text-align: center;
	font-size: 24px;
	color: #fff;
	width: 100%;
	padding: 15px;
	border: 0px;
	outline: none;
	cursor: pointer;
	margin-top: 5px;
	border-bottom-right-radius: 10px;
	border-bottom-left-radius: 10px;
}

.sellergallery .content .buy-1 {
	background-color: #2183a2;
}

.sellergallery .content .buy-2 {
	background-color: #3b3e6e;
}

.sellergallery .content .buy-3 {
	background-color: #0b0b0b;
}

@media ( max-width : 1000px) {
	.sellergallery .content {
		width: 46%;
	}
}

@media ( max-width : 750px) {
	.sellergallery .content {
		width: 100%;
	}
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
	List<Vendor> all_vendors = (List<Vendor>)request.getAttribute("all_vendors");
	%>
<% if(all_vendors.isEmpty()){ %>
<h1>Vendors Not Registred!!</h1>
<% }else{ %>
<div class="sellergallery">
		<%
		for (Vendor v : all_vendors) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String shopname = v.getVendor_shop_name();
			String shopimage = v.getImage();
			String vname = v.getVendor_name();
			String emailid = v.getVendor_email_id();
			String contact = v.getVendor_contact_number();
			String joiningdate = formatter.format(v.getVendor_joiningdate());
			
			BillingAddress baddress = v.getBilling_address();
			Long bid = baddress.getAid();
			String hno = baddress.getHouse_no();
			String street = baddress.getStreet();
			String city = baddress.getCity();
			String district = baddress.getDistrict();
			String state = baddress.getState();
			String pincode = baddress.getPincode();
			String billingaddress = hno + ", " + street + ", " + city + ", " + district + ", " + state + ", " + pincode + ".";
		%>
		<div class="content">
			<img src="<%=shopimage%>" alt="<%=shopname%>">
			<hr style="border:2px solid black;">
			<h3><%=shopname%></h3>
			<hr style="border:2px solid black;">
			<p><%=vname%></p>
			<p><%=emailid%></p>
			<p><%=contact%></p>
			<p>Joining Date :- <%=joiningdate %></p>
			<hr style="border:2px solid black;">
			<p>Billing Address :- <%=billingaddress %></p>
			
		</div>
	<% } %>
	</div>
	<% } %>
</body>
</html>
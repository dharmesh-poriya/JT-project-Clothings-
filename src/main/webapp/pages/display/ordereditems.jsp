<%@page import="com.clothes.demo.models.vendor.BillingAddress"%>
<%@page import="java.sql.Time"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.clothes.demo.models.orders.OrderItem"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ordered Items</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" >

<!-- Links for Error messages -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Links for Error messages end-->

<!-- Vendor cards -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.vendor .card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	max-width: 300px;
	margin: auto;
	text-align: center;
	font-family: arial;
}

.vendor .title {
	color: black;
	font-size: 18px;
	font-weight: bold;
}

.vendor button {
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

.vendor a {
	text-decoration: none;
	font-size: 22px;
	color: black;
}

.vendor button:hover, .vendor a:hover {
	opacity: 0.7;
}

.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 16px 15px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
}
.button2 {
  background-color: white; 
  color: black; 
  border: 2px solid #008CBA;
}

.button2:hover {
  background-color: black;
  color: white;
}
</style>
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // this is for HTTP version 1.1 not work for lesser version
	response.setHeader("Pragma", "no-cache"); // this is for HTTP version 1.0
	response.setHeader("Expires", "0"); // this is for proxies server
	%>

	<%@include file="../navfooter/navbar.jsp"%>
	
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
	List<OrderItem> orderd_items = (List<OrderItem>) request.getAttribute("ordered_items");
	List<String> colors = new ArrayList<String>();
	colors.add("green");
	colors.add("blue");
	colors.add("black");
	colors.add("Lavender");
	colors.add("MediumSlateBlue");
	int colorssize = colors.size();
	%>

	<%
	if (!orderd_items.isEmpty()) {
		int count = 0;
		int total_cost = 0;
	%>
	<br>
	<br>
	<h1 class=".test1">
		Order Items(Order ID :- <%= "O"+orderd_items.get(0).getOrder().getId()%>)
	</h1>
	<br>
	<br>
	<table class="w3-table-all">
		<thead>
			<tr class="w3-light-grey w3-hover-red">
				<th>No.</th>
				<th>Photo</th>
				<th>Name</th>
				<th>Description</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Items Cost</th>
				<th>Date</th>
				<th>Time</th>
				<th>Seller</th>
			</tr>
		</thead>
		<%
		for (OrderItem oi : orderd_items) {
		%>
		<%
		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		count++;
		String image = oi.getProduct().getProduct_image();
		String name = oi.getProduct().getProduct_name();
		String desc = oi.getProduct().getProduct_description();
		Double price = oi.getItem_price();
		int quantity = oi.getQuentity();
		String date = formatter.format(oi.getOrder_item_date());
		Time time = oi.getOrder_item_time();

		total_cost += price*quantity;
		
		String sellerdivid = "seller" + oi.getId();
		String shopname = oi.getProduct().getVendor().getVendor_shop_name();
		String shopimage = oi.getProduct().getVendor().getImage();
		String vendorname = oi.getProduct().getVendor().getVendor_name();
		BillingAddress vendoraddress = oi.getProduct().getVendor().getBilling_address();
		String street = vendoraddress.getStreet();
		String city = vendoraddress.getCity();
		String district = vendoraddress.getDistrict();
		String state = vendoraddress.getState();
		String pincode = vendoraddress.getPincode();
		String venaddress = street + ", " + city + ", " + district + ", " + state + ", " + pincode + ".";
		String email = oi.getProduct().getVendor().getVendor_email_id();
		String contact = oi.getProduct().getVendor().getVendor_contact_number();
		%>
		<tr class="w3-hover-<%=colors.get((count - 1) % colorssize)%>">
			<td><%=count%></td>
			<td><img style="width: 50%;height: 30%;" alt="<%=name%>" src="<%=image%>"></td>
			<td><%=name%></td>
			<td><%=desc%></td>
			<td><%=price%></td>
			<td><%=quantity%></td>
			<td><%= total_cost %>
			<td><%=date%></td>
			<td><%=time%></td>
			<td>
				<!-- View Seller -->
				<div class="w3-container">
					<button
						onclick="document.getElementById('<%=sellerdivid%>').style.display='block'"
						class="w3-button w3-black">Seller</button>

					<div id="<%=sellerdivid%>" class="w3-modal">
						<div class="w3-modal-content w3-animate-top w3-card-4">
							<header class="w3-container w3-black">
								<span
									onclick="document.getElementById('<%=sellerdivid%>').style.display='none'"
									class="w3-button w3-display-topright">&times;</span>
								<h2 style="text-align:center;" >Seller Information</h2>
							</header>
							<br><br>
							<div class="w3-container">
								<div class="vendor">
									<div class="card">
										<img src="<%= shopimage %>" alt="John" style="width: 100%">
										<h1 style="text-align: center;color:black;font-weight:bolder;"><%= shopname %></h1>
										<p class="title">Name : <%= vendorname %></p>
										<p class="title">Address : <%= venaddress %></p>
										<div style="margin: 24px 0;">
											<a href="#"><i class="fa fa-dribbble"></i></a> <a href="#"><i
												class="fa fa-twitter"></i></a> <a href="#"><i
												class="fa fa-linkedin"></i></a> <a href="mailto:<%=email%>"><i
												class="fa fa-envelope"></i></a>
										</div>
										<p>
											<a href="tel:<%=contact%>"><button>Contact</button></a>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	<br><br>
<h1>Total Cost :- <%= total_cost %>	&#8377;</h1>
	<%
	}
	%>
	<br>
	<br>
	<br>
	<%@include file="../navfooter/footer.jsp"%>
</body>
</html>
<%@page import="com.clothes.demo.models.customer.Address"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Time"%>
<%@page import="java.util.List"%>
<%@page import="com.clothes.demo.dao.OrderItemDao"%>
<%@page import="com.clothes.demo.models.orders.OrderItem"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Carts</title>

<!-- Links for Error messages -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Links for Error messages end-->

<style type="text/css">
#tbl {
	font-family: Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#tbl td, #tbl th {
	border: 1px solid #ddd;
	padding: 8px;
}

#tbl tr td img {
	width: 50%;
	height: 50%;
}

#tbl tr:nth-child(even) {
	background-color: #f2f2f2;
}

#tbl tr:hover {
	background-color: #ddd;
}

#tbl th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #04AA6D;
	color: white;
}
</style>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
	<br>
	<%
	List<OrderItem> carts = (List<OrderItem>) request.getAttribute("carts");
	Address customeraddress = (Address) request.getAttribute("customer_address");
	%>

	<%
	if (carts.isEmpty()) {
	%>
	<img alt="Empty Cart" style="width:100vw;height:100vh;" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnTMh2RlXvCKWVgC70q06r8sntDKl5dOKZHw&usqp=CAU">
	<%
	} else {
	%>

	<table id="tbl">
		<%
		int count = 0;
		int total_sum = 0;
		%>
		<thead>
			<tr>
				<th>No.</th>
				<th>Photo</th>
				<th>Name</th>
				<th>Description</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Items Cost</th>
				<th>Date/Time</th>
				<th>Seller</th>
				<th>Edit?</th>
				<th>Delete?</th>
			</tr>
		</thead>
		<%
		for (OrderItem oi : carts) {
		%>
		<%
		Long itemid = oi.getId();
		count++;
		String image = oi.getProduct().getProduct_image();
		String productname = oi.getProduct().getProduct_name();
		String desc = oi.getProduct().getProduct_description();
		Double price = oi.getItem_price();
		int quantity = oi.getQuentity();
		Date date = oi.getOrder_item_date();
		Time time = oi.getOrder_item_time();
		String seller = oi.getProduct().getVendor().getVendor_shop_name();
		String divid = "cart" + oi.getId();
		
		total_sum += price*quantity;
		%>
		<tr>
			<td><%=count%></td>
			<td><img alt="<%=productname%>" src="<%=image%>"></td>
			<td><%=productname%></td>
			<td><%=desc%></td>
			<td><%=price%> &#8377;</td>
			<td><%=quantity%></td>
			<td><%= price*quantity %> &#8377;</td>
			<td><%=date%></td>
			<td><%=seller%></td>
			<td>
				<!-- Edit Product -->
				<div class="w3-container">
					<button
						onclick="document.getElementById('<%=divid%>').style.display='block'"
						class="w3-button w3-black">Edit</button>

					<div id="<%=divid%>" class="w3-modal">
						<div class="w3-modal-content w3-animate-top w3-card-4">
							<header class="w3-container w3-teal">
								<span
									onclick="document.getElementById('<%=divid%>').style.display='none'"
									class="w3-button w3-display-topright">&times;</span>
								<h2>Edit Quantity</h2>
							</header>
							<form action="fashion-factory/editCartQuentity" method="post">
								<div class="w3-container">
									<br> <input type="number" name="id" value="<%=itemid%>"
										hidden="hidden" required> <input type="number"
										name="quantity" placeholder="Quantity" value="<%=quantity%>"
										min="1" max="500" title="Quentity must be 1 to 500">


									<button type="submit">Edit Quantity</button>
								</div>
								<footer class="w3-container w3-teal">
									<button type="button"
										onclick="document.getElementById('<%=divid%>').style.display='none'"
										class="cancelbtn">Cancel</button>
								</footer>
							</form>
						</div>
					</div>
				</div>
			</td>
			<%
				divid = "delete" + oi.getId();
			%>
			<td>
				<!-- Delete Product -->
				<div class="w3-container">
					<button
						onclick="document.getElementById('<%=divid%>').style.display='block'"
						class="w3-button w3-black">Delete</button>

					<div id="<%=divid%>" class="w3-modal">
						<div class="w3-modal-content w3-animate-top w3-card-4">
							<header class="w3-container w3-teal">
								<span
									onclick="document.getElementById('<%=divid%>').style.display='none'"
									class="w3-button w3-display-topright">&times;</span>
								<h2>Are You Sure You Want To Delete This??</h2>
							</header>
							<form action="fashion-factory/deleteCartQuentity" method="post">
								<div class="w3-container">
									<br> <input type="number" name="id" value="<%=itemid%>"
										hidden="hidden" required>
									<button type="submit">Delete!!</button>
									<button type="button"
										onclick="document.getElementById('<%=divid%>').style.display='none'"
										class="cancelbtn">Cancel</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</td>
		</tr>

		<%
		}
		%>
	</table>

	<%
	if (null == customeraddress) {
	%>
	<br><br>
	<!-- Add Address -->
	<div class="w3-container">
		<button
			onclick="document.getElementById('add_address').style.display='block'"
			class="w3-button w3-black">Add Address</button>

		<div id="add_address" class="w3-modal">
			<div class="w3-modal-content w3-animate-top w3-card-4">
				<header class="w3-container w3-teal">
					<span
						onclick="document.getElementById('add_address').style.display='none'"
						class="w3-button w3-display-topright">&times;</span>
					<h2>Add your Billing Address</h2>
				</header>
				<form action="fashion-factory/addAddress" method="post">
					<div class="w3-container">
						<br>  
						<input type="text" name="house_no" placeholder="House No." required>
						<input type="text" name="street" placeholder="Street" required>
						<input type="text" name="city" placeholder="City" required>
						<input type="text" name="district" placeholder="District" required>
						<input type="text" name="state" placeholder="State" required>
						<input type="number" name="pincode" placeholder="Pincode" required>
						<input type="text" name="customer_id" value="<%= customer.getCustomer_id() %>" hidden="hidden" required>


						<button type="submit" class="w3-button w3-blue">Add Address</button>
					</div>
					<footer class="w3-container w3-teal">
						<button type="button"
							onclick="document.getElementById('add_address').style.display='none'"
							class="cancelbtn">Cancel</button>
					</footer>
				</form>
			</div>
		</div>
	</div>
	<%
	} else {
	String hno = customeraddress.getHouse_no();
	String street = customeraddress.getStreet();
	String city = customeraddress.getCity();
	String district = customeraddress.getDistrict();
	String state = customeraddress.getState();
	String pincode = customeraddress.getPincode();
	String currentadd = hno + ", " + street + ", " + city + ", " + district + ", " + state + ", " + pincode + ".";
	%>
	<div>
		<div class="w3-container">
		<button
			onclick="document.getElementById('edit_address').style.display='block'"
			class="w3-button w3-black">Edit Address</button>

		<div id="edit_address" class="w3-modal">
			<div class="w3-modal-content w3-animate-top w3-card-4">
				<header class="w3-container w3-teal">
					<span
						onclick="document.getElementById('edit_address').style.display='none'"
						class="w3-button w3-display-topright">&times;</span>
					<h2>Edit your Billing Address</h2>
				</header>
				<form action="fashion-factory/editAddress" method="post">
					<div class="w3-container">
						<br>  
						<input type="text" name="house_no" placeholder="House No." value="<%= hno %>" required>
						<input type="text" name="street" placeholder="Street" value="<%= street %>" required>
						<input type="text" name="city" placeholder="City" value="<%= city %>" required>
						<input type="text" name="district" placeholder="District" value="<%= district %>" required>
						<input type="text" name="state" placeholder="State" value="<%= state %>" required>
						<input type="number" name="pincode" placeholder="Pincode" value="<%= pincode %>" required>
						<input type="text" name="customer_id" value="<%= customer.getCustomer_id() %>" hidden="hidden" required>
						<input type="text" name="address_id" value="<%= customeraddress.getAid() %>" hidden="hidden" required>

						<button type="submit" class="w3-button w3-black">Edit Address</button>
					</div>
					<footer class="w3-container w3-teal">
						<button type="button"
							onclick="document.getElementById('edit_address').style.display='none'"
							class="cancelbtn">Cancel</button>
					</footer>
				</form>
			</div>
		</div>
	</div>
		<br>
		<p>
			Address :-
			<%=currentadd%>
		</p>
		<p>Contact No. :- <%= customer.getCustomer_contact_number() %></p>
	</div>
	<h1>Total Cost :- <%= total_sum %>	&#8377;</h1>
	
	<a href="checkout"><button
			class="w3-button w3-black">Check Out</button></a>
	<%
	session.setAttribute("total_cost", 0);
	session.setAttribute("total_cost", total_sum);
	%>
	<%
	}
	%>
	<%
	}
	%>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<%@include file="../navfooter/footer.jsp"%>
</body>
</html>
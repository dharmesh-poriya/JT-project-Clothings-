<%@page import="com.clothes.demo.models.products.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style> <%@include file="../../css/productcard.css"%> </style>
<!-- Links for Error messages -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Links for Error messages end-->
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
	List<Product> all_kids_products = (List<Product>) request.getAttribute("all_kids_products");
	%>

	<%
	if (all_kids_products.isEmpty()) {
	%>
	<br>
	<br>
	<br>
	<h1>Products Not Available Yet!!</h1>
	<br>
	<br>
	<br>
	<%
	} else {
	%>
	<div class="gallery">
		<%
		for (Product p : all_kids_products) {
			String SellerName = p.getVendor().getVendor_name();
			String ShopName = p.getVendor().getVendor_shop_name();
			String street = p.getVendor().getBilling_address().getStreet();
			String city = p.getVendor().getBilling_address().getCity();
			String district = p.getVendor().getBilling_address().getDistrict();
			String state = p.getVendor().getBilling_address().getState();
			String pincode = p.getVendor().getBilling_address().getPincode();
		%>
		<div class="content">
			<img src="<%=p.getProduct_image()%>" alt="<%=p.getProduct_name()%>">
			<h3><%=p.getProduct_name()%></h3>
			<p><%=p.getProduct_description()%></p>
			<p> Category : <%=p.getProduct_category()%></p>
			<h6><%=p.getProduct_price()%> &#8377;</h6>
			<hr>
			<h6>Seller Details:</h6>
			<p>Name : <%= SellerName %></p>
			<p>Shop : <%= ShopName %></p>
			<p>Address : <%= street + ", " + city + ", " + district + ", " + state + ", " +  pincode +"."%></p>
			
			<form action="fashion-factory/addToCart" method="post">
				<input type="text" name="product_id" value="<%=p.getId()%> " hidden="hidden">
				<input type="number" name="quentity" placeholder="Quantity" min="1" max="500" title="Quentity must be 1 to 500">
				<button type="submit" class="buy-2">Add To Cart</button>
			</form>
		</div>
		<%
		}
		%>
	</div>
	<%
	}
	%>

	<!-- Footer -->
	<%@include file="../navfooter/footer.jsp"%>
	<!-- Footer end -->
</body>
</html>
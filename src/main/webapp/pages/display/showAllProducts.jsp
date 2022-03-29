<%@page import="com.clothes.demo.models.authenticate.Admin"%>
<%@page import="com.clothes.demo.models.customer.CustomerDetails"%>
<%@page import="com.clothes.demo.models.vendor.Vendor"%>
<%@page import="com.clothes.demo.models.products.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Products</title>
<style> <%@include file="../../css/productcard.css"%> </style>
</head>
<body>
	<%
	List<Product> menproduct = (List<Product>) request.getAttribute("menproduct");
	List<Product> womenproduct = (List<Product>) request.getAttribute("womenproduct");
	List<Product> kidsproduct = (List<Product>) request.getAttribute("kidsproduct");
	
	%>
	<%
	if (menproduct.isEmpty() && womenproduct.isEmpty() && kidsproduct.isEmpty()) {
	%>
	<h1>Products Not Available</h1>
	<%
	} else {
	%>
	<div class="gallery">
		<%
		if (!menproduct.isEmpty()) {
		%>
		<%
		for (Product p : menproduct) {
		%>
		<div class="content">
			<!-- <p style="background-color: lightgreen;width:30%;color:black;font-weight: bolder;"><marquee>Sell On</marquee></p> -->
			<img src="<%=p.getProduct_image()%>" alt="<%=p.getProduct_name()%>">
			<h3><%=p.getProduct_name()%></h3>
			<p><%=p.getProduct_description()%></p>
			<p>
				Category :
				<%=p.getProduct_category()%></p>
			<h6><%=p.getProduct_price()%>
				&#8377;
			</h6>
			<form action="fashion-factory/addToCart" method="post">
				<input type="text" name="product_id" value="<%=p.getId()%> " hidden="hidden">
				<input type="number" name="quentity" placeholder="Quantity" min="1" max="500" title="Quentity must be 1 to 500">
				<button type="submit" class="buy-2">Add To Cart</button>
			</form>
		</div>
		<%
		}
		%>

		<%
		}
		if (!womenproduct.isEmpty()) {
		%>
		<%
		for (Product p : womenproduct) {
		%>
		<div class="content">
			<!-- <p style="background-color: lightgreen;width:30%;color:black;font-weight: bolder;"><marquee>Sell On</marquee></p> -->
			<img src="<%=p.getProduct_image()%>" alt="<%=p.getProduct_name()%>">
			<h3><%=p.getProduct_name()%></h3>
			<p><%=p.getProduct_description()%></p>
			<p>
				Category :
				<%=p.getProduct_category()%></p>
			<h6><%=p.getProduct_price()%>
				&#8377;
			</h6>
			<form action="fashion-factory/addToCart" method="post">
				<input type="text" name="product_id" value="<%=p.getId()%> " hidden="hidden">
				<input type="number" name="quentity" placeholder="Quantity" min="1" max="500" title="Quentity must be 1 to 500">
				<button type="submit" class="buy-2">Add To Cart</button>
			</form>
		</div>
		<%
		}
		%>
		<%
		}
		if (!kidsproduct.isEmpty()) {
		%>
		<%
		for (Product p : kidsproduct) {
		%>
		<div class="content">
			<!-- <p style="background-color: lightgreen;width:30%;color:black;font-weight: bolder;"><marquee>Sell On</marquee></p> -->
			<img src="<%=p.getProduct_image()%>" alt="<%=p.getProduct_name()%>">
			<h3><%=p.getProduct_name()%></h3>
			<p><%=p.getProduct_description()%></p>
			<p>
				Category :
				<%=p.getProduct_category()%></p>
			<h6><%=p.getProduct_price()%>
				&#8377;
			</h6>
			<form action="fashion-factory/addToCart" method="post">
				<input type="text" name="product_id" value="<%=p.getId()%> " hidden="hidden">
				<input type="number" name="quentity" placeholder="Quantity" min="1" max="500" title="Quentity must be 1 to 500">
				<button type="submit" class="buy-2">Add To Cart</button>
			</form>
		</div>
		<%
		}
		%>

		<%
		}
		%>
	</div>
	<%
	}
	%>
</body>
</html>
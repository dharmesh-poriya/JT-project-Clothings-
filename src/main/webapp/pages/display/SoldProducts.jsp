<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.clothes.demo.models.products.Product"%>
<%@page import="com.clothes.demo.models.orders.OrderItem"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sold Products</title>
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
#tbl tr td img{
width: 50%;
height: 50%;
}
#tbl tr:nth-child(even){background-color: #f2f2f2;}

#tbl tr:hover {background-color: #ddd;}

#tbl th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
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
	<br>
	<%
	List<Product> soldproduct = (List<Product>) request.getAttribute("all_sold_products");
	%>
	
	<% if(!soldproduct.isEmpty()){ %>
	<table id="tbl">
	<% int count = 0;
	   Double total_earnings = 0.0;
	%>
		<tr>
			<th>No.</th>
			<th>Photo</th>
			<th>Code</th>
			<th>Name</th>
			<th>Description</th>
			<th>Price</th>
			<th>Sold Quantity</th>
			<th>Total Earnings</th>
			<th>Added Date</th>
			<th>Category</th>
		</tr>
	<% for(Product p : soldproduct){ %>
		
		<tr>
			<%
			count ++;
			String image = p.getProduct_image();
			String code = p.getProduct_code();
			String name = p.getProduct_name();
			String desc = p.getProduct_description();
			Double price = p.getProduct_price();
			Long quantity = p.getSold_quantity();
			String category = p.getProduct_category();
			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			String date = formatter.format(p.getProduct_added_date());
			total_earnings += price*quantity;
			%>
			<td><%= count%></td>
			<td><img alt="<%= name %>" src="<%= image %>" style="width:50%;"></td>
			<td><%= code %></td>
			<td><%= name %></td>
			<td><%= desc %></td>
			<td><%= price%> &#8377;</td>
			<td><%= quantity %></td>
			<td><%= price*quantity %> &#8377;</td>
			<td><%= date %></td>
			<td><%= category %></td>
		</tr>
		<% } %>
	</table>
	<br>
	<hr style="border:2px solid black;">
	<h1>Total Earnings :- <%= total_earnings %>	&#8377;</h1>
	<hr style="border:2px solid black">
	<% }else{ %>
	<br><br><br><br>
	<h1>Your Products have not sold!!&#128531;</h1>
	<br><br><br><br>
	<% } %>
	<br>
	<br>
	<br>
	<%@include file="../navfooter/footer.jsp"%>
</body>
</html>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.clothes.demo.models.products.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Products</title>
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
<%-- <style><%@include file="../navfooter/formmodel.css"%></style> --%>
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
		List<Product> allmypro = (List<Product>) request.getAttribute("all_pro"); 
	%>
	<% if(!allmypro.isEmpty()){ %>
	<table id="tbl">
	<% int count = 1; %>
		<tr>
			<th>No.</th>
			<th>Photo</th>
			<th>Code</th>
			<th>Name</th>
			<th>Description</th>
			<th>Price</th>
			<th>Category</th>
			<th>Added Date</th>
			<th>Edit</th>
		</tr>
	<% for(Product p : allmypro){ %>
		<tr>
			<%
			Long id = p.getId();
			String code = p.getProduct_code();
			String image = p.getProduct_image();
			String name = p.getProduct_name();
			String desc = p.getProduct_description();
			Double price = p.getProduct_price();
			String category = p.getProduct_category();
			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			String addeddate = formatter.format(p.getProduct_added_date());
			String divid = "editproduct"+id;
			%>
			<td><%= count%></td>
			<td><img alt="<%= name %>" src="<%= image %>"></td>
			<td><%= code %></td>
			<td><%= name %></td>
			<td><%= desc %></td>
			<td><%= price%></td>
			<td><%= category %></td>
			<td><%= addeddate %></td>
			<td>
			<!-- Edit Product -->
			<button onclick="document.getElementById('<%= divid %>').style.display='block'">Edit?</button>
			<div id="<%= divid %>" class="modal">

						<form class="modal-content animate" action="fashion-factory/editProduct" method="post" onsubmit ="return validateForm()">
							<div class="imgcontainer">
								<span
									onclick="document.getElementById('<%= divid %>').style.display='none'"
									class="close" title="Close Modal">×</span> <img
									src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtn3ZdZW5JSeKSB1QDDpbS9FPw-ig9BnfxJA&usqp=CAU"
									alt="Avatar" class="avatar">
							</div>

							<div class="container">
								<input type="text" name="id" value="<%= id %>"  hidden="hidden" required>
								<label><b>Product Code</b></label> <input type="text"
									placeholder="Enter Unique Product Code" name="product_code" value="<%= code %>" required>
								<label><b>Product Name</b></label> <input type="text"
									placeholder="Enter Product Name" name="product_name" value="<%= name %>" required>
								<label><b>Product Image(only image URL)</b></label> <input type="url"
									placeholder="Insert Product Image" name="product_image" value="<%= image %>" required>
								<label><b>Product Description</b></label> <input type="text"
									placeholder="Enter Description" name="product_description" value="<%= desc %>" required>
								<label><b>Product Price(&#8377;)</b></label> <input type="number"
									placeholder="Enter Product Price" name="product_price" step="0.0" value="<%= price %>" required>
									
								<input type="number" name="sold_quantity" value="0" hidden="hidden" required>
								<label><b>Category</b></label>
								<select name="product_category" required>
 									 <option value="Men">Men</option>
  									 <option value="Women">Women</option>
  									 <option value="Kids">Kids</option>
								</select>
								<input type="date" placeholder="Enter Current Date" name="product_added_date" value="<%= java.time.LocalDate.now() %>" hidden="hidden" required>
								<button type="reset">Reset</button>
								<button type="submit">Edit Product</button>
							</div>

							<div class="container" style="background-color: #f1f1f1">
								<button type="button"
									onclick="document.getElementById('<%= divid %>').style.display='none'"
									class="cancelbtn">Cancel</button>
							</div>
						</form>
					</div>

					<script>
						var modal = document.getElementById('<%= divid %>');
						window.onclick = function(event) {
							if (event.target == modal) {
								modal.style.display = "none";
							}
						}
					</script>
			
			</td>
			
		</tr>
		
	<%
	count ++;
	}
	%>
	</table>
	<% }else{ %>
	<br><br><br><br>
	<h1>You haven't sell any product yet!!</h1>
	<br><br><br><br>
	<% } %>
	
	<%@include file="../navfooter/footer.jsp"%>
</body>

</html>


<!-- This is for deleting product -->
<%-- 

<% divid = "delete"+p.getId(); %>
			<td>
			<!-- Delete Product -->
			<button onclick="document.getElementById('<%= divid %>').style.display='block'">Delete?</button>
			
			<div id="<%= divid %>" class="modal">

						<form class="modal-content animate" action="fashion-factory/deleteProduct" method="post" onsubmit ="return validateForm()">
							<div class="imgcontainer">
								<span
									onclick="document.getElementById('<%= divid %>').style.display='none'"
									class="close" title="Close Modal">×</span> <img
									src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtn3ZdZW5JSeKSB1QDDpbS9FPw-ig9BnfxJA&usqp=CAU"
									alt="Avatar" class="avatar">
							</div>

							<div class="container">
								<b> Are You Sure You want to delete These Product?</b><br>
								<input type="text" name="id" value="<%= id %>"  hidden="hidden" required>
								<button type="submit">Delete?</button>
							</div>

							<div class="container" style="background-color: #f1f1f1">
								<button type="button"
									onclick="document.getElementById('<%= divid %>').style.display='none'"
									class="cancelbtn">Cancel</button>
							</div>
						</form>
					</div>

					<script>
						var modal = document.getElementById('<%= divid %>');
						window.onclick = function(event) {
							if (event.target == modal) {
								modal.style.display = "none";
							}
						}
					</script>
			
			</td>
			
			

--%>


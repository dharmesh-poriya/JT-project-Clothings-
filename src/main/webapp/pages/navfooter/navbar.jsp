<%@page import="com.clothes.demo.models.vendor.Vendor"%>
<%@page import="com.clothes.demo.models.authenticate.Admin"%>
<%@page import="com.clothes.demo.models.customer.CustomerDetails"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Varela+Round">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/navcss.css" /> --%>
<style><%@include file="navcss.css"%></style>
<style><%@include file="formmodel.css"%></style>

<script>
	// Prevent dropdown menu from closing when click inside the form
	$(document).on("click", ".action-buttons .dropdown-menu", function(e) {
		e.stopPropagation();
	});
</script>

<!-- Validating -->

<script>  
function validateForm() {  
    //collect form data in JavaScript variables  
    var pw1 = document.getElementById("psw1").value;  
    var pw2 = document.getElementById("psw2").value;  
    var fname = document.getElementById("fname").value;
      
    //check empty first name field  
    if(fname == "") {  
      document.getElementById("blankMsg").innerHTML = "**Fill the first name";  
      return false;  
    }  
      
    //character data validation  
    if(!isNaN(fname)){  
      document.getElementById("blankMsg").innerHTML = "**Only characters are allowed";  
      return false;  
    }  
    
    //check empty password field  
    if(pw1 == "") {  
      document.getElementById("message1").innerHTML = "**Fill the password please!";  
      return false;  
    }  
    
    //check empty confirm password field  
    if(pw2 == "") {  
      document.getElementById("message2").innerHTML = "**Enter the password please!";  
      return false;  
    }   
     
    //minimum password length validation  
    if(pw1.length < 8) {  
      document.getElementById("message1").innerHTML = "**Password length must be atleast 8 characters";  
      return false;  
    }  
  
    //maximum length of password validation  
    if(pw1.length > 20) {  
      document.getElementById("message1").innerHTML = "**Password length must not exceed 15 characters";  
      return false;  
    }  
    
    if(pw1 != pw2) {  
      document.getElementById("message2").innerHTML = "**Passwords are not same";  
      return false;  
    } else {  
      alert ("Registration successfully");  
      /* document.write("JavaScript form has been submitted successfully"); */  
    }  
 }  
</script>  
</head>
<body>
<%
 CustomerDetails customer = (CustomerDetails)session.getAttribute("customer");
 Admin admin = (Admin)session.getAttribute("admin");
 Vendor vendor = (Vendor)session.getAttribute("vendor");
 boolean isCustomer = false;
 boolean isAdmin = false;
 boolean isVendor = false;
 boolean noneOfThis = false;
 if(null != customer){
	 isCustomer = true;
 }else if(null != admin){
	 isAdmin = true;
 }else if(null != vendor){
	 isVendor = true;
 }else{
	 noneOfThis = true;
 }
 %>
 <%
 String menProducts = "showMenProducts";
 String womenProducts = "showWomenProducts";
 String kidsProducts = "showKidsProducts";
 String myCarts = "myCarts";
 String myOrders = "myOrders";
 %>
 <% if (noneOfThis){ %>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="fashion-factory" class="navbar-brand">Fashion <b>Factory</b></a>
		<button type="button" class="navbar-toggler" data-toggle="collapse"
			data-target="#navbarCollapse">
			<span class="navbar-toggler-icon"></span>
		</button>
		<!-- Collection of nav links, forms, and other content for toggling -->
		<div id="navbarCollapse"
			class="collapse navbar-collapse justify-content-start">
			<div class="navbar-nav">
				<a href="fashion-factory" class="nav-item nav-link">Home</a>
				<div class="nav-item dropdown">
					<a href="#" data-toggle="dropdown" class="nav-item nav-link dropdown-toggle">Category</a>
					<div class="dropdown-menu">
						<a href="<%= menProducts %>" class="dropdown-item">Men</a>
						<a href="<%= womenProducts %>" class="dropdown-item">Women</a>
						<a href="<%= kidsProducts %>" class="dropdown-item">Kids</a>
					</div>
				</div>
				<a href="<%= myCarts %>" class="nav-item nav-link active">Carts</a>
				<a href="<%= myOrders %>" class="nav-item nav-link">Orders</a> 
			</div>
			<form class="navbar-form form-inline">
				<div class="input-group search-box">
					<input type="text" id="search" class="form-control"
						placeholder="Search here...">
					<!-- <div class="input-group-append">
						<span class="input-group-text"> <i class="material-icons">&#xE8B6;</i>
						</span>
					</div> -->
				</div>
			</form>
			<div class="navbar-nav ml-auto action-buttons">
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle mr-4"
						onclick="document.getElementById('id01').style.display='block'">Login</a>
					<div id="id01" class="modal">

						<form class="modal-content animate" action="fashion-factory/doLogin" method="post" >
							<div class="imgcontainer">
								<span
									onclick="document.getElementById('id01').style.display='none'"
									class="close" title="Close Modal">×</span> <img
									src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtn3ZdZW5JSeKSB1QDDpbS9FPw-ig9BnfxJA&usqp=CAU"
									alt="Avatar" class="avatar">
							</div>

							<div class="container">
								<label><b>Email Address</b></label> <input type="email"
									placeholder="Enter Email Address" name="email" autofocus required>
								<label><b>Password</b></label> <input type="password"
									placeholder="Enter Password" name="password" required>

								<button type="submit">Login</button>
							</div>

							<div class="container" style="background-color: #f1f1f1">
								<button type="button"
									onclick="document.getElementById('id01').style.display='none'"
									class="cancelbtn">Cancel</button>
								<span class="psw">Forgot <a href="#">password?</a></span>
							</div>
						</form>
					</div>

					<script>
						var modal = document.getElementById('id01');
						window.onclick = function(event) {
							if (event.target == modal) {
								modal.style.display = "none";
							}
						}
					</script>
				</div>
				<div class="nav-item dropdown">
					<a href="#"
						class="btn btn-primary dropdown-toggle sign-up-btn"
						onclick="document.getElementById('id02').style.display='block'">Sign
						up</a>
					<div id="id02" class="modal">

						<form class="modal-content animate" action="fashion-factory/addCustomer" method="post" onsubmit ="return validateForm()">
							<div class="imgcontainer">
								<span
									onclick="document.getElementById('id02').style.display='none'"
									class="close" title="Close Modal">×</span> <img
									src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtn3ZdZW5JSeKSB1QDDpbS9FPw-ig9BnfxJA&usqp=CAU"
									alt="Avatar" class="avatar">
							</div>

							<div class="container">
								<label><b>Full Name</b></label> <input type="text"
									placeholder="Enter Full Name" name="customer_name" autofocus pattern="[A-Za-z0-9]+" title="Only Characters Accepted" required>
									<span id = "blankMsg" style="color:red"> </span> <br><br> 
								<label><b>Contact Number</b></label> <input type="tel"
									placeholder="Enter Contact Number" name="customer_contact_number" pattern="[6789][0-9]{9}" title="mobile number should be 10 digit only and started with 6,7,8 or 9 digit otherwise not valid" required>
								<label><b>Email Address</b></label> <input type="email"
									placeholder="Enter Email Address" name="customer_email_id" required>
								<label><b>Password</b></label> <input type="password"
									placeholder="Enter Password" name="cpsw" id="psw1" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="Password should contain minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character">
									<span id = "message1" style="color:red"> </span> <br><br><br> 
								<label><b>Confirm Password</b></label> <input type="password"
									placeholder="Confirm Password" name="customer_password" id="psw2" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="Password should contain minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character">
									<span id = "message2" style="color:red"> </span> <br><br>
								<label><b>Date of Birth</b></label> <input type="date"
									placeholder="Enter DOB" name="customer_dob" min="1950-01-01" max="2020-12-31"required>
								
								<input type="url" name="profile_image" value="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyDgkPQavzX7KwcLzeAsf0fgOx_-D51F3fag&usqp=CAU" hidden="hidden" required>
								<input type="date" placeholder="Enter JOB" name="customer_joiningdate" value="<%= java.time.LocalDate.now() %>" hidden="hidden" required>
								<button type="reset">Reset</button>
								<button type="submit">Sign Up</button>
							</div>

							<div class="container" style="background-color: #f1f1f1">
								<button type="button"
									onclick="document.getElementById('id02').style.display='none'"
									class="cancelbtn">Cancel</button>
							</div>
						</form>
					</div>

					<script>
						var modal = document.getElementById('id02');
						window.onclick = function(event) {
							if (event.target == modal) {
								modal.style.display = "none";
							}
						}
					</script>
				</div>
			</div>
		</div>
	</nav>
	<!-- Customer Logged in  -->
<% }else if(isCustomer){ %>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="fashion-factory" class="navbar-brand">Fashion <b>Factory</b></a>
		<button type="button" class="navbar-toggler" data-toggle="collapse"
			data-target="#navbarCollapse">
			<span class="navbar-toggler-icon"></span>
		</button>
		<!-- Collection of nav links, forms, and other content for toggling -->
		<div id="navbarCollapse"
			class="collapse navbar-collapse justify-content-start">
			<div class="navbar-nav">
				<a href="fashion-factory" class="nav-item nav-link">Home</a>
				<div class="nav-item dropdown">
					<a href="#" data-toggle="dropdown" class="nav-item nav-link dropdown-toggle">Category</a>
					<div class="dropdown-menu">
						<a href="<%= menProducts %>" class="dropdown-item">Men</a>
						<a href="<%= womenProducts %>" class="dropdown-item">Women</a>
						<a href="<%= kidsProducts %>" class="dropdown-item">Kids</a>
					</div>
				</div>
				<a href="<%= myCarts %>" class="nav-item nav-link active">Carts</a>
				<a href="<%= myOrders %>" class="nav-item nav-link">Orders</a> 
			</div>
			<form class="navbar-form form-inline">
				<div class="input-group search-box">
					<input type="text" id="search" class="form-control"
						placeholder="Search here...">
					<!-- <div class="input-group-append">
						<span class="input-group-text"> <i class="material-icons">&#xE8B6;</i>
						</span>
					</div> -->
				</div>
			</form>
			<div class="navbar-nav ml-auto action-buttons">
				<div class="nav-item dropdown">
					<a href="myProfile" class="nav-link dropdown-toggle mr-4" ><%= customer.getCustomer_name() %></a>
				</div>
				<div class="nav-item dropdown">
					<a href="fashion-factory/doLogout" class="btn btn-primary dropdown-toggle sign-up-btn" >Logout</a>
				</div>
			</div>
		</div>
	</nav>

<!-- Vendor Logged in  -->
<% }else if(isVendor){ %>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="fashion-factory" class="navbar-brand">Fashion <b>Factory</b></a>
		<button type="button" class="navbar-toggler" data-toggle="collapse"
			data-target="#navbarCollapse">
			<span class="navbar-toggler-icon"></span>
		</button>
		<!-- Collection of nav links, forms, and other content for toggling -->
		<div id="navbarCollapse"
			class="collapse navbar-collapse justify-content-start">
			<div class="navbar-nav">
				<a href="fashion-factory" class="nav-item nav-link">Home</a>
				<a href="#" class="nav-item nav-link" onclick="document.getElementById('sellpro').style.display='block'">Sell Product</a>
				<div id="sellpro" class="modal">

						<form class="modal-content animate" action="fashion-factory/addProduct" method="post" onsubmit ="return validateForm()">
							<div class="imgcontainer">
								<span
									onclick="document.getElementById('sellpro').style.display='none'"
									class="close" title="Close Modal">×</span> <img
									src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtn3ZdZW5JSeKSB1QDDpbS9FPw-ig9BnfxJA&usqp=CAU"
									alt="Avatar" class="avatar">
							</div>

							<div class="container">
								<label><b>Product Code</b></label> <input type="text"
									placeholder="Enter Unique Product Code" name="product_code" required>
								<label><b>Product Name</b></label> <input type="text"
									placeholder="Enter Product Name" name="product_name" required>
								<label><b>Product Image(only image URL)</b></label> <input type="url"
									placeholder="Insert Product Image" name="product_image" required>
								<label><b>Product Description</b></label> <input type="text"
									placeholder="Enter Description" name="product_description" required>
								<label><b>Product Price(&#8377;)</b></label> <input type="number"
									placeholder="Enter Product Price" name="product_price" step="0.0" required>
								<input type="number" name="sold_quantity" value="0" hidden="hidden" required>
								<label><b>Category</b></label>
								<select name="product_category" required>
									 <option value="none" selected disabled hidden="hidden">Select Category</option>
 									 <option value="Men">Men</option>
  									 <option value="Women">Women</option>
  									 <option value="Kids">Kids</option>
								</select>
								<input type="date" placeholder="Enter Current Date" name="product_added_date" value="<%= java.time.LocalDate.now() %>" hidden="hidden" required>
								<button type="reset">Reset</button>
								<button type="submit">Add Product</button>
							</div>

							<div class="container" style="background-color: #f1f1f1">
								<button type="button"
									onclick="document.getElementById('sellpro').style.display='none'"
									class="cancelbtn">Cancel</button>
							</div>
						</form>
					</div>

					<script>
						var modal = document.getElementById('sellpro');
						window.onclick = function(event) {
							if (event.target == modal) {
								modal.style.display = "none";
							}
						}
					</script>
				
				
				
				<a href="myProducts" class="nav-item nav-link">My Products</a>
				<a href="soldProducts" class="nav-item nav-link">Sold Products</a> 
			</div>
			<form class="navbar-form form-inline">
				<div class="input-group search-box">
					<input type="text" id="search" class="form-control"
						placeholder="Search here...">
					<!-- <div class="input-group-append">
						<span class="input-group-text"> <i class="material-icons">&#xE8B6;</i>
						</span>
					</div> -->
				</div>
			</form>
			<div class="navbar-nav ml-auto action-buttons">
				<div class="nav-item dropdown">
					<a href="myVendorProfile" class="nav-link dropdown-toggle mr-4" ><%= vendor.getVendor_name() %></a>
				</div>
				<div class="nav-item dropdown">
					<a href="fashion-factory/doLogout" class="btn btn-primary dropdown-toggle sign-up-btn" >Logout</a>
				</div>
			</div>
		</div>
	</nav>

<!-- Admin Logged in  -->
<% }else{ %>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="fashion-factory" class="navbar-brand">Fashion <b>Factory</b></a>
		<button type="button" class="navbar-toggler" data-toggle="collapse"
			data-target="#navbarCollapse">
			<span class="navbar-toggler-icon"></span>
		</button>
		<!-- Collection of nav links, forms, and other content for toggling -->
		<div id="navbarCollapse"
			class="collapse navbar-collapse justify-content-start">
			<div class="navbar-nav">
				<a href="fashion-factory" class="nav-item nav-link">Home</a>
				<a href="allSellers" class="nav-item nav-link">Sellers</a>
			</div>
			<form class="navbar-form form-inline">
				<div class="input-group search-box">
					<input type="text" id="search" class="form-control"
						placeholder="Search here...">
					<!-- <div class="input-group-append">
						<span class="input-group-text"> <i class="material-icons">&#xE8B6;</i>
						</span>
					</div> -->
				</div>
			</form>
			<div class="navbar-nav ml-auto action-buttons">
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle mr-4" ><%= admin.getAdmin_name() %></a>
				</div>
				<div class="nav-item dropdown">
					<a href="fashion-factory/doLogout" class="btn btn-primary dropdown-toggle sign-up-btn" >Logout</a>
				</div>
			</div>
		</div>
	</nav>

<% } %>
</body>
</html>
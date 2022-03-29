<%@page import="com.clothes.demo.models.orders.Order"%>
<%@page import="com.clothes.demo.models.customer.CustomerDetails"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>OTP Verification</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/vue@2.6.12/dist/vue.js">

<!-- Links for Error messages -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Links for Error messages end-->

</head>
<body>
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
<br><br><br>
<%

CustomerDetails customer = (CustomerDetails)session.getAttribute("customer");
Order currentorder = (Order)session.getAttribute("current_order");
%>
<% if(null!=currentorder || null!=customer){ %>
<div id="app" style="width:30%;margin:auto;">
    <div class="container height-100 d-flex justify-content-center align-items-center">
        <div class="position-relative">
            <div class="card p-2 text-center">
			<form action="otpVerfication" method="post">
                <h6>Please enter the one time password <br> </h6>
                <div> <span> sent to</span> <small><%= customer.getCustomer_email_id() %></small> </div>
                <div id="otp" class="inputs d-flex flex-row justify-content-center mt-2">
					<input class="m-2 text-center form-control rounded" type="text" name="digit1" pattern="[0-9]{1}" title="Enter each digit in each box" id="input1" v-on:keyup="inputenter(1)" minlength="1" maxlength="1" required/>
					<input class="m-2 text-center form-control rounded" type="text" name="digit2" pattern="[0-9]{1}" title="Enter each digit in each box" id="input2" v-on:keyup="inputenter(2)" minlength="1" maxlength="1" required/>
					<input class="m-2 text-center form-control rounded" type="text" name="digit3" pattern="[0-9]{1}" title="Enter each digit in each box" id="input3" v-on:keyup="inputenter(3)" minlength="1" maxlength="1" required/>
					<input class="m-2 text-center form-control rounded" type="text" name="digit4" pattern="[0-9]{1}" title="Enter each digit in each box" id="input4" v-on:keyup="inputenter(4)" minlength="1" maxlength="1" required/>
					<input class="m-2 text-center form-control rounded" type="text" name="digit5" pattern="[0-9]{1}" title="Enter each digit in each box" id="input5" v-on:keyup="inputenter(3)" minlength="1" maxlength="1" required/>
					<input class="m-2 text-center form-control rounded" type="text" name="digit6" pattern="[0-9]{1}" title="Enter each digit in each box" id="input6" v-on:keyup="inputenter(4)" minlength="1" maxlength="1" required/>
				</div>
                <div class="mt-4"> <button type="submit" class="btn btn-danger px-4 validate">Validate</button> </div>
			</form>
			<form action="sendOtp" method="post">
                <div class="mt-3 content d-flex justify-content-center align-items-center"> <span>Didn't get the code</span>
				<a href="#" class="text-decoration-none ms-3"><button type="submit">Resend(1/3)</button></a> </div>
			</form>
            </div>
            
        </div>
    </div>
</div>
<% }else{ %>
<h1>Something went wrong</h1>
<% } %>
</body>
</html>
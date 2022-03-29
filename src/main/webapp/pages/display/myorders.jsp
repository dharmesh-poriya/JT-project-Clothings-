<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Time"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.clothes.demo.models.orders.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- Links for Error messages -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Links for Error messages end-->
<style type="text/css">
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
	List<Order> myorders = (List<Order>) request.getAttribute("myorders");
	Order current_cart = (Order)session.getAttribute("current_order");
	
	List<String> colors = new ArrayList<String>();
	colors.add("green");
	colors.add("blue");
	colors.add("black");
	colors.add("Lavender");
	colors.add("MediumSlateBlue");
	int colorssize = colors.size();
	%>

	<%
	if (myorders.isEmpty() || (1==myorders.size()&&current_cart!=null&&current_cart.getId().equals(myorders.get(0).getId()))) {
	%>
	<img alt="Empty Cart" style="width:100vw;height:100vh;" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnTMh2RlXvCKWVgC70q06r8sntDKl5dOKZHw&usqp=CAU">
	<%
	} else {
	int count = 0;
	%>
	<br>
	<br>
	<h1 class=".test1">My Orders</h1>
	<br>
	<br>
	<table class="w3-table-all">
		<thead>
			<tr class="w3-light-grey w3-hover-red">
				<th>No.</th>
				<th>Order ID</th>
				<th>Date</th>
				<th>Time</th>
				<th>View Items</th>
			</tr>
		</thead>
		<%
		for (Order o : myorders) {
			if(null != current_cart && o.getId().equals(current_cart.getId())){
				/* out.println("equal"); */
				continue;
			}
		%>
		<%
		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		count++;
		String oid = "O" + o.getId();
		String date = formatter.format(o.getOrder_date());
		Time time = o.getOrder_time();
		Long order_id = o.getId();
		%>
		<tr class="w3-hover-<%= colors.get((count - 1)%colorssize) %>">
			<td><%=count%></td>
			<td><%=oid%></td>
			<td><%=date%></td>
			<td><%=time%></td>
			<td>
				<form action="orderedItems" method="post">
					<input type="number" name="id" value="<%=order_id%>" hidden="hidden" required>
					<button type="submit" class = "button button2">View</button>
				</form>
			</td>
		</tr>
		<%
		}
		%>
	</table>

	<%
	}
	%>
<br><br><br>
	<%@include file="../navfooter/footer.jsp"%>
</body>
</html>
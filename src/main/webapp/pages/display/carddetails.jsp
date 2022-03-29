<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payment</title>
<!-- Links for Error messages -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<!-- Links for Error messages end-->

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.gradient-custom {
	background: white;
	background-blend-mode: screen, color-dodge, overlay, difference, normal;
}
</style>
</head>
<body>

	<!-- Error Handling -->
	<%
	String error_message = (String) session.getAttribute("ERROR");
	String success_message = (String) session.getAttribute("SUCCESS");
	%>
	<%
	if (null != error_message) {
	%>
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<strong><%=error_message%></strong>
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	session.removeAttribute("ERROR");
	} else if (null != success_message) {
	%>
	<div class="alert alert-success alert-dismissible fade show"
		role="alert">
		<strong><%=success_message%></strong>
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	session.removeAttribute("SUCCESS");
	}
	%>
	<!-- Error Handling -->

	<section class="gradient-custom">
		<div class="container my-5 py-5" style="background-color:lightgrey;">
			<div class="row d-flex justify-content-center py-5">
				<div class="col-md-7 col-lg-5 col-xl-4">
					<div class="card" style="border-radius: 15px;">
						<div class="card-body p-4">
							<form action="sendOtp" method="post">
								<div
									class="d-flex justify-content-between align-items-center mb-3">
									<div class="form-outline">
										<input type="text" id="typeText"
											class="form-control form-control-lg" size="17"
											placeholder="1234 5678 9012 3457" minlength="19"
											maxlength="19" required/> <label class="form-label" for="typeText">Card
											Number</label>
									</div>
									<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4pXIeWu-rua4Kn2zkVfrv58PMxkqzM_D7KQ&usqp=CAU"
										alt="visa" width="64px" />
								</div>

								<div
									class="d-flex justify-content-between align-items-center mb-4">
									<div class="form-outline">
										<input type="text" id="typeName"
											class="form-control form-control-lg" size="17"
											placeholder="Cardholder's Name" required/> <label class="form-label"
											for="typeName">Cardholder's Name</label>
									</div>
								</div>

								<div
									class="d-flex justify-content-between align-items-center pb-2">
									<div class="form-outline">
										<input type="text" id="typeExp"
											class="form-control form-control-lg" placeholder="MM/YYYY"
											size="7" id="exp" minlength="7" maxlength="7" required/> <label
											class="form-label" for="typeExp">Expiration</label>
									</div>
									<div class="form-outline">
										<input type="password" id="typeText2"
											class="form-control form-control-lg"
											placeholder="&#9679;&#9679;&#9679;" size="1" minlength="3"
											maxlength="3" required/> <label class="form-label" for="typeText2">Cvv</label>
									</div>
									<button type="submit" class="btn btn-info btn-lg btn-rounded">
										confirm
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

</body>
</html>
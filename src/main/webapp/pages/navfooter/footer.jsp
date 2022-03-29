<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Footer</title>
<style><%@include file="formmodel.css"%></style>
</head>
<body>
	<!-- Footer -->
	<footer class="text-center text-lg-start bg-light text-muted">
		<!-- Section: Social media -->
		<section
			class="d-flex justify-content-center justify-content-lg-between p-4 border-bottom">
			<!-- Left -->
			<div class="me-5 d-none d-lg-block">
				<span>Get connected with us on social networks:</span>
			</div>
			<!-- Left -->

			<!-- Right -->
			<div>
				<a href="" class="me-4 text-reset"> <i class="fab fa-facebook-f"></i>
				</a> <a href="" class="me-4 text-reset"> <i class="fab fa-twitter"></i>
				</a> <a href="" class="me-4 text-reset"> <i class="fab fa-google"></i>
				</a> <a href="" class="me-4 text-reset"> <i class="fab fa-instagram"></i>
				</a> <a href="" class="me-4 text-reset"> <i class="fab fa-linkedin"></i>
				</a> <a href="" class="me-4 text-reset"> <i class="fab fa-github"></i>
				</a>
			</div>
			<!-- Right -->
		</section>
		<!-- Section: Social media -->

		<!-- Section: Links  -->
		<section class="">
			<div class="container text-center text-md-start mt-5">
				<!-- Grid row -->
				<div class="row mt-3">
					<!-- Grid column -->
					<div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
						<!-- Content -->
						<h6 class="text-uppercase fw-bold mb-4">
							<i class="fas fa-gem me-3"></i>Company name
						</h6>
						<p>Here you can use rows and columns to organize your footer
							content. Lorem ipsum dolor sit amet, consectetur adipisicing
							elit.</p>
					</div>
					<!-- Grid column -->

					<!-- Grid column -->
					<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
						<!-- Links -->
						<h6 class="text-uppercase fw-bold mb-4">Products</h6>
						<p>
							<a href="#!" class="text-reset">Angular</a>
						</p>
						<p>
							<a href="#!" class="text-reset">React</a>
						</p>
						<p>
							<a href="#!" class="text-reset">Vue</a>
						</p>
						<p>
							<a href="#!" class="text-reset">Laravel</a>
						</p>
					</div>
					<!-- Grid column -->

					<!-- Grid column -->
					<div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
						<!-- Links -->
						<h6 class="text-uppercase fw-bold mb-4">Useful links</h6>
						<p>
							<a href="#" class="text-reset"
								onclick="document.getElementById('v01').style.display='block'">Become
								a Vendor</a>
						</p>
						<div id="v01" class="modal">
							<form class="modal-content animate"
								action="fashion-factory/addVendor" method="post">
								<div class="imgcontainer">
									<span
										onclick="document.getElementById('v01').style.display='none'"
										class="close" title="Close Modal">×</span> <img
										src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtn3ZdZW5JSeKSB1QDDpbS9FPw-ig9BnfxJA&usqp=CAU"
										alt="Avatar" class="avatar">
								</div>

								<div class="container">
									<label><b>Full Name</b></label> <input type="text"
										placeholder="Enter Full Name" name="vendor_name" required>
									<label><b>Email Address</b></label> <input type="email"
										placeholder="Enter Email Address" name="vendor_email_id" required>
									<label><b>Contact Number</b></label> <input type="tel"
										placeholder="Enter Contact Number" name="vendor_contact_number" pattern="[6789][0-9]{9}" title="mobile number should be 10 digit only and started with 6,7,8 or 9 digit otherwise not valid" required>
									<label><b>Shop Name</b></label> <input type="text"
										placeholder="Enter Shop Name" name="vendor_shop_name" required>
									<label><b>Shop Image(Only Url)</b></label> <input type="url"
										placeholder="Enter Url of shop image" name="image" required>
									<label><b>Password</b></label> <input type="password"
										placeholder="Enter Password" name="vendor_password" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="Password should contain minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character" required>
									<input type="date" placeholder="Enter JOB" name="vendor_joiningdate" value="<%= java.time.LocalDate.now() %>" hidden="hidden" required>
									<b>&#8226; Billing Address</b><br>
									<label><b>House No./Society</b></label> <input type="text"
										placeholder="Enter House no./ society" name="house_no" required>
									<label><b>Street</b></label> <input type="text"
										placeholder="Enter Street" name="street" required>
									<label><b>City</b></label> <input type="text"
										placeholder="Enter City" name="city" required>
									<label><b>District</b></label> <input type="text"
										placeholder="Enter District" name="district" required>
									<label><b>State</b></label> <input type="text"
										placeholder="Enter State" name="state" required>
									<label><b>Pincode</b></label> <input type="text"
										placeholder="Enter Pincode" name="pincode" required>
									<button type="reset">Reset</button>
									<button type="submit">Register</button>
								</div>

								<div class="container" style="background-color: #f1f1f1">
									<button type="button"
										onclick="document.getElementById('v01').style.display='none'"
										class="cancelbtn">Cancel</button>
								</div>
							</form>
						</div>

						<script>
							var modal = document.getElementById('v01');
							window.onclick = function(event) {
								if (event.target == modal) {
									modal.style.display = "none";
								}
							}
						</script>


						<p>
							<a href="#!" class="text-reset">Settings</a>
						</p>
						<p>
							<a href="#!" class="text-reset">Orders</a>
						</p>
						<p>
							<a href="#!" class="text-reset">Help</a>
						</p>
					</div>
					<!-- Grid column -->

					<!-- Grid column -->
					<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
						<!-- Links -->
						<h6 class="text-uppercase fw-bold mb-4">Contact</h6>
						<p>
							<i class="fas fa-home me-3"></i> New York, NY 10012, US
						</p>
						<p>
							<i class="fas fa-envelope me-3"></i> info@example.com
						</p>
						<p>
							<i class="fas fa-phone me-3"></i> + 01 234 567 88
						</p>
						<p>
							<i class="fas fa-print me-3"></i> + 01 234 567 89
						</p>
					</div>
					<!-- Grid column -->
				</div>
				<!-- Grid row -->
			</div>
		</section>
		<!-- Section: Links  -->

		<!-- Copyright -->
		<div class="text-center p-4"
			style="background-color: rgba(0, 0, 0, 0.05);">
			© 2021 Copyright: <a class="text-reset fw-bold" href="#!">Fashion
				Factory.com</a>
		</div>
		<!-- Copyright -->
	</footer>
	<!-- Footer -->
</body>
</html>
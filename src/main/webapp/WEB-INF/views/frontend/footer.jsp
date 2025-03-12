<footer class="bg-light text-dark mt-5">
		<div class="container py-4">
			<!-- Row 1: Logo -->
			<div class="row">
				<div class="col text-center">
				<div class="text-center d-flex flex-column align-items-center"
								style="gap: 10px;">
								<img src="${cp}/${company.logo}" class="img-fluid"
									style="max-height: 100px; width: auto;" alt="logo">
								<h1 class="h4 text-secondary mb-2">${company.name}</h1>
								
							</div>
				
				</div>
			</div>

			<!-- Row 2: Social Links -->
			<div class="row mt-3">
				<div class="col text-center">
					<a href="#" class="text-dark me-3"> <i class="bi bi-facebook"
						style="font-size: 1.5rem;"></i>
					</a> <a href="#" class="text-dark me-3"> <i class="bi bi-twitter"
						style="font-size: 1.5rem;"></i>
					</a> <a href="#" class="text-dark me-3"> <i class="bi bi-instagram"
						style="font-size: 1.5rem;"></i>
					</a> <a href="#" class="text-dark me-3"> <i class="bi bi-linkedin"
						style="font-size: 1.5rem;"></i>
					</a>
				</div>
			</div>

			<!-- Row 3: Menu or Content -->
			<div class="row mt-3">
				<div class="col-md-4 text-center">
					<h6>About Us</h6>
					<p>Summary of about Us</p>
				</div>
				<div class="col-md-4 text-center">
					<h6>Quick Links</h6>
					<ul class="list-unstyled">
						<li><a href="${cp}/home" class="text-dark">Home</a></li>
						<li><a href="${cp}/product" class="text-dark">Product</a></li>
						<li><a href="${cp}/about" class="text-dark">About</a></li>
					</ul>
				</div>
				<div class="col-md-4 text-center">
					<h6>Contact Us</h6>
					<p>Email: ${company.email}</p>
					<p>Phone: ${company.phone}</p>
				</div>
			</div>
		</div>

		<!-- Copyright Section -->
		<div class="bg-dark text-light py-3">
			<div class="container text-center">
				<small>&copy; 2024 ${company.name}. All rights reserved.</small>
			</div>
		</div>
	</footer>
<style>
a{
text-decoration:none;
}
</style>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
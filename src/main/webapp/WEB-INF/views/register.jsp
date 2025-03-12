<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" href="${cp}/${company.logo}" type="image/x-icon">
<title>Bills - User Register</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.error-message {
	color: red;
	font-size: 0.9rem;
}
</style>
<script>
	function validateForm(event) {
		let isValid = true;

		// Get form fields
		const name = document.getElementById("name");
		const phone = document.getElementById("phone");
		const address = document.getElementById("address");
		const email = document.getElementById("email");
		const password = document.getElementById("password");
		const confirmPassword = document.getElementById("confirmPassword");
		const imageFile = document.getElementById("imageFile");

		// Validation patterns
		const nameRegex = /^[A-Za-z\s]{3,50}$/;
		const phoneRegex = /^9\d{9}$/;
		const addressRegex = /^[A-Za-z0-9,\s]{5,}$/;
		const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$/;
		const imageRegex = /\.(jpg|jpeg|png)$/i;

		// Error handling functions
		function setError(input, errorId, message) {
			const errorSpan = document.getElementById(errorId);
			errorSpan.textContent = message;
			isValid = false;
		}

		function clearError(errorId) {
			const errorSpan = document.getElementById(errorId);
			errorSpan.textContent = "";
		}

		// Name validation
		if (!nameRegex.test(name.value)) {
			setError(name, "nameError",
					"Enter a valid Name (3-50 alphabetic characters).");
		} else {
			clearError("nameError");
		}

		// Phone validation
		if (!phoneRegex.test(phone.value)) {
			setError(phone, "phoneError",
					"Enter a valid phone number (10 digits, starting with 9).");
		} else {
			clearError("phoneError");
		}

		// Address validation
		if (!addressRegex.test(address.value)) {
			setError(address, "addressError",
					"Enter a valid Address (minimum 5 characters).");
		} else {
			clearError("addressError");
		}

		// Email validation
		if (!emailRegex.test(email.value)) {
			setError(email, "emailError", "Enter a valid email address.");
		} else {
			clearError("emailError");
		}

		// Password validation
		if (!passwordRegex.test(password.value)) {
			setError(
					password,
					"passwordError",
					"Password must have at least 8 characters, including uppercase, lowercase, and special characters.");
		} else {
			clearError("passwordError");
		}

		// Confirm Password validation
		if (password.value !== confirmPassword.value) {
			setError(confirmPassword, "confirmPasswordError",
					"Passwords do not match.");
		} else {
			clearError("confirmPasswordError");
		}

		// Image file validation
		if (!imageRegex.test(imageFile.value)) {
			setError(imageFile, "imageError",
					"Image file must be in JPG, JPEG, or PNG format.");
		} else {
			clearError("imageError");
		}

		if (!isValid) {
			event.preventDefault();
		}
	}
</script>
</head>
<body class="bg-gradient-primary">
	<div class="container">
		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<div class="row">
					<div class="col-lg-7 mx-auto">
						<div class="p-5">
							<div class="text-center">
								<img src="${cp}/${company.logo}" class="img-fluid"
									style="max-height: 150px;" alt="logo">
								<h1 class="h4 text-secondary mb-4">${company.name}</h1>
							</div>
							<form name="registerForm" class="user" action="${cp}/register"
								method="post" enctype="multipart/form-data"
								onsubmit="validateForm(event)">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}">

								<div class="form-group">
									<label for="name">Name</label> <input type="text" id="name"
										class="form-control" name="name" placeholder="Enter your name">
									<span id="nameError" class="error-message"></span>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<label for="phone">Phone</label> <input type="text" id="phone"
											class="form-control" name="phone"
											placeholder="Enter your phone number"> <span
											id="phoneError" class="error-message"></span>
									</div>
									<div class="col-sm-6">
										<label for="address">Address</label> <input type="text"
											id="address" class="form-control" name="address"
											placeholder="Enter your address"> <span
											id="addressError" class="error-message"></span>
									</div>
								</div>



								<div class="form-group">
									<label for="email">Email</label> <input type="email" id="email"
										class="form-control" name="email"
										placeholder="Enter your email"> <span id="emailError"
										class="error-message"></span>
								</div>

								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<label for="password">Password</label> <input type="password"
											id="password" class="form-control" name="password"
											placeholder="Enter your password"> <span
											id="passwordError" class="error-message"></span>
									</div>
									<div class="col-sm-6">
										<label for="confirmPassword">Confirm Password</label> <input
											type="password" id="confirmPassword" class="form-control"
											name="confirmPassword" placeholder="Confirm your password">
										<span id="confirmPasswordError" class="error-message"></span>
									</div>
								</div>



								<div class="form-group">
									<label for="imageFile">Profile Image</label> <input type="file"
										id="imageFile" class="form-control" name="imageFile"
										onchange="previewImage(event)"> <span id="imageError"
										class="error-message"></span> <img id="imagePreview"
										style="display: none; margin-top: 10px; max-width: 100px;"
										alt="Preview">
								</div>

								<button type="submit" class="btn btn-primary btn-block">Register</button>
							</form>
							<hr>
							<div class="text-center">
								<a href="${cp}/userlogin" class="small">Already have an
									account? Login!</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		function previewImage(event) {
			const file = event.target.files[0];
			const preview = document.getElementById("imagePreview");
			if (file) {
				const reader = new FileReader();
				reader.onload = function(e) {
					preview.src = e.target.result;
					preview.style.display = "block";
				};
				reader.readAsDataURL(file);
			} else {
				preview.style.display = "none";
			}
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

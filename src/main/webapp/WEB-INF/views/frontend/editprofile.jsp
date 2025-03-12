<%@ include file="header.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<c:if test="${not empty success}">
	<div class="alert alert-success fw-bold" role="alert">${success}</div>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-danger fw-bold" role="alert">${error}</div>
</c:if>
<div
	class="container-fluid  d-flex align-items-center justify-content-center"
	style="min-height: 100vh;">
	<div class="card  border-0 shadow p-3" style="width: 60%;">
		<div class="card-body p-2">
<a href="${cp}/user/userprofile" class="btn btn-primary btn-sm"> <i class="fa fa-arrow-left"> </i> Back</a>
			<div class="text-center">
				<h1 class="h2 text-gray-900 mb-4">Update Your Account</h1>
			</div>
			<form class="user" action="${cp}/user/editprofile" method="post"
				enctype="multipart/form-data" onSubmit="validateUserForm(event)">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

				<div class="form-group">
					<label for="id">User Id:</label>
					<input type="text" class="form-control" value="${user.id}" name="id" readonly="true">
				</div>

				<div class="form-group">
					<label for="name">Name:</label>
					<input type="text" id="name" class="form-control" name="name"
						placeholder="Enter your name" value="${user.name}" />
					<span class="text-danger small error-message"></span>
				</div>

				<div class="form-group row">
					<div class="col-sm-6">
						<label for="phone">Phone:</label>
						<input type="text" id="phone" class="form-control" name="phone"
							placeholder="Enter your phone number" value="${user.phone}" />
						<span class="text-danger small error-message"></span>
					</div>
					<div class="col-sm-6">
						<label for="address">Address:</label>
						<input type="text" id="address" class="form-control" name="address"
							placeholder="Enter your address" value="${user.address}" />
						<span class="text-danger small error-message"></span>
					</div>
				</div>

				<div class="form-group">
					<label for="email">Email:</label>
					<input type="email" id="email" class="form-control" name="email" value="${user.email}" />
					<span class="text-danger small error-message"></span>
				</div>

				<div class="form-group">
					<label for="imageFile">Profile Picture:</label>
					<input type="hidden" name="oldphoto" value="${user.photo}" />
					<input type="hidden" name="password" value="${user.password}" />
					<input type="file" id="imageFile" class="form-control" name="imageFile"
						onchange="previewImage(event)" />
					<span class="text-danger small error-message"></span>
					<img id="imagePreview" src="${cp}/${user.photo}" alt="Profile Picture Preview"
						class="mt-3 img-thumbnail" style="max-width: 200px; display: block;" />
				</div>

				<div class="text-center">
					<button type="submit" class="btn btn-primary btn-block">
						<i class="fa fa-right"></i> Update Account
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="footer.jsp"%>

<script>
	// JavaScript for live image preview
	function previewImage(event) {
		const reader = new FileReader();
		reader.onload = function() {
			const output = document.getElementById('imagePreview');
			output.src = reader.result;
		};
		reader.readAsDataURL(event.target.files[0]);
	}

	function validateUserForm(event) {
		let isValid = true;

		const form = event.target;
		const name = form["name"];
		const email = form["email"];
		const phone = form["phone"];
		const address = form["address"];
		const imageFile = form["imageFile"];
		const password = form["password"] || null;

		const nameRegex = /^[A-Za-z\s]{3,50}$/;
		const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		const phoneRegex = /^9\d{9}$/;
		const addressRegex = /^[A-Za-z0-9,\s]{5,}$/;
		const imageRegex = /\.(jpg|jpeg|png)$/i;

		function setError(input, message) {
			const errorSpan = input.closest('.form-group').querySelector('.error-message');
			if (errorSpan) {
				errorSpan.textContent = message;
			}
			isValid = false;
		}

		function clearError(input) {
			const errorSpan = input.closest('.form-group').querySelector('.error-message');
			if (errorSpan) {
				errorSpan.textContent = "";
			}
		}

		if (!nameRegex.test(name.value)) {
			setError(name, "Enter a valid Name.");
		} else {
			clearError(name);
		}

		if (!emailRegex.test(email.value)) {
			setError(email, "Enter a valid email address.");
		} else {
			clearError(email);
		}

		if (!phoneRegex.test(phone.value)) {
			setError(phone, "Enter a valid phone number.");
		} else {
			clearError(phone);
		}

		if (!addressRegex.test(address.value)) {
			setError(address, "Enter a valid address.");
		} else {
			clearError(address);
		}

		if (imageFile.value.trim() !== "" && !imageRegex.test(imageFile.value)) {
			setError(imageFile, "Image file must be in JPG, JPEG, or PNG format.");
		} else {
			clearError(imageFile);
		}

		if (!isValid) {
			event.preventDefault();
		}
	}
</script>

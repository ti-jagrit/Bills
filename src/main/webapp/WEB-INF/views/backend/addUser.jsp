<%@ include file="../topbar.jsp"%>

<div class="container my-4">
	<c:choose>
		<c:when test="${edit ne true}">
			<div class="card shadow-lg">
				<div class="card-body">
					<a href="${cp}/admin/user/list" class="btn btn-info"><i
						class="fa fa-list"></i> View User List</a>
					<div class="text-center py-2">
						<h1 class="h2 mb-0">Add User</h1>
					</div>
					<form class="user" action="${cp}/admin/user/add" method="post"
						onsubmit="validateUserForm(event)">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<div class="form-group">
							<label for="name">Name:</label> <input type="text"
								class="form-control" name="name" placeholder="Enter User's Name">
							<span class="error-message text-danger"> <c:if
									test="${errors.name ne null}">${errors.name}</c:if>
							</span>
						</div>

						<div class="form-group row">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<label for="email">Email:</label> <input type="text"
									class="form-control" name="email" placeholder="Enter Email">
								<span class="error-message text-danger"> <c:if
										test="${errors.email ne null}">${errors.email}</c:if>
								</span>
							</div>
							<div class="col-sm-6">
								<label for="password">Password:</label> <input type="password"
									class="form-control" name="password"
									placeholder="Enter Password"> <span
									class="error-message text-danger"></span>
							</div>
						</div>

						<div class="form-group row">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<label for="phone">Phone:</label> <input type="number"
									class="form-control" name="phone"
									placeholder="Enter Phone Number"> <span
									class="error-message text-danger"> <c:if
										test="${errors.phone ne null}">${errors.phone}</c:if>
								</span>
							</div>
							<div class="col-sm-6 mb-3 mb-sm-0">
								<label for="address">Address:</label> <input type="text"
									class="form-control" name="address" placeholder="Enter Address">
								<span class="error-message text-danger"> <c:if
										test="${errors.address ne null}">${errors.address}</c:if>
								</span>
							</div>
						</div>



						<div class="form-group">
							<label for="photo">Photo:</label> <input type="file"
								class="form-control" name="imageFile"> <span
								class="error-message text-danger"> <span
								class="error-message text-danger"> <c:if
										test="${errors.imageFile ne null}">${errors.imageFile}</c:if>
							</span>
							</span>
						</div>


						<div class="form-group d-flex justify-content-between">
							<input type="submit" class="btn btn-success ml-3"
								value="Add User"> <input type="reset"
								class="btn btn-warning ml-2" value="Reset Form">
						</div>

					</form>
				</div>
				<c:if test="${not empty errors}">
					<ul>
						<c:forEach var="valid_errors" items="${errors}">
							<li>${error.defaultMessage}</li>
						</c:forEach>
					</ul>
				</c:if>
			</div>
		</c:when>
		<c:otherwise>
			<div class="card shadow-lg">
				<div class="card-body">
					<div class="text-center py-2">
						<h1 class="h4 mb-0">Update User</h1>
					</div>
					<form class="user" action="${cp}/admin/user/edit" method="post"
						enctype="multipart/form-data" onsubmit="validateUserForm(event)">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<div class="form-group">
							<label for="name">User ID:</label> <input type="text"
								class="form-control" name="id" value="${us.id}" readonly="true">
						</div>

						<div class="form-group">
							<label for="name">Name:</label> <input type="text"
								class="form-control" name="name" value="${us.name}" required>
							<span class="error-message text-danger"></span>
						</div>
						<div class="form-group">
							<label for="name">Email:</label> <input type="text"
								class="form-control" name="email" value="${us.email}" required>
							<span class="error-message text-danger"></span>
						</div>

						<div class="form-group row">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<label for="name">Phone:</label> <input type="number"
									class="form-control" name="phone" value="${us.phone}" required>
								<span class="error-message text-danger"></span>
							</div>
							<div class="col-sm-6">
								<label for="name">User Name:</label> <input type="text"
									class="form-control" name="userName" value="${us.userName}">
								<span class="error-message text-danger"></span>
							</div>
						</div>

						<div class="form-group row">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<label for="address">Address:</label> <input type="text"
									class="form-control" name="address" value="${us.address}"
									required> <span class="error-message text-danger"></span>
							</div>
							<div class="col-sm-6">
								<input type="hidden" name="oldphoto" value="${user.photo}" /> <input
									type="hidden" name="password" value="${user.password}" /> <label
									for="photo">Photo:</label> <input type="file"
									class="form-control" name="imageFile"> <span
									class="error-message text-danger"></span>
							</div>
						</div>
						<div class="text-center">
							<input type="submit" class="btn btn-success btn-block"
								value="Update User">
						</div>
					</form>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script>
	function validateUserForm(event) {
		let isValid = true;

		const form = event.target;
		const name = form["name"];
		const email = form["email"];
		const phone = form["phone"];
		const username = form["userName"];
		const address = form["address"];
		const imageFile = form["imageFile"];
		const password = form["password"] || null;

		const nameRegex = /^[A-Za-z\s]{3,50}$/;
		const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		const phoneRegex = /^9\d{9}$/;
		const usernameRegex = /^[A-Za-z._]{3,20}$/;
		const addressRegex = /^[A-Za-z0-9,\s]{5,}$/;
		const imageRegex = /\.(jpg|jpeg|png)$/i;

		function setError(input, message) {
			const errorSpan = input.closest('.form-group').querySelector(
					'.error-message');
			if (errorSpan) {
				errorSpan.textContent = message;
			}
			isValid = false;
		}

		function clearError(input) {
			const errorSpan = input.closest('.form-group').querySelector(
					'.error-message');
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

		if (username.value.trim() !== "") {
			if (!usernameRegex.test(username.value)) {
				setError(username,
						"Username must contain letters, dots, or underscores.");
			} else {
				clearError(username);
			}
		} else {
			clearError(username);
		}

		if (!addressRegex.test(address.value)) {
			setError(address, "Enter a valid address.");
		} else {
			clearError(address);
		}

		if (password) {
		    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$/;
		    if (!passwordPattern.test(password.value)) {
		        setError(password, "Password must be at least 8 characters contins upper,lower and special char.");
		    } else {
		        clearError(password);
		    }
		}
		
		if (imageFile.value.trim() !== "" && !imageRegex.test(imageFile.value)) {
			setError(imageFile,
					"Image file must be in JPG, JPEG, or PNG format.");
		} else {
			clearError(imageFile);
		}

		if (!isValid) {
			event.preventDefault();
		}
	}
</script>

<%@ include file="../footer.jsp"%>
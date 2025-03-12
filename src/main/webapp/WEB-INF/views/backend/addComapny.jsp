<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<%@ include file="../topbar.jsp"%>

<c:if test="${not empty success}">
	<div class="alert alert-success fw-bold" role="alert">${success}</div>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-danger fw-bold" role="alert">${error}</div>
</c:if>

<div class="container my-4">
	<!-- Card Wrapper for Add Product Form and Product List -->


	<div class="card shadow-lg">
		<div class="card-body">
			<div class="text-center py-2">
				<h1 class="h4 mb-0">Your Comapny</h1>
			</div>
			<form class="user" action="${cp}/admin/company/add" method="post"
				enctype="multipart/form-data" onsubmit="return validateForm()">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />

				<!-- Company Name -->
				<div class="form-group">
					<label for="name">Company Name:</label> <input type="hidden"
						class="form-control" id="id" name="id" value="1"> <input
						type="text" class="form-control" id="name" name="name"
						value="${company.name}"> <span id="nameError"
						class="text-danger"></span>
				</div>

				<!-- Register No and PAN -->
				<div class="form-group row">
					<div class="col-sm-6 mb-3 mb-sm-0">
						<label for="regNo">Register No:</label> <input type="text"
							class="form-control" id="reg" name="regNo"
							value="${company.regNo}"> <span id="regError"
							class="text-danger"></span>
					</div>
					<div class="col-sm-6">
						<label for="cp">PAN/VAT:</label> <input type="text"
							class="form-control" id="pan" name="pan" value="${company.pan}">
						<span id="panError" class="text-danger"></span>
					</div>
				</div>

				<!-- Address -->
				<div class="form-group">
					<label for="address">Address:</label> <input type="text"
						class="form-control" id="address" name="address"
						value="${company.address}"> <span id="addressError"
						class="text-danger"></span>
				</div>

				<!-- Email -->
				<div class="form-group">
					<label for="email">E-mail:</label> <input type="email"
						class="form-control" id="email" name="email"
						value="${company.email}"> <span id="emailError"
						class="text-danger"></span>
				</div>

				<!-- Phone No and Website -->
				<div class="form-group row">
					<div class="col-sm-6 mb-3 mb-sm-0">
						<label for="phone">Phone No:</label> <input type="text"
							class="form-control" id="phone" name="phone"
							value="${company.phone}"> <span id="phoneError"
							class="text-danger"></span>
					</div>
					<div class="col-sm-6">
						<label for="website">Web Site:</label> <input type="text"
							class="form-control" id="website" name="website"
							value="${company.website}"> <span id="websiteError"
							class="text-danger"></span>
					</div>
				</div>

				<!-- Company Logo -->
				<div class="form-group">
					<label for="imageFile">Company Logo:</label> <input type="file"
						class="form-control" id="logoImage" name="logoImage"
						onchange="previewImage(event)"> <span id="imageFileError"
						class="text-danger"></span>
						<input type="hidden" name="oldImage" value="${company.logo}">

					<!-- Image preview section -->
					<img id="imagePreview" src="#" alt="Image Preview"
						style="display: none; max-width: 150px; margin-top: 10px;" />
				</div>

				<div class="text-center">
					<!-- Show existing logo if no new image is selected -->
					<img id="currentLogo" src="${cp}/${company.logo}"
						alt="${company.logo}" height="150px" />
				</div>

				<!-- Submit and Reset buttons -->
				<div class="form-group d-flex justify-content-between">
					<input type="submit" class="btn btn-success ml-3"
						value="Save Information"> <input type="reset"
						class="btn btn-warning ml-2" value="Reset Form"
						onclick="resetPreview()">
				</div>
			</form>
		</div>
	</div>

</div>
<script>
function validateForm() {
    let isValid = true;
    // Reset all error messages
    document.querySelectorAll('.text-danger').forEach(function(span) {
        span.textContent = '';
    });

    // Validate Company Name (Text and spaces only)
 let name = document.getElementById('name').value;
if (!name.trim()) {
    document.getElementById('nameError').textContent = "'Name' is required.";
    isValid = false;
} else if (!/^[A-Za-z\s\.]+$/.test(name)) {
    document.getElementById('nameError').textContent = "Enter a valid 'Name' (only text, spaces, and dots are allowed).";
    isValid = false;
}


    // Validate Register No (Numbers and /)
    let regNo = document.getElementById('reg').value;
    if (!regNo.trim() && !document.getElementById('pan').value.trim()) {
        document.getElementById('regError').textContent = "'Register No' or 'PAN' is required.";
        isValid = false;
    } else if (regNo.trim() && !/^[0-9\/]+$/.test(regNo)) {
        document.getElementById('regError').textContent = "Enter a valid 'Register No'.";
        isValid = false;
    }

    // Validate PAN (Numbers and max 9 digits)
    let pan = document.getElementById('pan').value;
    if (!pan.trim() && !regNo.trim()) {
        document.getElementById('panError').textContent = "'PAN' or 'Register No' is required.";
        isValid = false;
    } else if (pan.trim() && !/^[0-9\/]{1,9}$/.test(pan)) {
        document.getElementById('panError').textContent = "Please enter a valid 'PAN'.";
        isValid = false;
    }

    // Validate Address (Alphanumeric, commas, spaces, slashes allowed)
    let address = document.getElementById('address').value;
    if (!address.trim()) {
        document.getElementById('addressError').textContent = "Address is required.";
        isValid = false;
    } else if (!/^[A-Za-z0-9\s,\/]+$/.test(address)) {
        document.getElementById('addressError').textContent = "Please enter a valid Address.";
        isValid = false;
    }

    // Validate Email (Proper email format)
    let email = document.getElementById('email').value;
    if (!email.trim()) {
        document.getElementById('emailError').textContent = "Email is required.";
        isValid = false;
    } else if (!/\S+@\S+\.\S+/.test(email)) {
        document.getElementById('emailError').textContent = "Please enter a valid Email address.";
        isValid = false;
    }

    // Validate Phone No (8 or 10 digits, starts with 9 or 0)
    let phone = document.getElementById('phone').value;
    if (!phone.trim()) {
        document.getElementById('phoneError').textContent = "'Phone Number' is required.";
        isValid = false;
    } else if (!/^[9|0][0-9]{7,9}$/.test(phone)) {
        document.getElementById('phoneError').textContent = "Please enter a valid Phone Numbe";
        isValid = false;
    }

    // Validate Website (Optional, if provided, must be valid URL format)
  let website = document.getElementById('website').value;
if (website.trim() && !/^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(\/[^\s]*)?$/.test(website)) {
    document.getElementById('websiteError').textContent = "Please enter a valid 'Website' URL.";
    isValid = false;
}

    // Validate Image File (PNG, JPG, JPEG and max size 4MB)
    let imageFile = document.getElementById('logoImage').files[0];
    if (imageFile) {
        let fileSize = imageFile.size / 1024 / 1024; // in MB
        let fileType = imageFile.type;

        if (fileSize > 4) {
            document.getElementById('imageFileError').textContent = "Image size must be less than 4MB.";
            isValid = false;
        }

        if (!['image/png', 'image/jpeg', 'image/jpg'].includes(fileType)) {
            document.getElementById('imageFileError').textContent = "Only PNG, JPG, and JPEG files are allowed.";
            isValid = false;
        }
    }

    return isValid;
}


function previewImage(event) {
    var file = event.target.files[0];  // Get the selected file
    var reader = new FileReader();

    // If a file is selected, show the preview
    if (file) {
        reader.onload = function() {
            var preview = document.getElementById('imagePreview');
            preview.style.display = 'block';  // Show the preview image
            preview.src = reader.result;  // Set the preview image source
            document.getElementById('currentLogo').style.display = 'none';  // Hide the current logo if a new one is chosen
        };
        reader.readAsDataURL(file);  // Read the file as a data URL for preview
    }
}

function resetPreview() {
    // Reset the preview image and logo visibility
    document.getElementById('imagePreview').style.display = 'none';
    document.getElementById('currentLogo').style.display = 'block';
}
</script>




<%@ include file="../footer.jsp"%>
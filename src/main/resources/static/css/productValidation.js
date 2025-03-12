function validateForm() {
	let valid = true;

	// Reset all error messages
	document.querySelectorAll('.text-danger').forEach(e => e.textContent = '');

	// Product Title validation
	const name = document.getElementById("name").value.trim();
	const nameRegex = /^[A-Za-z0-9 ]{5,50}$/;
	if (!nameRegex.test(name)) {
		document.getElementById("nameError").textContent = "Invalid Product Title";
		valid = false;
	}

	// Category validation
	const category = document.getElementById("category").value;
	if (!category) {
		document.getElementById("categoryError").textContent = "Select Category";
		valid = false;
	}

	// Selling Price validation
	const sp = document.getElementById("sp").value;
	const cp = document.getElementById("cp").value;
	if (!sp || isNaN(sp) || sp <= 0 || sp.length > 6) {
		document.getElementById("spError").textContent = "Invalid Selling Price";
		valid = false;
	}
	if (!cp || isNaN(cp) || cp <= 0 || cp.length > 6) {
		document.getElementById("cpError").textContent = "Invalid Cost Price";
		valid = false;
	}
	if (sp && cp && parseFloat(sp) <= parseFloat(cp)) {
		document.getElementById("spError").textContent = "Low Selling Price";
		valid = false;
	}

	// Quantity validation
	const qty = document.getElementById("qty").value;
	if (!qty || qty <= 1 || qty > 9999) {
		document.getElementById("qtyError").textContent = "Quantity must be in between 1-9999";
		valid = false;
	}

	// Description validation
	const description = document.getElementById("description").value.trim();
	if (description && description.length < 20) {
		document.getElementById("descriptionError").textContent = "Min 20 chars";
		valid = false;
	}

	// Image validation
	const isEdit = document.querySelector('form[action$="update"]') !== null;
	const imageFile = document.getElementById("imageFile").files[0];
	if (!isEdit && !imageFile) {
		document.getElementById("imageError").textContent = "Image file is required.";
		valid = false;
	} else if (imageFile) {
		const allowedTypes = ["image/jpeg", "image/jpg", "image/png"];
		if (!allowedTypes.includes(imageFile.type)) {
			document.getElementById("imageError").textContent = "Only JPG, JPEG, and PNG files are allowed.";
			valid = false;
		}
	}

	return valid;
}

// Image Preview
document.getElementById("imageFile").addEventListener("change", function() {
	const file = this.files[0];
	if (file) {
		const reader = new FileReader();
		reader.onload = function(e) {
			const preview = document.getElementById("imagePreview");
			preview.src = e.target.result;
			preview.style.display = "block";
		};
		reader.readAsDataURL(file);
	}
});

// Reset Image Preview
function resetPreview() {
	const preview = document.getElementById("imagePreview");
	preview.src = "#";
	preview.style.display = "none";
}

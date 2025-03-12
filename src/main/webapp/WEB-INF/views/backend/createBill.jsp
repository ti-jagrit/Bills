<%@ include file="../topbar.jsp"%>
<c:if test="${not empty success}">
	<div class="alert alert-success fw-bold" role="alert">${success}
	</div>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-danger fw-bold" role="alert">${error}</div>
</c:if>
<div class="text-center bg-primary text-white py-2">
	<h1 class="h4 mb-0">Create a New Bill</h1>
</div>
<div class="container m-2">
	<a href="${cp}/admin/bill/list" class="btn btn-success"> <i
		class="fa fa-list"></i> View Bills
	</a>
</div>

<div class="container mt-3">
	<form action="/admin/bill/create-bill" method="post"
		onsubmit="return validateForm()">
		<!-- Customer Selection -->
		<div class="mb-3">
			<label for="customer" class="form-label">Select Customer</label> <select
				id="customer" name="customerId" class="form-select" required>
				<c:forEach items="${customer_list}" var="user">
					<c:if test="${user.userRole.role != 'ROLE_ADMIN'}">
						<option value="${user.id}">${user.name}</option>
					</c:if>
				</c:forEach>
			</select> <a href="${cp}/admin/user/add" class="text-info"><strong>Add
					New Customer</strong></a>
			<div class="text-danger small" id="customerError"></div>
		</div>

		<!-- Bill Number -->
		<div class="mb-3">
			<label for="bill_no">Bill Number</label> <input type="number"
				class="form-control" id="bill_no" name="bill_no" value="${pev_no}" readonly>
			<div class="text-danger small" id="billNoError"></div>
		</div>

		<!-- Tax and Discount -->
		<div class="form-group row">
			<div class="col-sm-6 mb-3 mb-sm-0">
				<label for="tax" class="form-label">Tax</label>
				<div class="form-control p-2">
					<input type="checkbox" id="tax" name="tax" value="13"
						class="form-check-input"> <label for="tax"
						class="form-check-label">Apply 13% Tax</label>
				</div>
				<div class="text-danger small" id="taxError"></div>
			</div>
			<div class="col-sm-6">
				<label for="discount">Discount in percentage(%)</label> <input type="number"
					class="form-control" id="discount" name="discount">
				<div class="text-danger small" id="discountError"></div>
			</div>
		</div>

		<!-- Product Selection -->
		<div class="mb-3">
			<label for="productSelect" class="form-label">Add Products</label> <select
				id="productSelect" name="productIds" class="form-select"
				multiple="multiple">
				<c:forEach items="${product_list}" var="product">
					<option value="${product.id}" data-name="${product.name}">
						<span class="text-muted small">${product.category.name}:</span> <span
							class="fw-bold">${product.name}</span>
					</option>
				</c:forEach>
			</select>
			<div class="text-danger small" id="productError"></div>
		</div>







		<!-- Product Table -->
		<div class="table-responsive mt-3">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Product ID</th>
						<th>Product Name</th>
						<th>Quantity</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody id="productRows">
					<!-- Dynamic rows will be appended here -->
				</tbody>
			</table>
		</div>

		<!-- Submit Button -->
		<button type="submit" class="btn btn-primary">
			<i class="fa fa-plus"> </i> Create Bill
		</button>

	</form>
</div>

<script>
    function validateForm() {
        let isValid = true;

        // Clear previous error messages
        document.getElementById('billNoError').textContent = '';
        document.getElementById('taxError').textContent = '';
        document.getElementById('discountError').textContent = '';
        document.getElementById('productError').textContent = '';

        // Validate Bill Number
        const billNo = document.getElementById('bill_no').value.trim();
        if (!billNo || isNaN(billNo) || parseInt(billNo) <= 0) {
            document.getElementById('billNoError').textContent = 'Please enter a valid bill number.';
            isValid = false;
        }

        // Validate Tax and Discount
        
     if (discount) {
    if (discount < 1 || discount > 100) {
        document.getElementById('discountError').textContent = 'Discount must be between 1 and 100.';
        isValid = false;
    } else {
        document.getElementById('discountError').textContent = ''; // Clear error
    }
} else {
    document.getElementById('discountError').textContent = ''; // Allow null value
}

        // Validate Product Selection
        const productSelect = document.getElementById('productSelect');
        if (!productSelect.selectedOptions.length) {
            document.getElementById('productError').textContent = 'Please select at least one product.';
            isValid = false;
        }

        return isValid;
    }
</script>
<%@ include file="../footer.jsp"%>


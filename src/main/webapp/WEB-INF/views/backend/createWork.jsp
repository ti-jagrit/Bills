<%@ include file="../topbar.jsp"%>
<c:if test="${not empty success}">
	<div class="alert alert-success fw-bold" role="alert">${success}
	</div>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-danger fw-bold" role="alert">${error}</div>
</c:if>
<div class="text-center bg-primary text-white py-2">
	<h1 class="h4 mb-0">Create a New Work</h1>
</div>
<div class="container m-2">
	<a href="${cp}/admin/work/view" class="btn btn-success"> <i
		class="fa fa-list"></i> View Works
	</a>
</div>

<div class="container mt-3">
	<form action="/admin/work/add" method="post"
		onsubmit="return validateForm()">


		<div class="form-group">
			<label for="name">Work Title:</label> <input type="text"
				class="form-control" id="name" name="name"
				placeholder="Enter Work Name"> <span id="nameError"
				class="text-danger"></span>
		</div>
		<div class="form-group row">
			<div class="col-sm-6 mb-3 mb-sm-0">
				<label for="customer">Select Customer:</label> <select
					class="form-control" id="customer" name="customer">
					<option value="">-- Select Customer --</option>
					<c:forEach items="${customer_list}" var="customer">
						<c:if test="${customer.userRole.role!='ROLE_ADMIN'}">
							<option value="${customer.id}">${customer.name}</option>
						</c:if>
					</c:forEach>
				</select> <span id="categoryError" class="text-danger"></span> <a
					href="/admin/user/add">Add New Customer</a>
			</div>

			<div class="col-sm-6">
				<label for="qty">Quantity:</label> <input type="number"
					class="form-control" id="qty" name="qty"
					placeholder="Enter Quantity"> <span id="qtyError"
					class="text-danger"></span>
			</div>
		</div>

		<div class="form-group row">
			<div class="col-sm-6 mb-3 mb-sm-0">
				<label for="deadline">Enter Date to Complete work:</label> <input
					type="date" class="form-control" id="deliverDate"
					name="deliverDate"> <span id="deliverDateError"
					class="text-danger"></span>
			</div>
			<div class="col-sm-6">
				<label for="price">Price:</label> <input type="number"
					class="form-control" id="price" name="price"
					placeholder="Enter Price:"> <span id="priceError"
					class="text-danger"></span>
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-6 mb-3 mb-sm-0">
				<label for="Payment">Payment Status: <span
					class="text-warning sm"> (If Advance Paid) </span></label> <input
					type="number" class="form-control" id="payment"
					name="payment" placeholder="Enter Payment"> <span
					id="paymentStatusError" class="text-danger"></span>

			</div>
			<div class="col-sm-6 mb-3 mb-sm-0 mt-1">
				<label for="size">Size:</label> <input type="text"
					class="form-control" id="size" name="size" placeholder="Enter Size">
			</div>

		</div>
		<div class="form-group">
			<label for="details">Work Details:</label>
			<textarea class="form-control" id="detail" name="detail"
				placeholder="Enter the Work detail" rows="5"></textarea>
			<span id="detailError" class="text-danger"></span>
		</div>



		<div class="text-center">
			<button type="submit" class="btn btn-primary btn-block">
				<i class="fa fa-add"> </i> Create Work
			</button>
		</div>
	</form>
</div>



<script>
	function toggleAdvanceTextbox() {
		const paymentStatus = document.getElementById('paymentStatus').value;
		const advanceContainer = document
				.getElementById('advanceAmountContainer');
		const advanceInput = document.getElementById('advanceAmount');

		if (paymentStatus === 'adv') {
			advanceContainer.style.display = 'block';
		} else {
			advanceContainer.style.display = 'none';
			advanceInput.value = ''; // Clear the input if not needed
		}
	}

	function setAdvanceValue() {
		const advanceInput = document.getElementById('advanceAmount');
		const advanceValue = advanceInput.value;

		if (advanceValue) {

			const advanceOption = document
					.querySelector('#paymentStatus option[value="adv"]');
			advanceOption.value = `adv.${advanceValue}`;
		}
	}
</script>
<%@ include file="../footer.jsp"%>


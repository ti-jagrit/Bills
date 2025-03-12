<%@ include file="header.jsp"%>

<div class="container mt-5">
	<!-- Display Success or Error Messages -->
	<c:if test="${not empty success}">
		<div class="alert alert-success fw-bold" role="alert">${success}</div>
	</c:if>
	<c:if test="${not empty error}">
		<div class="alert alert-danger fw-bold" role="alert">${error}</div>
	</c:if>
	<script src="https://khalti.com/static/khalti-checkout.js"></script>


	<!-- Main Content -->
	<main>
		<div class="container">
			<div class="card border-0 shadow-lg rounded-3 my-4">
				<div class="card-header text-white text-center py-4"
					style="background-color: purple;">
					<h1 class="mt-3">Make Your Payment</h1>
				</div>
				<div class="card-body">
					<div class="row">
						<!-- Left Column: Payment Summary -->
						<div class="col-md-8">
							<h4 class="mb-4 text-secondary">Payment Summary</h4>
							<div class="mb-3">
								<p class="fw-bold">Amount: ${payment.amount}</p>
								<p class="fw-bold">Tax Amount: ${payment.taxAmount}</p>
								<p class="fw-bold">Delivery Charge: ${payment.pdc}</p>
								<p class="fw-bold">Service Charge: ${payment.psc}</p>
							</div>
							<hr>
							<div class="mb-3">
								<label class="form-label fw-bold">Total Amount:</label> <span
									class="h5 text-primary">${payment.totalAmount}</span>
							</div>
						</div>

						<!-- Right Column: Proceed to Payment -->
						<div class="col-md-4 text-center">
						<form  method="post" action="${cp}/user/payment/khalti">
						<div>
						<img src="${cp}/image/khalti.png" height="80px" class="mb-2">
						</div>
						<input type="hidden" name="total" value="${payment.totalAmount}">
							<input type="hidden" name="user_id" value="${user.id}">
							<button type="submit" class="btn btn-success">
								Proceed to Payment</button>
								</form>
							<div class="mt-3">
							
								<p class="text-muted">You will be redirected to the secure
									Khalti payment gateway.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>



</div>

<%@ include file="footer.jsp"%>

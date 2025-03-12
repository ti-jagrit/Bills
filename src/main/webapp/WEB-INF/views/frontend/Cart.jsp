<%@ include file="header.jsp"%>


<div class="container mt-5">
	<c:if test="${not empty success}">
		<div class="alert alert-success fw-bold" role="alert">
			${success}</div>
	</c:if>
	<c:if test="${not empty error}">
		<div class="alert alert-danger fw-bold" role="alert">${error}</div>
	</c:if>
<c:if test="${not empty cart_list}">
	<h2 class="text-center mb-4">Your Cart</h2>
	
	<table class="table table-bordered table-striped text-center"
		id="cart-table">
		<thead class="thead-dark">
			<tr>
				<th>S.N.</th>
				<th>Product</th>
				<th>Added Date</th>
				<th>Quantity</th>
				<th>Price</th>
				<th>Sub Total</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="sn" value="${0}" />
			<c:forEach items="${cart_list}" var="cart">
				<tr class="cart-item" data-price="${cart.product.sp}"
					data-qty="${cart.qty}">
					<td>${sn = sn + 1}</td>
					<td>${cart.product.name}<br> <c:if
							test="${cart.qty > cart.product.qty}">
							<p class="text-danger small">Product Out of Stock</p>
						</c:if>
					</td>

					<td>${cart.addedDate}</td>
					<td>
						<form method="post" action="${cp}/user/cart/update/${cart.id}">
							<input type="hidden" name="product" value="${cart.product.id}">
							<input type="hidden" name="user" value="${cart.user.id}">
							<input type="hidden" name="addedDate" value="${cart.addedDate}">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input type="number" name="qty"
								class="form-control qty" value="${cart.qty}" min="1">
					</td>
					<td>${cart.product.sp}</td>
					<td class="item-subtotal">${cart.product.sp * cart.qty}</td>
					<td><input type="submit" value="Update"
						class="btn btn-success btn-sm">
						</form></td>
					<td><a href="${cp}/user/cart/delete/${cart.id}"
						class="btn btn-danger btn-sm">Delete</a></td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2" class="text-right"><strong>Subtotal:</strong></td>
				<td colspan="4" id="subtotal-price">0</td>
			</tr>
			<tr>
				<td colspan="2" class="text-right"><strong>VAT (0):</strong></td>
				<td colspan="4" id="vat-price">0</td>
			</tr>
			<tr>
				<td colspan="2" class="text-right"><strong>Discount
						(0):</strong></td>
				<td colspan="4" id="discount-price">0</td>
			</tr>
			<tr>
				<td colspan="2" class="text-right"><strong>Total:</strong></td>
				<td colspan="4" id="total-price">0</td>
			</tr>
		</tfoot>
	</table>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<!-- eSewa Payment Option -->
			<div class="col-12 col-md-4 text-center mb-4">
			<!-- hidden from to proced payment -->
				<a href="${cp}/user/payment/esewa" class="d-block"> <img
					src="${cp}/image/esewa.png" alt="eSewa" class="img-fluid mb-2"
					style="max-height: 50px;">
					<p>Pay via eSewa</p>
				</a>
			</div>

			<!-- Khalti Payment Option -->
			<div class="col-12 col-md-4 text-center mb-4">
				<a href="${cp}/user/payment/khalti" class="d-block"> <img src="${cp}/image/khalti.png"
					alt="Khalti" class="img-fluid mb-2" style="max-height: 50px;">
					<p>Pay via Khalti</p>
				</a>
			</div>

			<!-- Cash on Delivery Option -->
			<div class="col-12 col-md-4 text-center mb-4">
				<a href="${cp}/user/payment/success/cod" class="d-block"> <i
					class="fas fa-money-bill-wave mb-2" style="font-size: 50px;"></i>
					<p>Cash on Delivery</p>
				</a>
			</div>
		</div>
		</div>
		</c:if>
		<c:if test="${empty cart_list}">
		<div>
		<p class="h3 text-danger"> Your Cart is Empty </p>
		
		</div>
		</c:if>
	</div>

	<!-- FontAwesome CDN for Cash on Delivery Icon -->


	<link
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
		rel="stylesheet">
	<%@ include file="footer.jsp"%>

	<script>
    // Function to calculate the subtotals, VAT, discount, and total price dynamically
    function calculateCartPrices() {
        let subtotal = 0;
        let vat = 0;
        let discount = 0;

        // Loop through each cart item row and calculate the subtotal
        document.querySelectorAll('.cart-item').forEach(item => {
            const price = parseFloat(item.getAttribute('data-price'));
            const qty = parseInt(item.getAttribute('data-qty'));
            const itemSubtotal = price * qty;
            subtotal += itemSubtotal;
        });

        // VAT is 15% of subtotal
        vat = 0;

        // Discount is 10% of subtotal
        discount =0;

        // Calculate the final total price after applying VAT and discount
        const total = subtotal + vat - discount;

        // Update the displayed values
        document.getElementById('subtotal-price').textContent = subtotal.toFixed(2);
        document.getElementById('vat-price').textContent = vat.toFixed(2);
        document.getElementById('discount-price').textContent = discount.toFixed(2);
        document.getElementById('total-price').textContent = total.toFixed(2);
    }

    // Call the function to calculate the prices when the page loads
    window.onload = calculateCartPrices;

    // Recalculate the prices when the quantity changes
    document.querySelectorAll('.qty').forEach(input => {
        input.addEventListener('input', function() {
            // Update the quantity attribute of the cart item
            const row = this.closest('tr');
            row.setAttribute('data-qty', this.value);
            // Recalculate prices after updating
            calculateCartPrices();
        });
    });
</script>
<%@ include file="header.jsp"%>
<style>
/* Styling for order container */
.order-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
}

/* Individual order card */
.order-card {
	width: 300px;
	border-radius: 8px;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	padding: 15px;
	background: #fff;
	text-align: center;
	transition: transform 0.2s ease-in-out;
	border: 1px solid #f1f1f1;
	margin-bottom: 20px;
}

.order-card:hover {
	transform: scale(1.05);
}

.order-card img {
	width: 100px;
	border-radius: 8px;
	margin-bottom: 10px;
}

.order-card .status {
	font-weight: bold;
	padding: 5px;
	border-radius: 4px;
}

/* Status Colors */
.status-pending {
	background: orange;
	color: white;
}

.status-accepted {
	background: green;
	color: white;
}

.status-rejected {
	background: red;
	color: white;
}

/* Filter Buttons */
.filter-buttons {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-bottom: 20px;
}

.filter-buttons button {
	padding: 8px 16px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
	transition: 0.3s;
	font-size: 16px;
}

.filter-buttons .active {
	background: #007bff;
	color: white;
}

.filter-buttons button:hover {
	opacity: 0.8;
}

/* Status Text and Order Details Styling */
.order-card h5 {
	font-size: 1.2rem;
	color: #333;
}

.order-card p {
	font-size: 1rem;
	color: #555;
}

.order-card .btn {
	background-color: #28a745;
	color: white;
	border-radius: 4px;
	padding: 5px 10px;
	margin-top: 10px;
	transition: 0.3s;
}

.order-card .btn:hover {
	background-color: #218838;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.order-container {
		flex-direction: column;
		align-items: center;
	}
	.filter-buttons {
		flex-direction: column;
	}
	.order-card {
		width: 90%;
	}
}

@media ( max-width : 480px) {
	.order-card {
		width: 100%;
	}
}
</style>

<body>
	<div class="container mt-5">
		<h2 class="text-center mb-4">Order Page</h2>

		<!-- Filter Buttons -->
		<div class="filter-buttons mb-4">
			<button class="active btn btn-primary" onclick="filterOrders('all')">All</button>
			<button class="btn btn-warning" onclick="filterOrders('PENDING')">Pending</button>
			<button class="btn btn-success" onclick="filterOrders('Confrom')">Accepted</button>
			<button class="btn btn-danger" onclick="filterOrders('Rejected')">Rejected</button>
		</div>

		<!-- Order Cards Container -->
		<div class="order-container">
			<c:forEach items="${order_list}" var="order">
					<a href="${cp}/order/details/${order.id}">
					<div class="order-card" data-status="${order.status}">
					
						<p class="status status-${order.status.toLowerCase()}">${order.status}</p>
						<p>
							<strong>Total Amount:</strong> Rs.${order.totalAmount}
						</p>
						<p>
							<strong>Discount:</strong> Rs.${order.discount}
						</p>
						<p>
							<strong>Order Date:</strong> ${order.orderDate}
						</p>
						<p>
							<strong>Delivery Date:</strong> ${order.deliveryDate}
						</p>
						<p>
							<strong>Payment:</strong> ${order.paymentMethod}
						</p>


					</div>
					</a>
			</c:forEach>
		</div>
	</div>

	<!-- JavaScript for Filtering -->
	<script>
        function filterOrders(status) {
            // Remove 'active' class from all buttons
            document.querySelectorAll('.filter-buttons button').forEach(btn => {
                btn.classList.remove('active');
            });

            // Highlight the active button
            event.target.classList.add('active');

            // Filter order cards based on status
            document.querySelectorAll('.order-card').forEach(card => {
                if (status === 'all' || card.dataset.status === status) {
                    card.style.display = "block";
                } else {
                    card.style.display = "none";
                }
            });
        }
    </script>

	<%@ include file="footer.jsp"%>
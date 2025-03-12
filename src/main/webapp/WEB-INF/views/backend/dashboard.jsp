
<%@ include file="../topbar.jsp"%>

<style>
.card {
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	transition: transform 0.3s;
}

.card:hover {
	transform: scale(1.05);
}

.dashboard-container {
	margin-top: 50px;
}

.dashboard-title {
	text-align: center;
	margin-bottom: 30px;
}

.chart-container {
	margin-top: 30px;
	padding: 20px;
	border-radius: 10px;
	background-color: #f8f9fa;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.icon {
	font-size: 2rem;
	margin-bottom: 10px;
}
</style>

<div class="container dashboard-container">
	<h1 class="dashboard-title">Admin Dashboard</h1>

	<div class="row text-center">
		<div class="col-md-4 mb-4">
			<div class="card p-3 bg-primary text-white">
				<div class="card-body">
					<i class="icon bi bi-tags"></i>
					<h5 class="card-title">Categories</h5>
					<h2>
						<c:out value="${categoryCount}" />
					</h2>
					<a href="${cp}/admin/category/show" class="btn btn-light">View
						Categories</a>
				</div>
			</div>
		</div>
		<div class="col-md-4 mb-4">
			<div class="card p-3 bg-success text-white">
				<div class="card-body">
					<i class="icon bi bi-box"></i>
					<h5 class="card-title">Products</h5>
					<h2>
						<c:out value="${productCount}" />
					</h2>
					<a href="${cp}/admin/product/list" class="btn btn-light">View
						Products</a>
				</div>
			</div>
		</div>
		<div class="col-md-4 mb-4">
			<div class="card p-3 bg-warning text-dark">
				<div class="card-body">
					<i class="icon bi bi-people"></i>
					<h5 class="card-title">Users</h5>
					<h2>
						<c:out value="${userCount}" />
					</h2>
					<a href="${cp}/admin/user/list" class="btn btn-dark">View Users</a>
				</div>
			</div>
		</div>
		<div class="col-md-4 mb-4">
			<div class="card p-3 bg-danger text-white">
				<div class="card-body">
					<i class="icon bi bi-shield-lock"></i>
					<h5 class="card-title">Admins</h5>
					<h2>
						<c:out value="${adminCount}" />
					</h2>
					<a href="${cp}/admin/add" class="btn btn-light">View Admins</a>
				</div>
			</div>
		</div>
		<div class="col-md-4 mb-4">
			<div class="card p-3 bg-info text-white">
				<div class="card-body">
					<i class="icon bi bi-cart"></i>
					<h5 class="card-title">Orders</h5>
					<h2>
						<c:out value="${orderCount}" />
					</h2>
					<a href="${cp}/admin/order/list" class="btn btn-light">View Orders</a>
				</div>
			</div>
		</div>
	</div>

	<div class="chart-container">
		<h3 class="text-center">Activity Overview</h3>
		<canvas id="dashboardChart" style="max-width: 600px; margin: auto;"></canvas>
	</div>
</div>

<script>
        const ctx = document.getElementById('dashboardChart').getContext('2d');
        const dashboardChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Categories', 'Products', 'Users', 'Admins', 'Orders'],
                datasets: [{
                    label: 'Count',
                    data: [
                        ${categoryCount}, 
                        ${productCount}, 
                        ${userCount}, 
                        ${adminCount}, 
                        ${orderCount}
                    ],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.6)',
                        'rgba(75, 192, 192, 0.6)',
                        'rgba(255, 206, 86, 0.6)',
                        'rgba(255, 99, 132, 0.6)',
                        'rgba(54, 162, 235, 0.6)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
<%@ include file="../footer.jsp"%>




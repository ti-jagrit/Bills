
<%@ include file="../topbar.jsp"%>
<c:if test="${not empty success}">
	<div class="alert alert-success fw-bold" role="alert">${success}
	</div>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-danger fw-bold" role="alert">${error}</div>
</c:if>
<div class="text-center bg-primary text-white py-2">
	<h1 class="h4 mb-0">Bills</h1>
</div>
<div>
<a href="${cp}/admin/bill/create" class="btn btn-info"> <i class="fa fa-plus"></i> Create Bill </a>
</div>
<div class="card-body">
	<table class="table table-responsive table-striped">
		<thead>
			<tr>
				<th>Bill No:</th>
				<th>Customer</th>
				<th>Created Date</th>
				<th>Total AMount</th>
				<th>Payment Method</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${bill_list}" var="bill">
				<tr>
					<td>${bill.billNumber}</td>
					<td>${bill.user.name}</td>
					<td>${bill.createdDate}</td>
					<td>Rs.${bill.total}</td>
					<td>${bill.paymentMehtod}</td>
					<td><a href="/admin/bill/billdetail/${bill.id}" class="btn btn-info"> <i class="fa fa-list"></i> View Details</a>
					<!--<a href="/admin/bill/printbill/${bill.id}" class="btn btn-success" target="_blank"> <i class="fa fa-print"></i> Print Bill</a>-->
					<a href="/admin/bill/jasper/${bill.id}" class="btn btn-success" target="_blank"> <i class="fa fa-print"></i> Print Bill </a>
					 </td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="../footer.jsp"%>
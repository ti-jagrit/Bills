<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<%@ include file="../topbar.jsp"%>




<div class="card-body">
	<div class="container mt-5">
		<c:if test="${not empty success}">
			<div class="alert alert-success fw-bold" role="alert">
				${success}</div>
		</c:if>
		<c:if test="${not empty error}">
			<div class="alert alert-danger fw-bold" role="alert">${error}</div>
		</c:if>



	</div>
	<div class="container mb-2">
		<a href="${cp}/admin/order/list" class="btn btn-success"> Orders </a>
		<a href="${cp}/admin/order/neworder" class="btn btn-warning">New
			Orders </a> <a href="${cp}/admin/order/rejectedlist"
			class="btn btn-danger"> Rejected Orders </a>
	</div>
	<c:set var="title" value="" />
	<c:set var="st" value="" />
	<c:if test="${status=='rejected'}">
		<c:set var="st" value="Rejected" />
		<c:set var="title" value="Rejected Orders" />
	</c:if>
	<c:if test="${status=='pending'}">
		<c:set var="st" value="PENDING" />
		<c:set var="title" value="Pending Orders" />
	</c:if>
	<c:if test="${status=='conform'}">
		<c:set var="st" value="Confrom" />
		<c:set var="title" value="Conformed Orders" />
	</c:if>

	<div class="text-center bg-primary text-white py-2">

		<h1 class="h4 mb-0">${title}</h1>
	</div>

	<div class="table-responsive">
		<table class="table">

			<thead>
				<tr>
					<th>ID</th>
					<th>Ordered_by</th>
					<th>Payment Method</th>
					<c:if test="${st!='PENDING'}">
						<th>Status</th>
					</c:if>
					<th>Delivery Date</th>

					<th>Total Amount</th>
					<th>Ordered Products</th>
					<c:if test="${st=='PENDING'}">
						<th>Conform</th>
						<th>Delete</th>
					</c:if>
					<c:if test="${st=='Confrom'}">
						<th>Print Label</th>
					</c:if>

				</tr>
			</thead>
			<c:set var="sn" value="${0}" />
			<c:forEach items="${order_list}" var="order">

				<c:if test="${order.status== st}">
					<tr>

						<!-- 	<td>${sn=sn+1}</td>  -->
						<td>${order.id}</td>
						<td>${order.user.name}</td>
						<td>${order.paymentMethod}</td>
						<c:if test="${st!='PENDING'}">
							<td>${order.status}</td>
						</c:if>
						<td>${order.deliveryDate}</td>
						<td>${order.totalAmount}</td>
						<td><ul>
								<c:forEach items="${order.orderedProducts}" var="op">

									<li>
										<p>${op.product.name}Qty:${op.qty}</p>
									</li>


								</c:forEach>
							</ul></td>

						<c:if test="${st=='Confrom'}">
							<td><a href="${cp}/admin/order/print-label/${order.id}" target="_blank"
								class="btn btn-warning text-white">Label </a></td>
						</c:if>

						<c:if test="${st=='PENDING'}">
							<td><a href="${cp}/admin/order/confrom/${order.id}"
								class="btn btn-info btn-sm"> Confrom Order </a></td>
							<td>
								<button type="button" class="btn btn-danger btn-sm	"
									data-bs-toggle="modal" data-bs-target="#deleteModal"
									data-id="${order.id}">Reject Order</button>
							</td>
						</c:if>

					</tr>
				</c:if>
			</c:forEach>


		</table>
	</div>



</div>

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Reject Order</h5>
				<button type="button" class="close" data-bs-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="deleteForm" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}">
					<p>Are you sure you want to Reject this Order?</p>
					<div class="form-group d-flex justify-content-end">
						<button type="button" class="btn btn-secondary btn-sm  m-1"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-danger btn-sm m-1">Reject
							Order</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- JavaScript to handle modal action URL and debugging -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	$(document).ready(
			function() {
				$('#deleteModal').on(
						'show.bs.modal',
						function(event) {
							var button = $(event.relatedTarget);
							var id = button.data('id');
							var modal = $(this);

							modal.find('#deleteForm').attr('action',
									'${cp}/admin/order/reject/' + id);
						});

			});
</script>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>



<%@ include file="../footer.jsp"%>



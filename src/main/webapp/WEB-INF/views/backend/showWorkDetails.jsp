<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<%@ include file="../topbar.jsp"%>

<div class="container my-4">
	<c:if test="${not empty success}">
		<div class="alert alert-success fw-bold" role="alert">${success}</div>
	</c:if>
	<c:if test="${not empty error}">
		<div class="alert alert-danger fw-bold" role="alert">${error}</div>
	</c:if>



	<div class="card mb-3 shadow">
		<div
			class="card-header text-dark d-flex justify-content-between align-items-center border-bottom">
			<h3 class="mb-0 text-primary">Work Details</h3>
			<a href="${cp}/admin/work/add" class="btn btn-success"> <i
				class="fa fa-plus"></i> Add Work
			</a>
		</div>
		<div class="text-center text-dark mt-3 p-1">
			<h2>${work.name}</h2>
		</div>
		<div class="card-body">
			<c:if test="${work.status}==null">
				<div class="row mb-4">
					<div class="col-md-4">

						<p>
							<strong>Work Status:</strong> ${work.status}
						</p>
					</div>
					<div class="col-md-4">
						<p>
							<strong>Remarks:</strong> ${work.remark}
						</p>
					</div>
					<div class="col-md-4">
					<p>
						<strong>Ready Date:</strong> ${work.readyDate}
					</p>
				</div>
				</div>

			</c:if>

			<!-- Short Items in Multiple Columns -->
			<div class="row mb-4">
				<div class="col-md-4">
					<p>
						<strong>Order Date:</strong> ${work.orderDate}
					</p>
				</div>
				
				<div class="col-md-4">
					<p>
						<strong>Work to be Finished Date:</strong> ${work.deliverDate}
					</p>
				</div>
					<div class="col-md-4">
					<p>
						<strong> Created By:</strong> ${work.updatedBy.name}
					</p>
				</div>
			</div>

			<div class="row mb-4">
				<div class="col-md-4">
					<p>
						<strong>Quantity:</strong> ${work.qty}
					</p>
				</div>
				<div class="col-md-4">
					<p>
						<strong>Price:</strong> ${work.price}
					</p>
				</div>
				<div class="col-md-4">
					<p>
						<strong>Total Amount:</strong> ${work.total}
					</p>
				</div>
			</div>

			<div class="row mb-4">
				<div class="col-md-4">
					<p>
						<strong>Paid Amount:</strong> ${work.payment}
					</p>
				</div>
				<div class="col-md-4">
					<p>
						<strong>Remaining Amount:</strong> ${work.total - work.payment}
					</p>
				</div>
				<p>
					<strong>Details To:</strong> ${work.detail}
				</p>
			</div>
			<hr>

			<div class="row mb-4">
				<div class="col-md-6">
					<p>
						<strong>Assigned To:</strong> ${work.assignTo.name}
					</p>
				</div>
				<div class="col-md-6">
					<p>
						<strong>Deadline:</strong> ${work.deadline}
					</p>
				</div>
			</div>
			<hr>

			<!-- Long Items in Single Column -->


			<!-- Customer Info -->
			<hr>
			<p class="h4 text-center">Customer Information</p>
			<hr>
			<div class="row align-items-center mb-4">
				<div class="col-md-3 text-center">
					<img src="${cp}/${work.customer.photo}" alt="Customer Photo"
						class="img-fluid rounded-circle shadow-sm"
						style="max-width: 100px; height: auto; border: 2px solid #ccc;">
				</div>
				<div class="col-md-9">
					<p>
						<strong>Name:</strong> <a
							href="${cp}/admin/work/customer/${work.customer.id}"
							class="text-decoration-none">${work.customer.name}</a>
					</p>
					<p>
						<strong>Email:</strong> ${work.customer.email}
					</p>
					<p>
						<strong>Phone:</strong> ${work.customer.phone}
					</p>
				</div>
			</div>

			<div class="card-footer d-flex justify-content-end">
				<a href="${cp}/admin/work/edit/${work.id}"
					class="btn btn-warning me-2"> <i class="fa fa-edit"></i>
					Edit
				</a>
				<button class="btn btn-danger" data-id="${work.id}"
					data-bs-toggle="modal" data-bs-target="#deleteModal">
					<i class="fa fa-trash"></i> Delete
				</button>
			</div>
		</div>

	</div>

	<!-- Delete Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1"
		aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>Are you sure you want to delete this work?</p>
				</div>
				<div class="modal-footer">
					<form id="deleteForm" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancel</button>
						<button type="submit" class="btn btn-danger">Delete</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
	$(document).ready(function() {
		$('#deleteModal').on('show.bs.modal', function(event) {
			const button = $(event.relatedTarget);
			const id = button.data('id');
			$('#deleteForm').attr('action', '${cp}/admin/work/delete/' + id);
		});
	});
</script>


	<%@ include file="../footer.jsp"%>
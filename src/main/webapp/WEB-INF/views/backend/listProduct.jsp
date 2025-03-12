<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<%@ include file="../topbar.jsp"%>

<c:if test="${not empty success}">
						<div class="alert alert-success fw-bold" role="alert">
							${success}</div>
					</c:if>
					<c:if test="${not empty error}">
						<div class="alert alert-danger fw-bold" role="alert">
							${error}</div>
					</c:if>
<div class="text-center bg-primary text-white py-2">

	<h1 class="h4 mb-0">Product List</h1>
</div>
<a href="${cp}/admin/product/add" class="btn btn-success m-2"> <i class="fa fa-plus"> </i> Add Product</a>
<a href="${cp}/admin/product/print-report" target="_blank" class="btn btn-warning m-2"> <i class="fa fa-print"> </i>  Stock Report</a>

<div class="card-body">
	<div class="table-responsive">
		<table class="table">

			<thead>
				<tr>
					<th>ID</th>
					<th>Image</th>
					<th>Name</th>
					<th>Category</th>
					<th>Selling price</th>
					<th>Buying Price</th>
					<th>Quantity</th>
					<th>Slug</th>
					<th>Description</th>
					<th>Added Date</th>
					<th>Update</th>
					<th>Delete</th>
				</tr>
			</thead>
			<c:set var="sn" value="${0}" />
			<c:forEach items="${products_list}" var="product">
				<tr>

				<!-- 	<td>${sn=sn+1}</td>  -->
					<td>${product.id}</td>
					<td><a href="${cp}/${product.image}" target="_blank"><img
							src="${cp}/${product.image}" height="40px"> </a></td>
					<td>${product.name}</td>
					<td>${product.category.name}</td>
					<td>${product.sp}</td>
					<td>${product.cp}</td>
					<td>${product.qty}</td>
					<td>${product.slug}</td>
					<td>${product.description}</td>
					<td>${product.addedDate}</td>
					<td><a href="${cp}/admin/product/edit/${product.id}"
						class="btn btn-info btn-sm ml-1"> Update <i class="fa fa-edit"></i>
					</a></td>
					<td>
						<button type="button" class="btn btn-danger btn-sm"
							data-bs-toggle="modal" data-bs-target="#deleteModal"
							data-id="${product.id}">
							Delete <i class="fas fa-trash"></i>
						</button>
					</td>

				</tr>
			</c:forEach>


		</table>
	</div>



</div>

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Confirm Delete
					User</h5>
				<button type="button" class="close" data-bs-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="deleteForm" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}">
					<p>Are you sure you want to delete this Product?</p>
					<div class="form-group d-flex justify-content-end">
						<button type="button" class="btn btn-secondary m-1"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-danger m-1">Confirm
							Delete</button>
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
									'${cp}/admin/product/delete/' + id);
						});

			});
</script>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>



<%@ include file="../footer.jsp"%>



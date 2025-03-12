<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<%@ include file="../topbar.jsp"%>
<c:if test="${not empty success}">
	<div class="alert alert-success fw-bold" role="alert">${success}
	</div>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-danger fw-bold" role="alert">${error}</div>
</c:if>
<div class="text-center bg-primary text-white py-2">
	<h1 class="h4 mb-0">User List</h1>
</div>
<a href="${cp}/admin/user/add" class="btn btn-info m-2"> <i class="fa fa-plus"></i> Add User</a>
<div class="card-body">
	<table class="table table-responsive table-striped">
		<thead>
			<tr>
				<th>Sn</th>
				<th> Photo </th>
				<th>Name</th>
				<th>Email</th>
				<th>Phone</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="i" value="${0}"/>
				<c:forEach items="${user_list}" var="user">
			<c:if test="${user.userRole.role != 'ROLE_ADMIN'}">
				<tr>
					<td>${i=i+1}</td>
					<td> <img src="${cp}/${user.photo}" height="100px" style="max-width:100px; overflow:hidden;"> </td>
					<td>${user.name}</td>
					<td>${user.email}</td>
					<td>${user.phone	}</td>
					<td><a class="btn btn-warning btn-sm"
						href="${cp}/admin/user/edit/${user.id}"><i class="fas fa-edit"></i></a></td>
					<td>
						<button type="button" class="btn btn-danger btn-sm"
							data-bs-toggle="modal" data-bs-target="#deleteModal"
							data-id="${user.id}">
							<i class="fas fa-trash"></i>
						</button>
					</td>
				</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>


<!-- Delete Confirmation Modal -->
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
					<p>Are you sure you want to delete this User?</p>
					<div class="form-group d-flex justify-content-end">
						<button type="button" class="btn btn-secondary btn-sm m-1"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-danger btn-sm m-1">Confirm
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
									'${cp}/admin/user/delete/' + id);
						});

				

			});
</script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">



<%@ include file="../footer.jsp"%>



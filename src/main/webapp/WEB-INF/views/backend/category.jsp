<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<%@ include file="../topbar.jsp"%>
<div class="container my-2">

	<c:if test="${not empty success}">
		<div class="alert alert-success fw-bold" role="alert">
			${success}</div>
	</c:if>
	<c:if test="${not empty error}">
		<div class="alert alert-danger fw-bold" role="alert">${error}</div>
	</c:if>
	<!-- Card Wrapper for Add Category Form and Category List -->
	<div class="card shadow-lg">
		<c:choose>
			<c:when test="${edit ne true}">
				<div class="card-body">
					<!-- Add Category Form -->
					<div class="text-center py-2">
						<h1 class="h3 mb-0">Add Category</h1>
					</div>
					<form class="user" action="${cp}/admin/category/add" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<div class="form-group">
							<input type="text" class="form-control" name="name"
								placeholder="Enter Category Name" requried>
						</div>

						<div class="form-group">
							<textarea name="description" id="inputDescription"
								class="form-control" placeholder="Enter the description"
								rows="5" required></textarea>
						</div>

						<div class="form-group">
							<label for="inputParent">Category Parent:</label> <select
								name="parent" id="inputParent" class="form-control" required>
								<option value="0">--Main Category--</option>
								<c:forEach items="${cat_list}" var="cat">
									<option value="${cat.id}">${cat.name}</option>
								</c:forEach>
							</select>
						</div>

						<div class="form-group d-flex justify-content-between">
							<button type="submit" class="btn btn-primary">
								<i class="fa fa-plus"></i> Add
							</button>
							<input type="reset" class="btn btn-warning ms-2"
								value="Reset Form">

						</div>
					</form>
				</div>
			</c:when>


			<c:otherwise>
				<div class="card-body">
					<div class="text-center py-2">
						<h1 class="h3 mb-0">Edit Category</h1>
					</div>
					<form class="user" action="${cp}/admin/category/edit" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<div class="form-group">
							<label for="inputId">Category Id:</label> <input type="text"
								class="form-control" name="id" value="${edit_cat.id}" readonly />
						</div>

						<div class="form-group">
							<label for="inputName">Category Name:</label> <input type="text"
								class="form-control" name="name" value="${edit_cat.name}"
								required>
						</div>

						<div class="form-group">
							<label for="inputDescription">Category Description:</label>
							<textarea name="description" id="inputDescription"
								class="form-control" rows="5" required>${edit_cat.description}</textarea>
						</div>

						<div class="form-group">
							<label for="inputParent">Category Parent:</label> <select
								name="parent" id="inputParent" class="form-control" required>
								<option value="0">--Main Category--</option>
								<c:forEach items="${cat_list}" var="cat">
									<option value="${cat.id}"
										${edit_cat.parent eq cat.id ? "selected" : ""}>${cat.name}</option>
								</c:forEach>
							</select>
						</div>

						<div class="form-group d-flex justify-content-between">
							<input type="submit" class="btn btn-success ml-3"
								value="Update Category"> <input type="reset"
								class="btn btn-warning ml-2" value="Reset Form">
						</div>
					</form>
				</div>
			</c:otherwise>
		</c:choose>
		<hr>

		<!-- Category List Table -->
		<div class="text-center py-2">
			<h1 class="h3 mb-0">Category List</h1>
		</div>

		<div class="card-body">
			<div class="table-responsive">
				<table
					class="table table-striped table-bordered text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>SN</th>
							<th>Category Name</th>
							<th>Description</th>
							<th>Parent Category</th>
							<th>Edit</th>
							<th>Delete</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${cat_list}" var="cat">
							<tr>
								<td>${cat.id}</td>
								<td>${cat.name}</td>
								<td>${cat.description}</td>
								<td><c:set var="parent_name" value="Main Category" /> <c:forEach
										items="${cat_list}" var="category">
										<c:if test="${cat.parent eq category.id}">
											<c:set var="parent_name" value="${category.name}" />
										</c:if>
									</c:forEach> ${parent_name}</td>
								<td><a href="${cp}/admin/category/edit/${cat.id}"
									class="btn btn-outline-primary btn-sm"> <i
										class="fas fa-pen fa-lg"></i>
								</a></td>
								<td>
									<button type="button" class="btn btn-outline-danger btn-sm"
										data-bs-toggle="modal" data-bs-target="#deleteModal"
										data-id="${cat.id}">
										<i class="fas fa-trash-alt fa-lg"></i>
									</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Confirm Delete
					Category</h5>
				<button type="button" class="close" data-bs-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="deleteForm" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}">
					<p>Are you sure you want to delete this category?</p>
					<div class="form-group d-flex justify-content-end">
						<button type="button" class="btn btn-secondary btn-sm  m-1"
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
							var button = $(event.relatedTarget); // Button that triggered the modal
							var id = button.data('id'); // Extract info from data-* attributes
							var modal = $(this);

							modal.find('#deleteForm').attr('action',
									'${cp}/admin/category/delete/' + id);
						});

				// Ensure form action URL is correctly set for confirmation

			});
</script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<%@ include file="../footer.jsp"%>

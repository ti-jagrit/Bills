<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<%@ include file="../topbar.jsp"%>


<div class="container my-4">
	<!-- Card Wrapper for Add Category Form and Category List -->
<c:choose>
    <c:when test="${edit ne true}">
        <div class="card shadow-lg">
            <div class="card-body">
                <div class="text-center py-2">
                    <h1 class="h4 mb-0">Add Admin</h1>
                </div>
                <form class="user" action="${cp}/admin/add" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="form-group">
                        <label for="name">Admin Name:</label>
                        <input type="text" class="form-control" name="name" placeholder="Enter Admin Name" required>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-6 mb-3 mb-sm-0">
                            <label for="email">Email:</label>
                            <input type="text" class="form-control" name="email" placeholder="Enter Email" required>
                        </div>
                        <div class="col-sm-6">
                            <label for="phone">Phone:</label>
                            <input type="number" class="form-control" name="phone" placeholder="Enter Phone Number" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-6 mb-3 mb-sm-0">
                            <label for="address">Address:</label>
                            <input type="text" class="form-control" name="address" placeholder="Enter Address" required>
                        </div>
                        <div class="col-sm-6">
                            <label for="photo">Photo:</label>
                            <input type="file" class="form-control" name="imageFile" onchange="previewImage(event, 'addImagePreview')">
                            <img id="addImagePreview" src="" alt="Image Preview" style="display: none; margin-top: 10px; max-width: 100px; border: 1px solid #ccc; padding: 5px;">
                        </div>
                    </div>

                    <div class="form-group d-flex justify-content-between">
                        <input type="submit" class="btn btn-success ml-3" value="Add Admin">
                        <input type="reset" class="btn btn-warning ml-2" value="Reset Form">
                    </div>
                </form>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="card shadow-lg">
            <div class="card-body">
                <div class="text-center py-2">
                    <h1 class="h4 mb-0">Update Admin</h1>
                </div>
                <form class="user" action="${cp}/admin/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="form-group">
                        <label for="id">User ID:</label>
                        <input type="text" class="form-control" name="id" value="${us.id}" readonly="true" required>
                    </div>

                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" name="name" value="${us.name}" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="text" class="form-control" name="email" value="${us.email}" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone:</label>
                        <input type="number" class="form-control" name="phone" value="${us.phone}" required>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-6 mb-3 mb-sm-0">
                            <label for="address">Address:</label>
                            <input type="text" class="form-control" name="address" value="${us.address}" required>
                        </div>
                        <div class="col-sm-6">
                            <label for="photo">Photo:</label>
                            <input type="file" class="form-control" name="imageFile" onchange="previewImage(event, 'updateImagePreview')">
                            <input type="hidden" value="${us.photo}" name="old">
                            <img id="updateImagePreview" src="${cp}/${us.photo}" alt="Image Preview" style="display: block; margin-top: 10px; max-width: 100px; border: 1px solid #ccc; padding: 5px;">
                        </div>
                    </div>

                    <div class="form-group d-flex justify-content-between">
                        <input type="submit" class="btn btn-success ml-3" value="Update User">
                        <input type="reset" class="btn btn-warning ml-2" value="Reset Form">
                    </div>
                </form>
            </div>
        </div>
    </c:otherwise>
</c:choose>

</div>
<div class="text-center bg-primary text-white py-2">
	<h1 class="h4 mb-0">Admins List</h1>
</div>

<div class="card-body">
	<table class="table table-responsive table-striped">
		<thead>
			<tr>
				<th> </th>
				
				<th>Name</th>
				<th>E-mail</th>
				<th>Phone</th>
				<th>Address</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${admins}" var="admin">
				<c:if test="${admin.userRole.role=='ROLE_ADMIN'}">
					<tr>
						<td><img src="${cp}/${admin.photo}" height="100px"> </td>
						<td>${admin.name}</td>
						<td>${admin.email}</td>
						<td>${admin.phone}</td>
						<td>${admin.address}</td>
						<td><a class="btn btn-warning btn-sm"
							href="${cp}/admin/edit/${admin.id}"><i
								class="fas fa-edit"></i></a></td>
						<td>
							<button type="button" class="btn btn-danger btn-sm"
								data-bs-toggle="modal" data-bs-target="#deleteModal"
								data-id="${admin.id}">
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
					Admin </h5>
				<button type="button" class="close" data-bs-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="deleteForm" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}">
					<p>Are you sure you want to delete this Admin?</p>
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
									'${cp}/admin/delete/' + id);
						});

				// Ensure form action URL is correctly set for confirmation

			});
	function previewImage(event, previewId) {
	    const file = event.target.files[0];
	    const preview = document.getElementById(previewId);

	    if (file) {
	        const reader = new FileReader();
	        reader.onload = function(e) {
	            preview.src = e.target.result;
	            preview.style.display = 'block';
	        };
	        reader.readAsDataURL(file);
	    } else {
	        preview.src = "";
	        preview.style.display = 'none';
	    }
	}

</script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<%@ include file="../footer.jsp"%>
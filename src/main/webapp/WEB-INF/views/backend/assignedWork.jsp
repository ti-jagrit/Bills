<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<%@ include file="../topbar.jsp"%>

<c:if test="${not empty success}">
	<div class="alert alert-success fw-bold" role="alert">${success}</div>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-danger fw-bold" role="alert">${error}</div>
</c:if>
<div class="text-center bg-primary text-white py-2">

	<h1 class="h4 mb-0">Task List of ${user.name}</h1>
</div>

<div style="width:fit-content;">
<a href="${cp}/admin/work/create" class="btn btn-success m-2"> <i
	class="fa fa-plus"> </i> Create New Work
</a>
</div>

<div class="card-body">
	<div class="table-responsive">
		<table class="table">

			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Customer</th>
					<th>Deadline</th>
					<th>Update Status</th>
					<th>View Details</th>
				</tr>
			</thead>
			<c:forEach items="${assign_works}" var="work">
				<tr>
					<td>${work.id}</td>
					<td>${work.name}</td>
					<td><a href="${cp}/admin/work/customer/${work.customer.id}">
							${work.customer.name} </a></td>
					<td>${work.deadline} Days</td>

					<td>
						<button type="button" class="btn btn-info" data-bs-toggle="modal"
							data-bs-target="#assignModal" data-id="${work.id}">
							<i class="fas fa-edit"></i> Update Work Status 
						</button>
					</td>
					<td><a href="${cp}/admin/work/details/${work.id}"
						class="btn btn-warning text-white"> View Details</a></td>

				</tr>
			</c:forEach>



		</table>
	</div>


</div>

<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" 
    aria-labelledby="assignModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="assignModalLabel">Update Work Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="assignForm" action="${cp}/admin/work/status" method="post">
                    <!-- CSRF Token -->
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    
                    <!-- Hidden Field for Work ID -->
                    <input type="hidden" id="workId" class="form-control" name="workId" value="">

                    <!-- Admin Dropdown -->
                    <div class="form-group mb-3">
                        <label for="status">Assign To:</label>
                        <select name="status" id="status" class="form-select" required>
                            <option value="" selected disabled>-- Select to  Update Status--</option>
                                <option value="pending"> Pedning</option>
                                <option value="start"> Started</option>
                                <option value="half"> Half</option>
								<option value="final"> Final</option>
								<option value="completed"> completed</option>
                            
                        </select>
                    </div>

                    <!-- Deadline Input -->
                    <div class="form-group mb-3">
                        <label for="Remark">Remark: </label>
                        <textarea class="form-control" name="Remark">
                        p
                        </textarea>
                          
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-success">Assign User</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        const assignModal = document.getElementById('assignModal');
        assignModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; // Button that triggered the modal
            const workId = button.getAttribute('data-id'); // Extract work ID

            // Set the hidden field value
            const workIdField = document.getElementById('workId');
            workIdField.value = workId;
        });

        // Form validation
        const assignForm = document.getElementById('assignForm');
        assignForm.addEventListener('submit', function (event) {
            if (!assignForm.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            assignForm.classList.add('was-validated');
        }, false);
    });
</script>






<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>



<%@ include file="../footer.jsp"%>



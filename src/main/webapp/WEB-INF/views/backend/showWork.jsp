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

	<h1 class="h4 mb-0">Task List</h1>
</div>
<a href="${cp}/admin/work/create" class="btn btn-success m-2"> <i
	class="fa fa-plus"> </i> Create New Work
</a>

<div class="card-body">
	<div class="table-responsive">
		<table class="table">

			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Customer</th>
					<th>Delivery Date</th>
					<th>Assigned to</th>
					<th>Payment</th>
					<th>Assing work</th>
					<th>View Details</th>
				</tr>
			</thead>
			<c:forEach items="${work_List}" var="work">
				<tr>
					<td>${work.id}</td>
					<td>${work.name}</td>
					<td><a href="${cp}/admin/work/customer/${work.customer.id}">
							${work.customer.name} </a></td>
					<td>${work.deliverDate}</td>
					<td><c:if test="${work.assignTo!=null}">
			 ${work.assignTo.name} 
			 </c:if> <c:if test="${work.assignTo==null}">
							<span class="text-danger"> Not Assign </span>
						</c:if></td>


					<td>${work.total - work.payment}</td>
					<td>
						<button type="button" class="btn btn-info" data-bs-toggle="modal"
							data-bs-target="#assignModal" data-id="${work.id}">
							<i class="fas fa-user"></i> Assign Work
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
                <h5 class="modal-title" id="assignModalLabel">Assign Work</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="assignForm" action="${cp}/admin/work/assign" method="post">
                    <!-- CSRF Token -->
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    
                    <!-- Hidden Field for Work ID -->
                    <input type="hidden" id="workId" class="form-control" name="workId" value="">

                    <!-- Admin Dropdown -->
                    <div class="form-group mb-3">
                        <label for="assignTo">Assign To:</label>
                        <select name="assignTo" id="assignTo" class="form-select" required>
                            <option value="" selected disabled>-- Select Admin to Assign --</option>
                            <c:forEach items="${admins}" var="admin">
                                <option value="${admin.id}">${admin.name}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Please select an admin.</div>
                    </div>

                    <!-- Deadline Input -->
                    <div class="form-group mb-3">
                        <label for="deadline">Deadline: <span class="text-secondary">(in days)</span></label>
                        <input type="number" class="form-control" id="deadline" name="deadline"
                            placeholder="Enter Deadline in Days" min="1" required>
                        <div class="invalid-feedback">Please enter a valid deadline.</div>
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



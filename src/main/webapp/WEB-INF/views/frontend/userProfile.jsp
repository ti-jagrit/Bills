<%@ include file="header.jsp"%>
<c:if test="${not empty success}">
 <div class="alert alert-success fw-bold" role="alert">
                ${success}
            </div>
		</c:if>
		<c:if test="${not empty error}">
            <div class="alert alert-danger fw-bold" role="alert">
                ${error}
            </div>
        </c:if>
<div class="container-fluid mt-5">
	<div class="text-center">
		<img src="${cp}/${user.photo}" class="rounded mx-auto d-block"
			alt="${user.name} photo" height="150px">
		<h1>${user.name}</h1>
		<p class="h4">${user.email}</p>
	</div>

	<div class="container m-5 text-center">
	<button type="button" class="btn btn-danger float-start" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${user.id}">
                                    <i class="fa fa-trash"></i> Delete</button>
                                    
	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#passModal" data-id="${user.id}">
                                    <i class="fa fa-lock"></i> Change Password</button>
			
			 <a href="${cp}/user/editprofile/${user.id}"
			class="btn btn-warning float-end"><i class="fa fa-edit"></i> Edit
			Profile</a>
	</div>

</div>

<!-- for Password change model -->
<div class="modal fade" id="passModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Change Account Password</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="passchnage" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <label for="cp">Current Password:</label> <input type="password"
								class="form-control" name="cpass">
					<label for="cp">New Password:</label> <input type="password"
								class="form-control" name="npass">
                    <div class="form-group d-flex justify-content-end">
                        <button type="button" class="btn btn-secondary m-1" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-danger m-1">Change Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- for deletion confromation model -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Confirm Delete Account</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="deleteForm" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <p>Are you sure you want to delete Your Account?</p>
                    <div class="form-group d-flex justify-content-end">
                        <button type="button" class="btn btn-secondary m-1" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-danger m-1">Confirm Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- JavaScript to handle modal action URL and debugging -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script type="text/javascript">
    $(document).ready(function() {
        $('#passModal').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var id = button.data('id'); // Extract info from data-* attributes
            var modal = $(this);

            
            modal.find('#passchnage').attr('action', '${cp}/user/changepass/' + id);
        });

        // Ensure form action URL is correctly set for confirmation
      
    });
</script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#deleteModal').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var id = button.data('id'); // Extract info from data-* attributes
            var modal = $(this);

            
            modal.find('#deleteForm').attr('action', '${cp}/user/deleteprofile/' + id);
        });

        // Ensure form action URL is correctly set for confirmation
      
    });
</script>

<%@ include file="footer.jsp"%>
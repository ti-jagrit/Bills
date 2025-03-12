<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bills - User Login</title>
<link rel="icon" href="${cp}/${company.logo}" type="image/x-icon" />
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body class="bg-gradient-primary">
	<div class="container">
		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<div class="row">

					<div class="col-lg-7 mx-auto">
						<div class="p-5">
							<c:if test="${not empty success}">
								<div class="alert alert-success fw-bold" role="alert">
									${success}</div>
							</c:if>
							<c:if test="${not empty error}">
								<div class="alert alert-danger fw-bold" role="alert">
									${error}</div>
							</c:if>
							<div class="text-center d-flex flex-column align-items-center"
								style="gap: 10px;">
								<img src="${cp}/${company.logo}" class="img-fluid"
									style="max-height: 150px; width: auto;" alt="logo">
								<h1 class="h4 text-secondary mb-2">${company.name}</h1>
								<h2 class="h5 text-secondary mb-4">Login to Account!</h2>
							</div>
							<div class="text-center">
								<form class="user" action="${cp}/login" method="post">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />

									<div class="form-group">
										<input type="text" class="form-control form-control-user"
											name="email" placeholder="Email Address" required>
									</div>

									<div class="form-group">
										<input type="password" class="form-control form-control-user"
											name="password" placeholder="Password" required>
									</div>

									<button type="submit" class="btn btn-primary btn-user">Login</button>
								</form>
							</div>
							<hr>
							<div class="text-center">
							<div>
							<a href="/oauth2/authorization/google" class="btn btn-info btn-sm"> Login With Google</a>
							</div>
								<a class="small" href="${cp}/register">Create an
									account? Register!</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

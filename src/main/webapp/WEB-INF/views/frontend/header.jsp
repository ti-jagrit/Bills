<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bills a Ecommers</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<!-- Bootstrap Icons CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
.navbar-brand img {
	height: 40px;
	object-fit: contain;
}

.user-image {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	object-fit: cover;
}
</style>
</head>

<link rel="icon" href="${cp}/${company.logo}" type="image/x-cino" />
<body>
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg bg-light shadow-sm">
		<div class="container">
			<!-- Logo -->
			<a
				class="navbar-brand d-flex flex-column align-items-center text-center"
				href="${cp}/home" style="gap: 5px;"> <img
				src="${cp}/${company.logo}" alt="Logo" class="img-fluid"
				style="max-height: 80px; width: auto;">
				<h4 class="mb-0">
					<span class="text-secondary">${company.name.split(' ')[0]} ${company.name.split(' ')[1]}</span> 
				</h4>
			</a>

			<!-- Toggler for smaller screens -->
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Navigation Links -->
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav mx-auto">
					<li class="nav-item"><a class="nav-link" href="${cp}/home">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="${cp}/product">Product</a></li>
					<li class="nav-item"><a class="nav-link" href="${cp}/about">About</a></li>
				</ul>

				<!-- Cart and User -->
				<div class="d-flex align-items-center">
					<!-- Cart -->


					<!-- Conditionally display user dropdown or login button -->
					<c:if test="${not empty user}">
						<a href="${cp}/user/cart/show"
							class="btn btn-outline-primary me-3"> <i class="bi bi-cart"></i>
							Cart
						</a>
						<!-- User Image with Dropdown -->
						<div class="dropdown">
							<a href="#"
								class="d-flex align-items-center text-decoration-none"
								data-bs-toggle="dropdown" aria-expanded="false"> <img
								src="${cp}/${user.photo}" alt="User" height="50px"
								class="user-image">
							</a>
							<ul class="dropdown-menu dropdown-menu-end shadow">
								<li><a class="dropdown-item d-flex align-items-center"
									href="${cp}/user/userprofile"> <i class="bi bi-person me-2"></i>
										<span>${user.name}</span>
								</a></li>
								<li><a class="dropdown-item d-flex align-items-center"
									href="${cp}/user/orders"> <i class="bi bi-truck me-2"></i>
										<span> View Orders</span>
								</a></li>
								<li><a class="dropdown-item d-flex align-items-center"
									href="${cp}/user/userprofile"> <i class="bi bi-gear me-2"></i>
										<span>Settings</span>
								</a></li>
								<li><hr class="dropdown-divider"></li>
								<li><a class="dropdown-item d-flex align-items-center"
									href="${cp}/logout"> <i class="bi bi-box-arrow-right me-2"></i>
										<span>Logout</span>
								</a></li>
							</ul>
						</div>
					</c:if>
					<c:if test="${empty user}">
						<!-- Login Button -->
						<a href="${cp}/userlogin" class="btn btn-outline-primary">Login</a>
					</c:if>
				</div>
			</div>
		</div>
	</nav>
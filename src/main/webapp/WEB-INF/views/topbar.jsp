<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Bills - Admin-Dashboard</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="${cp}/${company.logo}" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.8/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>


<script>
	WebFont.load({
		google : {
			families : [ "Public Sans:300,400,500,600,700" ]
		},
		custom : {
			families : [ "Font Awesome 5 Solid", "Font Awesome 5 Regular",
					"Font Awesome 5 Brands", "simple-line-icons", ],
			urls : [ "assets/css/fonts.min.css" ],
		},
		active : function() {
			sessionStorage.fonts = true;
		},
	});
</script>


<!-- CSS Files -->
<link rel="stylesheet" href="${cp}/assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="${cp}/assets/css/plugins.min.css" />
<link rel="stylesheet" href="${cp}/assets/css/kaiadmin.min.css" />



<!-- CSS Just for demo purpose, don't include it in your project -->
<link rel="stylesheet" href="${cp}/assets/css/demo.css" />
</head>
<body>
	<div class="wrapper">
		<!-- Sidebar -->
		<div class="sidebar" data-background-color="dark">
			<div class="sidebar-logo">
				<!-- Logo Header -->
				<div class="logo-header text-center" data-background-color="dark"
					style="text-align: center; padding: 10px;">
					<a href="${cp}/admin"
						class="logo d-flex flex-column align-items-center"
						style="gap: 5px; text-decoration: none;"> <img
						src="${cp}/${company.logo}" alt="navbar brand"
						class="navbar-brand img-fluid"
						style="max-height: 50px; max-width: 100px;">
					</a>
					<div class="nav-toggle mt-3 d-flex justify-content-center"
						style="gap: 10px;">
						<button class="btn btn-toggle toggle-sidebar">
							<i class="gg-menu-right"></i>
						</button>
						<button class="btn btn-toggle sidenav-toggler">
							<i class="gg-menu-left"></i>
						</button>
					</div>
					<button class="topbar-toggler more mt-2">
						<i class="gg-more-vertical-alt"></i>
					</button>
				</div>
				<!-- End Logo Header -->
			</div>
			<div class="sidebar-wrapper scrollbar scrollbar-inner">
				<div class="sidebar-content">
					<ul class="nav nav-secondary">
						<li class="nav-item active"><a href="${cp}/admin"
							class="collapsed" aria-expanded="false"> <i
								class="fas fa-home"></i>
								<p>Dashboard</p>
						</a></li>


						<li class="nav-item"><a href="${cp}/admin/category/show">
								<i class="fas fa-layer-group"></i>
								<p>Category</p>
						</a></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#sidebarLayouts"> <i class="fas fa-th-list"></i>
								<p>Product</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="sidebarLayouts">
								<ul class="nav nav-collapse">
									<li><a href="/admin/product/add"> <span
											class="sub-item">Add Product</span>
									</a></li>
									<li><a href="/admin/product/list"> <span
											class="sub-item"> Manage Product</span>
									</a></li>
								</ul>
							</div></li>


						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#customer"> <i class="fas fa-user"></i>
								<p>Customer</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="customer">
								<ul class="nav nav-collapse">
									<li><a href="/admin/user/add"> <span class="sub-item">Add
												Customer</span>
									</a></li>
									<li><a href="/admin/user/list"> <span class="sub-item">
												Manage Customer</span>
									</a></li>
								</ul>
							</div></li>

						<li class="nav-item"><a href="${cp}/admin/add"> <i
								class="fa fa-unlock"></i>
								<p>Sub Admin</p>
						</a></li>

						<li class="nav-item"><a href="${cp}/admin/order/list"> <i
								class="fas fa-truck"></i>
								<p>Order</p>
						</a></li>

						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#bills"> <i class="fas fa-file-invoice"></i>
								<p>Bill</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="bills">
								<ul class="nav nav-collapse">
									<li><a href="/admin/bill/create"> <span
											class="sub-item">Create Bill</span>
									</a></li>
									<li><a href="/admin/bill/list"> <span class="sub-item">
												View Bills</span>
									</a></li>
								</ul>
							</div></li>
						<li class="nav-item"><a href="${cp}/admin/company/add"> <i
								class="fas fa-building"></i>
								<p>Company</p>
						</a></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#work"> <i class="fas fa-poll"></i>
								<p>Task</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="work">
								<ul class="nav nav-collapse">
								<li><a href="/admin/work/mywork"> <span
											class="sub-item">View Your Work</span>
									</a></li>
									<li><a href="/admin/work/create"> <span
											class="sub-item">Create Task</span>
									</a></li>
									<li><a href="/admin/work/view"> <span class="sub-item">
												Manage Task</span>
									</a></li>
								</ul>
							</div></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- End Sidebar -->

		<div class="main-panel"
			style="height: fit-content; min-height: fit-content;">
			<div class="main-header">
				<div class="main-header-logo">
					<!-- Logo Header -->
					<div class="logo-header" data-background-color="dark">
						<a href="index.html" class="logo"> <img
							src="${cp}/image/logo.png" alt="navbar brand"
							class="navbar-brand" height="20" />
						</a>
						<div class="nav-toggle">
							<button class="btn btn-toggle toggle-sidebar">
								<i class="gg-menu-right"></i>
							</button>
							<button class="btn btn-toggle sidenav-toggler">
								<i class="gg-menu-left"></i>
							</button>
						</div>
						<button class="topbar-toggler more">
							<i class="gg-more-vertical-alt"></i>
						</button>
					</div>
					<!-- End Logo Header -->
				</div>
				<!-- Navbar Header -->
				<nav
					class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom">
					<div class="container-fluid">
						<nav
							class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex">
							<div class="input-group">
								<div class="input-group-prepend">
									<button type="submit" class="btn btn-search pe-1">
										<i class="fa fa-search search-icon"></i>
									</button>
								</div>
								<input type="text" placeholder="Search ..." class="form-control" />
							</div>
						</nav>

						<ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
							<li
								class="nav-item topbar-icon dropdown hidden-caret d-flex d-lg-none">
								<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
								href="#" role="button" aria-expanded="false"
								aria-haspopup="true"> <i class="fa fa-search"></i>
							</a>
								<ul class="dropdown-menu dropdown-search animated fadeIn">
									<form class="navbar-left navbar-form nav-search">
										<div class="input-group">
											<input type="text" placeholder="Search ..."
												class="form-control" />
										</div>
									</form>
								</ul>
							</li>



							<li class="nav-item topbar-user dropdown hidden-caret"><a
								class="dropdown-toggle profile-pic" data-bs-toggle="dropdown"
								href="#" aria-expanded="false">
									<div class="avatar-sm">
										<img src="${cp}/${user.photo}" alt="..."
											class="avatar-img rounded-circle" />
									</div> <span class="profile-username"> <span class="fw-bold">${user.name}</span>
								</span>
							</a>
								<ul class="dropdown-menu dropdown-user animated fadeIn">
									<div class="dropdown-user-scroll scrollbar-outer">
										<li>
											<div class="user-box">
												<div class="avatar-lg">
													<img src="${cp}/${user.photo}" alt="admin profile"
														class="avatar-img rounded" />
												</div>
												<div class="u-text">
													<h4>${user.name}</h4>
													<p class="text-muted">${user.email}</p>
												</div>
											</div>
										</li>
										<li>
											<div class="dropdown-divider"></div> <a class="dropdown-item"
											href="${cp}/admin/profile">Account Setting</a>
											<div class="dropdown-divider"></div> <a class="dropdown-item"
											href="${cp}/logout">Logout</a>
										</li>
									</div>
								</ul></li>
						</ul>
					</div>
				</nav>

			</div>


		

    <div class="container flex-grow-1">
        <div class="d-flex flex-column min-vh-100">
            <!-- Your main content here -->
        
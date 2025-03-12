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

<div class="container my-4">
	<!-- Card Wrapper for Add Product Form and Product List -->
	<c:choose>
		<c:when test="${edit ne true}">
			<div class="card shadow-lg">
				<div class="card-body">
					<div class="text-center py-2">
						<h1 class="h4 mb-0">Add Product</h1>
					</div>
					<a href="${cp}/admin/product/list" class="btn btn-info m-2">
						View Product <i class="fa fa-list"></i>
					</a>
					<form class="user" action="${cp}/admin/product/add" method="post"
						enctype="multipart/form-data" onsubmit="return validateForm()">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<!-- Product Title -->
						<div class="form-group">
							<label for="name">Product Title:</label> <input type="text"
								class="form-control" id="name" name="name"
								placeholder="Enter Product Name"> <span id="nameError"
								class="text-danger"></span>
						</div>

						<!-- Category -->
						<div class="form-group"></div>
						<!-- Prices -->
						<div class="form-group row">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<label for="category">Category:</label> <select
									class="form-control" id="category" name="category">
									<option value="">-- Select Category --</option>
									<c:forEach items="${cat_list}" var="cat">
										<option value="${cat.id}">${cat.name}</option>
									</c:forEach>
								</select> <span id="categoryError" class="text-danger"></span> <a
									href="/admin/category/show">Add New Category</a>
							</div>
							<div class="col-sm-6">
								<label for="cp">Cost Price:</label> <input type="number"
									class="form-control" id="cp" name="cp"
									placeholder="Enter Cost Price"> <span id="cpError"
									class="text-danger"></span>
							</div>
						</div>

						<!-- Prices -->
						<div class="form-group row">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<label for="sp">Selling Price:</label> <input type="number"
									class="form-control" id="sp" name="sp"
									placeholder="Enter selling price"> <span id="spError"
									class="text-danger"></span>
							</div>
							<div class="col-sm-6">
								<label for="qty">Product Quantity:</label> <input type="number"
									class="form-control" id="qty" name="qty"
									placeholder="Enter Product Quantity"> <span
									id="qtyError" class="text-danger"></span>
							</div>
						</div>




						<!-- Description -->
						<div class="form-group">
							<label for="description">Product Description:</label>
							<textarea class="form-control" id="description"
								name="description" placeholder="Enter the description" rows="5"></textarea>
							<span id="descriptionError" class="text-danger"></span>
						</div>

						<!-- Product Image -->
						<div class="form-group">
							<label for="imageFile">Product Image:</label> <input type="file"
								class="form-control" id="imageFile" name="imageFile"> <span
								id="imageError" class="text-danger"></span> <img
								id="imagePreview" src="#" alt="Image Preview"
								style="display: none; max-width: 150px; margin-top: 10px;" />
						</div>

						<!-- Buttons -->
						<div class="form-group d-flex justify-content-between">
							<input type="submit" class="btn btn-success ml-3"
								value="Add Product"> <input type="reset"
								class="btn btn-warning ml-2" value="Reset Form"
								onclick="resetPreview()">
						</div>
					</form>
				</div>
			</div>
		</c:when>

		<c:otherwise>
			<!-- Update Product Section -->
			<div class="card shadow-lg">
				<div class="card-body">
					<div class="text-center py-2">
						<h1 class="h4 mb-0">Update Product</h1>
					</div>
					<form class="user" action="${cp}/admin/product/update"
						method="post" enctype="multipart/form-data"
						onsubmit="return validateForm()">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<!-- Product ID -->
						<div class="form-group">
							<label for="productId">Product ID:</label> <input type="text"
								class="form-control" id="productId" name="id" value="${pro.id}"
								readonly>
						</div>

						<!-- Product Title -->
						<div class="form-group">
							<label for="name">Product Title:</label> <input type="text"
								class="form-control" id="name" name="name" value="${pro.name}">
							<span id="nameError" class="text-danger"></span>
						</div>

						<!-- Category -->
						<div class="form-group">
							<label for="category">Category:</label> <select
								class="form-control" id="category" name="category">
								<c:forEach items="${cat_list}" var="cat">
									<option value="${cat.id}"
										${pro.category.id eq cat.id ? "selected" : ""}>${cat.name}</option>
								</c:forEach>
							</select> <span id="categoryError" class="text-danger"></span>
						</div>

						<!-- Prices -->
						<div class="form-group row">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<label for="sp">Selling Price:</label> <input type="number"
									class="form-control" id="sp" name="sp" value="${pro.sp}">
								<span id="spError" class="text-danger"></span>
							</div>
							<div class="col-sm-6">
								<label for="cp">Cost Price:</label> <input type="number"
									class="form-control" id="cp" name="cp" value="${pro.cp}">
								<span id="cpError" class="text-danger"></span>
							</div>
						</div>

						<!-- Quantity -->
						<div class="form-group">
							<label for="qty">Product Quantity:</label> <input type="number"
								class="form-control" id="qty" name="qty" value="${pro.qty}">
							<span id="qtyError" class="text-danger"></span>
						</div>

						<!-- Description -->
						<div class="form-group">
							<label for="description">Product Description:</label>
							<textarea class="form-control" id="description"
								name="description" rows="5">${pro.description}</textarea>
							<span id="descriptionError" class="text-danger"></span>
						</div>

						<!-- Product Image -->
						<div class="form-group">
							<input type="hidden" name="pevImage" value="${pro.image}">
							<label for="imageFile">Product Image:</label> <input type="file"
								class="form-control" id="imageFile" name="imageFile"> <span
								id="imageError" class="text-danger"></span> <img
								id="imagePreview" src="${cp}/${pro.image}"
								style="display: none; max-width: 150px; margin-top: 10px;">
						</div>

						<div class="form-group d-flex justify-content-between">
							<input type="submit" class="btn btn-success ml-3"
								value="Update Product"> <input type="reset"
								class="btn btn-warning ml-2" value="Reset Form"
								onclick="resetPreview()">
						</div>
					</form>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script src="${cp}/css/productValidation.js"></script>
<%@ include file="../footer.jsp"%>
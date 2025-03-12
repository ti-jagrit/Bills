<%@ include file="header.jsp"%>
<style>
    .card-title {
        font-weight: bold;
    }

    .card-text {
        font-size: 0.9rem;
    }

    .card-img-top {
        transition: transform 0.3s ease;
    }

    .card-img-top:hover {
        transform: scale(1.05);
    }

    .card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
        transform: translateY(-5px); /* Lift the card */
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
    }
</style>

<div class="container my-4">
    <!-- Success and Error Messages -->
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

    <!-- Product Cards -->
    <div class="row">
        <c:forEach items="${product_list}" var="product">
            <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                <a href="product/show/${product.id}" style="text-decoration: none; color: inherit;">
                    <div class="card shadow-sm">
                        <!-- Product Image -->
                        <img src="${cp}/${product.image}" class="card-img-top" alt="Product Image" style="height: 200px; object-fit: cover;">
                        <!-- Card Body -->
                        <div class="card-body text-center">
                            <!-- Product Name -->
                            <h5 class="card-title">${product.name}</h5>
                            <!-- Product Category -->
                            <p class="card-text text-muted mb-2">Category: ${product.category.name}</p>
                            <!-- Product Price -->
                            <h6 class="text-success mb-3">RS ${product.sp}</h6>
                            <!-- Add to Cart Button -->
                            <a href="${cp}/user/cart/add/${product.id}" class="btn btn-primary">
                                <i class="bi bi-cart"></i> Add to Cart
                            </a>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="footer.jsp" %>

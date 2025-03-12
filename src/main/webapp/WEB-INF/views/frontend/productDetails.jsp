<%@ include file="header.jsp" %>

<div class="container my-5 m-5" style="margin-button-20px;">
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-6">
            <img src="${cp}/${product.image}" class="img-fluid rounded shadow" alt="Product Image">
        </div>
        <!-- Product Details -->
        <div class="col-md-6">
            <h2 class="mb-3">${product.name}</h2>
            <p class="text-muted">Category: ${product.category.name}</p>
            <h4 class="text-success mb-4">RS ${product.sp}</h4>
            <p class="mb-4">
                <strong>Description:</strong><br>
                ${product.description}
            </p>
            <!-- Add to Cart Button -->
            <a href="#" class="btn btn-primary btn-lg me-2">
                <i class="bi bi-cart"></i> Add to Cart
            </a>
            <!-- Share Button -->
            <a href="#" class="btn btn-outline-secondary btn-lg">
                <i class="bi bi-share"></i> Share
            </a>
        </div>
    </div>
</div>


<%@ include file="footer.jsp"%>
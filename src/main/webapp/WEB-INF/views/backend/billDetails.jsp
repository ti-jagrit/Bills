
<%@ include file="../topbar.jsp"%>
<c:if test="${not empty success}">
	<div class="alert alert-success fw-bold" role="alert">${success}
	</div>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-danger fw-bold" role="alert">${error}</div>
</c:if>

<div class="container">
    <!-- Bill Header -->
    <div class="bill-header text-center">
        <h2> <strong>Printo Hub Trade Link Pvt. Ltd.</strong></h2>
        <p>Address: Hotel-Snow Lion Building, Bagbazar, Kathmandu</p>
        <p>Phone: +977-0155920771 | Email: printohubnepal@gmail.com</p>
    </div>

    <!-- Bill Details Table -->
   <div class="bill-details">
   <div class="d-flex justify-content-around">
        <p><strong>Bill No:</strong> ${bill.billNumber}</p>
        <p><strong>Created Date:</strong> ${bill.createdDate}</p>
        </div>
        <div class="d-flex justify-content-around">
        <p><strong>Customer:</strong> ${bill.user.name}</p>
           <p><strong>Address:</strong> ${bill.user.address}</p>
        </div>
        
    </div>
    <hr>

    <!-- Product Items Table -->
    <div class="card-body">
        <h4>Product Items</h4>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Unit Price</th>
                    <th>Total Price</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${bill.items}" var="item">
                    <tr>
                        <td>${item.product.name}</td>
                        <td>${item.qty}</td>
                        <td>Rs.${item.sp}</td>
                        <td>Rs.${item.qty * item.sp}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Total Amount Summary -->
    <div class="card-body">
        <div class="row">
            <div class="col-md-8"></div>
            <div class="col-md-4 text-right">
            <p><strong>Sub Total:</strong> ${bill.amount}</p>
            <p><strong>Discount:</strong> ${bill.discount}</p>
            <p><strong>Tax:</strong> ${bill.tax}</p>
            
                <h4><strong>Total Amount: Rs.${bill.total}</strong></h4>
                <p><strong>Payment Method:</strong> ${bill.paymentMehtod}</p>
            </div>
        </div>
    </div>
    <a href="/admin/bill/printbill/${bill.id}" class="btn btn-success" target="_blank" > <i class="fa fa-print"></i> Print Bill</a>
    </div>
<%@ include file="../footer.jsp"%>
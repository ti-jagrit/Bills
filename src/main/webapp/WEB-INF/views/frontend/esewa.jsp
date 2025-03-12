<%@ include file="header.jsp"%>

<div class="container mt-5">
    <c:if test="${not empty success}">
        <div class="alert alert-success fw-bold" role="alert">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger fw-bold" role="alert">${error}</div>
    </c:if>
    <main>
        <div class="container">
            <div class="card border-0 shadow-lg rounded-3 my-4" style="background:light-green;">
                <div class="card-header bg-success text-white text-center py-4">
                    <h1 class="mt-3">Make Your Payment</h1>
                </div>
                <div class="card-body">
                    <form action="https://rc-epay.esewa.com.np/api/epay/main/v2/form" method="post">
                        <div class="row">
                            <!-- Left Column: Payment Details -->
                            <div class="col-md-8">
                                <h4 class="mb-4 text-success">Payment Summary</h4>
                             
                              
                                <div class="mb-3">
                                 <p class="fw-bold">Amount: ${payment.amount}</p>
                                 <p class="fw-bold">Tax Amount: ${payment.taxAmount}</p>
                                 <p class="fw-bold">Delivery Charge: ${payment.pdc}</p>
                                    <p class="fw-bold"> Service Charge: ${payment.psc}</p>
                                </div>
                                <hr><hr>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Total Amount:</label>
                                    <span class="h5 text-primary">${payment.totalAmount}</span>
                                </div>
                            </div>

                            <!-- Right Column: Proceed to Payment -->
                            <div class="col-md-4 d-flex flex-column justify-content-center align-items-center bg-light rounded-3 p-4">
                                <h4 class="mb-3 text-success text-center"> <img src="${cp}/image/esewa.png" alt="logo-esewa" height="50px" ></h4>
                                <!-- Hidden fields -->
                                <input type="hidden" name="amount" value="${payment.amount}">
                                <input type="hidden" name="tax_amount" value="${payment.taxAmount}">
                                <input type="hidden" name="product_delivery_charge" value="${payment.pdc}">
                                <input type="hidden" name="product_service_charge" value="${payment.psc}">
                                <input type="hidden" name="total_amount" value="${payment.totalAmount}">
                                <input type="hidden" name="transaction_uuid" value="${payment.transactionUUID}">
                                <input type="hidden" name="product_code" value="EPAYTEST">
                                <input type="hidden" name="success_url" value="${payment.successUrl}">
                                <input type="hidden" name="failure_url" value="${payment.failureUrl}">
                                <input type="hidden" name="signed_field_names" value="${payment.signedField}">
                                <input type="hidden" name="signature" value="${payment.signature}">

                                <!-- Proceed Payment Button -->
                                <button type="submit" class="btn btn-success btn-lg w-100 shadow">
                                    Proceed to Payment
                                </button>
                                <div class="mt-3 text-center">
                                    <p class="text-muted">You will be redirected to the secure eSewa payment gateway.</p>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
              
            </div>
        </div>
    </main>
</div>

<%@ include file="footer.jsp"%>

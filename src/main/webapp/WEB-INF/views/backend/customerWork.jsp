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
    <!-- Customer Information Card -->
    <div class="card mb-4">
        <div class="row no-gutters">
            <div class="col-md-3 text-center p-3">
                <img src="${cp}/${customer.photo}" alt="${customer.name}'s Photo" class="img-fluid rounded-circle" style="max-width: 150px;">
            </div>
            <div class="col-md-9">
                <div class="card-body">
                    <h3 class="card-title">${customer.name}</h3>
                    <p class="card-text mb-1"><strong>Phone:</strong> ${customer.phone}</p>
                    <p class="card-text mb-1"><strong>Email:</strong> ${customer.email}</p>
                    <p class="card-text mb-1"><strong>Address:</strong> ${customer.address}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Task List -->
    <div class="text-center bg-primary text-white py-2">
        <h1 class="h4 mb-0">Work List of ${customer.name}</h1>
    </div>
  

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Delivery Date</th>
                            <th>Assigned to</th>
                            <th>Quantity</th>
                            <th>Payment</th>
                            <th>View Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cus_work}" var="work">
                            <tr>
                                <td>${work.id}</td>
                                <td>${work.name}</td>
                                <td>${work.deliverDate}</td>
                                <td>
                                    <c:if test="${work.assignTo != null}">
                                        ${work.assignTo.name}
                                    </c:if>
                                    <c:if test="${work.assignTo == null}">
                                        <span class="text-danger">Not Assigned</span>
                                    </c:if>
                                </td>
                                <td>${work.qty}</td>
                                <td>${work.total - work.payment}</td>
                                <td>
                                    <a href="${cp}/admin/work/details/${work.id}" class="btn btn-warning text-white">View Details</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                  <a href="${cp}/admin/work/create" class="btn btn-success my-3">
        	<i class="fa fa-plus"></i> Create New Work
    		</a>
            </div>
        </div>
        
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

<%@ include file="../footer.jsp"%>

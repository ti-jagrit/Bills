	
	<%@ include file="header.jsp" %>
	
	<div class="container mt-5">
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
		<h1>Welcome to the Bills</h1>
		<p>This is a home web page with a summary of system user site bar.</p>
			<h1>Welcome to the Bills</h1>
		<p>This is a home web page with a summary of system user site bar.</p>

				
	</div>
	
	<%@ include file="footer.jsp"%>
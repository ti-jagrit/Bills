<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<title>Bills- Ecommerce </title>
</head>
<body>

<div class="logo-header" data-background-color="dark">
					
					 <img src="${cp}/image/logo.png" alt="navbar brand"
						class="navbar-brand" height="20" />
					
					</div>
<h1> this is index</h1>
<a href="${cp}/userlogin" class="btn btn-primary"> Login page</a>
</body>
</html>
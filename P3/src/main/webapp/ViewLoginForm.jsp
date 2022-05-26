<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="form-wrapper login-form">
	<h1>Welcome!</h1>
	<form novalidate action="LoginController" method="POST">
	  	<label for="username">Username (4 to 15 characters):</label>
	  	<input type="text" id="username" name="username" placeholder="@" value="${model.username}" required>
	  	<label for="password">Password (Minimum 6 characters): </label>
	  	<input type="password" id="password" name="password" placeholder="password" required>
	  	<button>Login!</button>
	</form>
</div>

<c:if test = "${model.error[1]}">
	<script> showError("Please enter a username.") </script>
</c:if>


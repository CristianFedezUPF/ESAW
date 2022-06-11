<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="form-wrapper login-form">
	<h1>Login</h1>
	<form novalidate action="LoginController" method="POST">
	  	<label for="username">Username (4 to 15 characters):</label>
	  	<input type="text" id="username" name="username" placeholder="@" value="${user.username}" required>
	  	<label for="password">Password (Minimum 6 characters): </label>
	  	<input type="password" id="password" name="password" placeholder="password" required>
	  	<button class="login-register-button" type="submit" name="sumbit" value="Submit">Login!</button>
	</form>
</div>

<!-- Check model/user thingy in LoginController, setAttribute compared to P3 where it was model -->
<c:if test = "${user.error.get(1)}">
	<script> showError("Please enter a username.") </script>
</c:if>
<c:if test = "${user.error.get(10) || user.error.get(11)}">
	<script> showError("Username or password not correct.") </script>
</c:if>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="parsley/parsley.min.js"></script>
<!--  <script src="parsley/i18n/ca.js"></script> -->
<title> Form with parsley </title>
<link rel="stylesheet" type="text/css" href="css/estil.css">
</head>

<body>

<ul class="server-errors-list">
<c:if test = "${model.error[0]}">
	<li> Entered user name has been already registered </li>
</c:if>
</ul>

<form data-parsley-validate action="RegisterController">
  <label for="user"> User name:</label>
  <br>
  <input type="text" id="user" name="user" placeholder="Name" value="${model.user}" required>
  <br>
  <label for="mail"> Mail: </label>
  <br>
  <input type="email" id="mail" name="mail" placeholder="Email" value="${model.mail}" required>
  <br>
  <label for="pwd1"> Password: </label>
  <br>
  <input type="password" id="pwd1" name="pwd1" placeholder="Password" value="${model.pwd1}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$">
  <br>
  <label for="pwd1"> Confirm password: </label>
  <br>
  <input type="password" id="pwd2" name="pwd2" placeholder="Confirm Password" value="${model.pwd2}" required data-parsley-equalto="#pwd1">
  <br><br>
  <button> Submit </button>
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:if test = "${error}">
<div class="w3-panel w3-theme-l4 w3-display-container">
  <span onclick="this.parentElement.style.display='none'"
  class="w3-button w3-large w3-display-topright">&times;</span>
  <h3> Identification error! </h3>
  <p> Provided credentials do not match our database. </p>
</div>
</c:if>


<form action="LoginController" method="POST">
	<p>      
    <label for="user" class="w3-text-theme"> User name </label><br>
    <input class="w3-input w3-border w3-light-grey" type="text" name="name" placeholder="Username" value="${user.name}" required autocomplete="username"><br>
    <label for="pwd1" class="w3-text-theme"> Password: </label><br>
  	<input class="w3-input w3-border w3-light-grey" type="password" id="pwd1" name="pwd" placeholder="Password" value="${user.pwd}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$" autocomplete="current-password"><br><br>
    <input class="w3-btn w3-theme" type="submit" name="sumbit" value="Submit"></p>
</form>

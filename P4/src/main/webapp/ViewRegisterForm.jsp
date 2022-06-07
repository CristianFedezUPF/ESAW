<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test = "${user.error['user']}">
<div class="w3-panel w3-theme-l4 w3-display-container">
  <span onclick="this.parentElement.style.display='none'"
  class="w3-button w3-large w3-display-topright">&times;</span>
  <h3> Registration error! </h3>
  <p> Given user name already exist on our database. </p>
</div>
</c:if>

<c:if test = "${user.error['mail']}">
<div class="w3-panel w3-theme-l4 w3-display-container">
  <span onclick="this.parentElement.style.display='none'"
  class="w3-button w3-large w3-display-topright">&times;</span>
  <h3> Registration error! </h3>
  <p> Given mail already exist on our database. </p>
</div>
</c:if>

<form action="RegisterController" id="regform" method="POST">
  <p>
  <label for="user" class="w3-text-theme"> User name:</label><br>
  <input class="w3-input w3-border w3-light-grey" type="text" id="name" name="name" placeholder="Username" value="${user.name}" required autocomplete="username"><br>
  <label for="mail" class="w3-text-theme"> Mail  </label><br>
  <input class="w3-input w3-border w3-light-grey" type="email" id="mail" name="mail" placeholder="Mail" value="${user.mail}" required autocomplete="email"><br>
  <label for="pwd1" class="w3-text-theme"> Password: </label><br>
  <input class="w3-input w3-border w3-light-grey" type="password" id="pwd1" name="pwd" placeholder="Password" value="${user.pwd}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$" autocomplete="new-password"><br>
  <label for="pwd2" class="w3-text-theme"> Confirm Password: </label><br>
  <input class="w3-input w3-border w3-light-grey" type="password" id="pwd2" placeholder="Confirm Password" value="${user.pwd}" required autocomplete="new-password"><br><br>
  <input class="w3-btn w3-theme" type="submit" name="sumbit" value="Submit"></p>
</form>

<script>
var regform = document.getElementById("regform");
var email = document.getElementById("mail");
var pwd1 = document.getElementById("pwd1");
var pwd2 = document.getElementById("pwd2");

var checkPasswordValidity = function() {
	 if (pwd2.value !== pwd1.value ) {
		pwd2.setCustomValidity("Passwords must match!");
	} else {
		pwd2.setCustomValidity("");
	}
}
pwd2.addEventListener("input", checkPasswordValidity, false);

regform.addEventListener("submit", function (event) {
	checkPasswordValidity();
	if (!this.checkValidity()) {
		this.reportValidity();
		event.preventDefault();
	} 
}, false);
</script>
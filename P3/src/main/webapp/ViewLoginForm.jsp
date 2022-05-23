<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- UPDATE FOR LOGIN -->

<div id="form-wrapper">
	<h1>Welcome!</h1>
	<form novalidate action="RegisterController" method="POST">
	  	<label for="username">Username (4 to 15 characters):</label>
	  	<input type="text" id="username" name="username" placeholder="@" value="${model.username}" required>
	  	<label for="password">Password (Minimum 6 characters): </label>
	  	<input type="password" id="password" name="password" placeholder="password" required>
	  	<button>Submit</button>
	</form>
</div>
<script>

//There are many ways to pick a DOM node; here we get the form itself and the email
//input box, as well as the span element into which we will place the error message.
const form  = document.getElementsByTagName('form')[0];
const email = document.getElementById('mail');

form.addEventListener('submit', function (event) {
	if(!checkInputs()){
		event.preventDefault();
	}
});

function checkInputs(){
	const inputs = form.getElementsByTagName("input");
	for(const input of inputs){
		if(!isInputValid(input)){
			return false;
		}
	}
	if(!passwordsMatch()){
		showError("Passwords don't match.");
		return false;
	}
	return true;
}

function isInputValid(input){
	let value;
	try{
		value = input.value.trim();
		input.value = value;
	} catch(e){
		console.log(e);
	}
	switch(input.id){
		case "name":
			if(value === ""){
				showError("Please enter a name"); return false;
			}
			break;
		case "username":
			if(value === ""){
				showError("Please enter a username"); return false;
			}
			else if(value.length < 4){
				showError("Username length should be longer than 4 characters"); return false;
			}
			else if(value.length > 15){
				showError("Username length should be shorter than 15 characters"); return false;
			}
			// TODO if user exists
			else if(!validateUsername(value)){
				showError("Username is not valid"); return false;
			}
			break;
		case "email":
			if(!validateEmail(value)){
				showError("Email is not valid"); return false;
			}
			break;
		case "password":
			if(value === ""){
				showError("Please enter a password"); return false;
			}
			else if(value.length < 6){
				showError("Password length should be longer than 6 characters"); return false;
			}
			else if(!validatePassword(value)){
				showError("Password must contain only alphanumeric characters"); return false;
			}
			break;
		case "password-check":
			if(!validatePassword(value)){
				showError("Password must contain only alphanumeric characters"); return false;
			}
			break;
		case "degree":
			if(value === ""){
				input.value = null;
			}
			else if(!validateDegree(value)){
				showError("Degree must contain only text characters"); return false;
			}
			break;
		case "birthday":
			if(value === ""){
				input.value = null;
			}
			else if(!validateDate(value)){
				showError("Date is not valid"); return false;
			}
			break;
	}
	return true;
}

function showError(errorMessage) {
	const template = document.getElementsByTagName("template")[0];
	let error = template.content.querySelector("p");
	if(error !== null){
		error.innerText = errorMessage;
		form.getElementsByTagName("button")[0].before(error);
	}
	else{
		error = document.getElementsByClassName("error-message")[0];
		error.innerText = errorMessage;
	}
}

function validateUsername(username){
	return /^[a-zA-Z0-9]+$/.test(username);
}

function validateEmail(email){
	return /[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email);
}

function validatePassword(password){
	return /^[a-zA-Z0-9]+$/.test(password);
}

function validateDegree(degree){
	return /^[a-zA-Z ]+$/.test(degree);
}
	
function validateDate(date){
	return date === "" || /^[0-9-]+$/.test(date);
}

function passwordsMatch(){
	let pwd1 = document.getElementById("password").value;
	let pwd2 = document.getElementById("passwordCheck").value;
	return pwd1 === pwd2;
}
	

</script>
<c:if test = "${model.error[0]}">
	<script> showError("Please enter a name.") </script>
</c:if>

<c:if test = "${model.error[1]}">
	<script> showError("Please enter a username.") </script>
</c:if>

<c:if test = "${model.error[2]}">
	<script> showError("Username length invalid.") </script>
</c:if>

<c:if test = "${model.error[3]}">
	<script> showError("Username is not valid.") </script>
</c:if>

<c:if test = "${model.error[4]}">
	<script> showError("Username is already in use.") </script>
</c:if>

<c:if test = "${model.error[5]}">
	<script> showError("Email is not valid.") </script>
</c:if>

<c:if test = "${model.error[6]}">
	<script> showError("Password length should be longer than 6 characters") </script>
</c:if>

<c:if test = "${model.error[7]}">
	<script>showError("Password must contain only alphanumeric characters") </script>
</c:if>

<c:if test = "${model.error[8]}">
	<script>showError("Degree must contain only text characters")</script>
</c:if>

<c:if test = "${model.error[9]}">
	<script>showError("Email is already in use.")</script>
</c:if>
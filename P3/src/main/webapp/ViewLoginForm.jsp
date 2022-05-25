<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="form-wrapper login-form">
	<h1>Welcome!</h1>
	<form novalidate action="RegisterController" method="POST">
	  	<label for="username">Username (4 to 15 characters):</label>
	  	<input type="text" id="username" name="username" placeholder="@" value="${model.username}" required>
	  	<label for="password">Password (Minimum 6 characters): </label>
	  	<input type="password" id="password" name="password" placeholder="password" required>
	  	<button>Login!</button>
	</form>
</div>

<script>

//There are many ways to pick a DOM node; here we get the form itself and the email
//input box, as well as the span element into which we will place the error message.
const form  = document.getElementsByTagName('form')[0];
const email = document.getElementById('mail');

form.addEventListener('submit',(event) => {
	if(!checkInputs()){
		event.preventDefault();
	}
	else{
		$('#content').load($(this).attr('action'),$(this).serialize());
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
		case "username":
			if(value === ""){
				showError("Please enter a username"); return false;
			}
			// TODO if user exists
			else if(!validateUsername(value)){
				showError("Username is not valid"); return false;
			}
			break;
		/*case "email":
			if(!validateEmail(value)){
				showError("Email is not valid"); return false;
			}
			break;*/
		case "password":
			if(value === ""){
				showError("Please enter a password"); return false;
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

</script>

<c:if test = "${model.error[1]}">
	<script> showError("Please enter a username.") </script>
</c:if>


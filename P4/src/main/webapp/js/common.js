document.addEventListener("submit", event => {
	
	console.log("common.js");
	
	event.preventDefault();
	if(!checkInputs()){
		return false;
	}
	if(document.getElementById("passwordCheck") != null){ // if we are in register form
		if(!passwordsMatch()){
			showError("Passwords don't match.");
			return false;
		}
	}
	$('#content').load($("form").attr("action"), $("form").serialize());
});

function checkInputs(){
	const inputs = document.getElementsByTagName('form')[0].getElementsByTagName("input");
	for(const input of inputs){
		if(!isInputValid(input)){
			return false;
		}
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
	if(isErrorShown()){
		let error = document.getElementsByClassName("error-message")[0];
		error.innerText = errorMessage;
	}
	else{
		let templateError = template.content.querySelector("p");
		templateError.innerText = errorMessage;
		document.getElementsByTagName('form')[0]
		.getElementsByTagName("button")[0]
		.before(templateError.cloneNode(true));

	}
}

function isErrorShown(){
	return document.getElementsByClassName("error-message")[0] != undefined;
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
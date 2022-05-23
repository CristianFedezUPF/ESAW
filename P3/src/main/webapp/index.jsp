<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="imgs/me.png">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Lab 3 template </title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- TODO: REMOVE W3 fonts and CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	$.ajaxSetup({ cache: false }); //Avoids Internet Explorer caching!	
	$(document).on("click",".menu", async function(event) {
		//$('#content').load('ContentController',{content: $(this).attr('id')});
		const response = await fetch($(this).attr('id'));
		$('#content').html(await response.text());
		//$('#content').load($(this).attr('id'));
		event.preventDefault();
	});
	$(document).on("submit","form", function(event) {
		$('#content').load($(this).attr('action'),$(this).serialize());
	    event.preventDefault();
	});
});
</script>

<template>
	<p class="error-message">error</p>
</template>
<style>
* {
	margin: 0;
	padding: 0;
	font-family: 'Roboto', sans-serif;
}

html {
	height: 100%;
}

body {
	width: 100%;
	height: 100%;
	background: #1b1e24;
}

input:valid {
	border: 1px solid #47bf26;
}

input:invalid {
	border: 1px solid red;
}

#degree:valid {
	border: 1px dashed #47bf26;
}

#birthday:valid {
	border: 1px dashed #47bf26;
}


/* This is the style of our error messages */
.error {
  width  : 100%;
  padding: 0;

  font-size: 80%;
  color: white;
  background-color: #900;
  border-radius: 0 0 5px 5px;

  box-sizing: border-box;
}

.error.active {
  padding: 0.3em;
}

#form-wrapper{
	display: flex;
	flex-direction: column;
	border: 1px red;
	background: #2d323b;
	border-radius: 8px;
    width: max(250px, 35%);
    height: 90%;
    max-height: max-content;
    /* offset-x | offset-y | blur-radius | spread-radius | color */
	box-shadow: 0px 4px 2px 1px rgba(0, 0, 0, 0.2);
	overflow: scroll;
	
}

#form-wrapper > form {
	overflow: scroll;
	display: flex;
	flex-direction: column;
}

#form-wrapper > h1{
	color: white;
	margin-top: 18px;
	margin-left: 45px;
	margin-bottom: 12px;
}

form > * {
	margin-left: 40px;
}

form:first-child{
	margin-top: 10px;
}

form:last-child{
	margin-bottom: 10px;
}

form > label{
	margin-bottom: 2px;
	font-size: 16px;
	color: white;
}

form > input{
	border: 1px gray;
	border-radius: 6px;
	width: 70%;
	height: 26px;
	background: #373b40;
	padding-left: 10px;
	font-size: 13px;
	color: white;
	margin-bottom: 6px
}

form > input:focus{
	outline: 1px white;
}

form > input::placeholder{
	font-size: 13px;
	color: #c2c2c2;
}

form > select{
	width: 200px;
	font-size: 13px;
	background: transparent;
	background-color: #373b40;
	border-radius: 6px;
	color: white;
	margin-bottom: 6px
}

form > select:checked{
	color: #c2c2c2;
}

button{
	margin-left: 0px;
	margin-top: 6px;
	align-self: center;
	padding: 8px;
	font-size: 15px;
	border: 1px blue;
	border-radius: 6px;
	color: white;
	background: #5aa854;
	border: 1px solid #376933;
}

button:hover {
	cursor: pointer;
}

.error-message{
	color: #f7665c;
}

#content{
	display: flex;
	align-items: center;
	justify-content: center;
}

</style>
</head>
<body>

 	<!-- Begin Navigation -->
 	<div class="w3-bar w3-red" id="navigation">
    <jsp:include page="${menu}" />
 	</div>
 	<!-- End Navigation -->
 
	<!-- Begin Content -->
	<div class="w3-container w3-card-4 w3-padding-24" id="content">
	<jsp:include page="${content}" />
	</div>
	<!-- End Content -->
	
	<script>
		function stack() {
  			var x = document.getElementById("stack");
  			if (x.className.indexOf("w3-show") == -1) {
    			x.className += " w3-show";
  			} else { 
    		x.className = x.className.replace(" w3-show", "");
  			}
		}
	</script>

  </body>
</html>
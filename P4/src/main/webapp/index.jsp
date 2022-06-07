<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title> Lab 4 Unitter</title>
		<link rel="icon" href="imgs/logo.ico" type="image/vnd.microsoft.icon">
	
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-red.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="css/mainStructure.css">
		<link rel="stylesheet" href="css/timeline.css">
		<link rel="stylesheet" href="css/form.css">
		<link rel="stylesheet" href="css/moreStyles.css">
				
		<link rel="preconnect" href="https://fonts.googleapis.com"> 
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
		<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		
		<script src = js/init.js type="text/javascript" defer></script>
		<script src = js/common.js type="text/javascript" async></script>
		
		<template>
			<p class="error-message">error</p>
		</template>

	</head>
	<body>

	 	<!-- Begin Navigation -->
	 	<div class="w3-bar" id="navigation">
	    	<jsp:include page="${menu}" />
	 	</div>
	 	<!-- End Navigation -->
	 
		<div id="content">
			<jsp:include page="${content}" />
		</div>

		<!-- Footer -->
		<footer>
		  <p> Universitat Pompeu Fabra </p>
		</footer>
		
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
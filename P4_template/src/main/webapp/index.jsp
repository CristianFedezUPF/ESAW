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
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		
		<template>
			<p class="error-message">error</p>
		</template>
		
		<script src = js/init.js type="text/javascript" defer></script>

	</head>
	<body>

	 	<!-- Begin Navigation -->
	 	<div class="w3-theme" id="navigation">
	    	<jsp:include page="${menu}" />
	 	</div>
	 	<!-- End Navigation -->
	 
	 	<!-- Begin Content -->
		<div class="w3-row-padding">
	 	<!-- Left Column -->
		<div class="w3-container w3-col m3 w3-hide-small">
			<div id="rcolumn">
				<p></p>
			</div>
		</div>
		<!-- Middle Column -->	
		<div class="e3-container w3-col m6">
			<div id="content">
				<jsp:include page="${content}" />
			</div>
		</div>
		<!-- Right Column -->
		<div class="w3-container w3-col m3 w3-hide-small">
			<div id="lcolumn">
				<p></p>
			</div>
		</div>
		</div>
		<!-- End Content -->
		<!-- Footer -->
		<footer class="w3-container w3-theme">
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
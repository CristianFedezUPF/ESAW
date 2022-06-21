<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
 $(document).ready(function(){
	$('#country').load('GetCountries');
 });
</script>

<div class="form-wrapper registration-form">
	<h1>Registration</h1>
	<form novalidate action="RegisterController" method="POST">
	  	<label for="name">Name:</label>
	  	<input type="text" id="name" name="name" placeholder="e.g: Jane Smith" value="${user.name}" required>
	  	<label for="username">Username (4 to 15 characters):</label>
	  	<input type="text" id="username" name="username" placeholder="@" value="${user.username}" required>
	  	<label for="email">Email:</label>
	  	<input type="email" id="email" name="email" placeholder="e.g: jane.smith@gmail.com" value="${user.email}" required>
	  	<label for="password">Password (Minimum 6 characters): </label>
	  	<input type="password" id="password" name="password" placeholder="password" required>
	  	<label for="passwordCheck"> Confirm Password: </label>
  		<input type="password" id="passwordCheck" name="passwordCheck" placeholder="password" required>  	
	  	<label for="gender">Gender:</label>
	  	<select name="gender" id="gender">
	    	<option value="NS">Prefer not to say</option>
	    	<option value="F">Female</option>
	    	<option value="M">Male</option>
	    	<option value="NB">Non-binary</option>
	  	</select>
	  	<label for="university">University:</label>
	  	<select name="university" id="university"> <!-- for now just from Catalunya! -->
	    	<option value="UB">Universitat de Barcelona</option>
	    	<option value="UPF">Universitat Pompeu Fabra</option>
	    	<option value="UAB">Universitat Autònoma de Barcelona</option>
	    	<option value="UdL">Universitat de Lleida</option>
	    	<option value="UdG">Universitat de Girona</option>
	    	<option value="URV">Universitat Rovira i Virgili</option>
	    	<option value="UOC">Universitat Oberta de Catalunya</option>
	    	<option value="URL">Universitat Ramon Llull</option>
	    	<option value="Uvic">Universitat de Vic</option>
	    	<option value="UIC">Universitat Internacional de Catalunya</option>
	    	<option value="UAO-CEU">Universitat Abat Oliba</option>
	  	</select>
	  	<label for="degree">Degree:</label>
	  	<input type="text" id="degree" name="degree" placeholder="e.g: Computer Science" value="${user.degree}">
	  	<label for="country">Country:</label>
	  	<select name="country" id="country">
	    </select>
	    <label for="birthday">Birthday:</label>
	  	<input type="date" id="birthday" name="birthday" max="2008-01-01" value="${user.birthday}">
	  	<label for="position">Position:</label>
	  	<select name="position" id="position">
	    	<option value="S">Student</option>
	    	<option value="T">Teacher</option>
	  	</select>	  	
	  	
	  	<button class="login-register-button">Register!</button>
	</form>
</div>

<c:if test = "${user.error['0']}">
	<script> showError("Please enter a name.") </script>
</c:if>

<c:if test = "${user.error['1']}">
	<script> showError("Please enter a username.") </script>
</c:if>

<c:if test = "${user.error['2']}">
	<script> showError("Username length invalid.") </script>
</c:if>

<c:if test = "${user.error['3']}">
	<script> showError("Username is not valid.") </script>
</c:if>

<c:if test = "${user.error['4']}">
	<script> showError("Username is already in use.") </script>
</c:if>

<c:if test = "${user.error['5']}">
	<script> showError("Email is not valid.") </script>
</c:if>

<c:if test = "${user.error['6']}">
	<script> showError("Password length should be longer than 6 characters") </script>
</c:if>

<c:if test = "${user.error['7']}">
	<script>showError("Password must contain only alphanumeric characters") </script>
</c:if>

<c:if test = "${user.error['8']}">
	<script>showError("Degree must contain only text characters")</script>
</c:if>

<c:if test = "${user.error['9']}">
	<script>showError("Email is already in use.")</script>
</c:if>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="followed-users-title">
	<p>Here's a list of the users you follow</p>
</div>
<div id="followed-users-wrapper">
	<c:forEach var="u" items="${users}">
		<div data-userid="${u.id}" class="followed-user">
			<div class="followed-user-info">
				<div class="followed-user-avatar-wrapper">
					<img class="followed-user-avatar" src="imgs/avatar5.png">
				</div>
				<div class="followed-user-content-wrapper">
					<p>${u.name}</p>
					<p>@${u.username}</p>
					<p>${u.university}</p>
					<p>${u.degree}</p>
				</div>
			</div>
			<button class="unfollow-button">Unfollow</button>
		</div>
 		
	</c:forEach>
</div>

<script type="text/javascript">
	function setLeftColumnRightBorder(){
		let users_wrapper = document.getElementById("followed-users-wrapper");
		let child_count = users_wrapper.childElementCount;
		for(var i = 0; i < child_count; ++i){
			if(i % 2 == 0){ //if element is in left column
				users_wrapper.children[i].style.borderRight = "1px solid #1b222e";
			}
		}
	}
	
	setLeftColumnRightBorder();
	
</script>
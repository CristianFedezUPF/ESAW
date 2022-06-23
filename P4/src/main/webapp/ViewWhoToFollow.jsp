<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<p>Who to follow</p>
<c:if test="${fn:length(users) >= 1}">
	<c:forEach var="u" items="${users}">       
	 	<div data-userid="${u.id}" class="who-to-follow-user">
	 		<div class="who-to-follow-info">
	 			<div class="who-to-follow-avatar-wrapper">
	 				<img class="who-to-follow-avatar" src="imgs/avatar2.png" alt="Avatar">
	 			</div>
	 			<div class="who-to-follow-content-wrapper">
	 				<p>${u.name}</p>
	 				<p class="who-to-follow-secondary-text">@${u.username}</p>
	 				<p class="who-to-follow-secondary-text">${u.university}</p>
	 			</div>
	 		</div>
	 		<button class="follow-button">Follow</button>
	 	</div>
	</c:forEach>
</c:if>
<c:if test="${fn:length(users) < 1}">
	<div class="who-to-follow-message">
		<p>It seems that you already follow everyone!</p>
	</div>
</c:if>

<script type="text/javascript">
	// to set the bottom who to follow user to same round borders
	function setBottomWhoToFollowUserToRoundBorders(){
		let who_to_follow = document.getElementById("who-to-follow");
		let border_radius = getComputedStyle(who_to_follow).borderBottomLeftRadius;
		let element = who_to_follow.children[who_to_follow.childElementCount - 2];
		if(element.tagName === "DIV"){
			element.style["border-bottom-left-radius"] = border_radius;
			element.style["border-bottom-right-radius"] = border_radius;
		}
	}
	
	setBottomWhoToFollowUserToRoundBorders();
	
	
</script>
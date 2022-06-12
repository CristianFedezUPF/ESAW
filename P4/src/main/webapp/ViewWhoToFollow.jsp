<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<p>Who to follow</p>
<c:if test="${fn:length(users) > 1}">
	<c:forEach var="u" items="${users}">       
	 	<div id="${u.id}" class="who-to-follow-user">
	 		<div class="who-to-follow-info">
	 			<div class="who-to-follow-avatar-wrapper">
	 				<img class="who-to-follow-avatar" src="imgs/avatar2.png" alt="Avatar">
	 			</div>
	 			<div class="who-to-follow-content-wrapper">
	 				<p>${u.name}</p>
	 				<p>@${u.username}</p>
	 				<p>${u.university}</p>
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
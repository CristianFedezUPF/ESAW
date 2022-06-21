<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="t" items="${tweets}">       
 	<div data-tweetid="${t.id}" data-posterid="${t.userId}" class="tweet">
		<div class="tweet-avatar-wrapper">
 			<img class="tweet-avatar" src="imgs/avatar2.png" alt="Avatar">
 		</div>
 		<div class="tweet-content-wrapper">
 			<div class="tweet-content-header-wrapper">
 				<div class="tweet-content-header">
 					<p class="tweet-user">${t.name}</p>
 					<p class="tweet-username">@${t.username}</p>
 					<p class="tweet-datetime-separator">·</p>
 					<p class="tweet-datetime">${t.timeSince}</p>
 					<c:if test="${t.editTimeSince != null}">
 						<p class="tweet-datetime-separator">·</p>
 						<p class="tweet-edit-datetime">Edited ${t.editTimeSince} ago</p>
 					</c:if>
 				</div>
 				<div class="tweet-buttons">
	 				<c:if test="${t.userId == user.id && is_profile}">
						<i class="tweet-icon tweet-edit-button fa fa-edit"></i>					
	 					<i class="tweet-icon tweet-delete-button fa fa-trash"></i>					
		 			</c:if>
	 			</div>
 			</div>
   			<p class="tweet-content">${t.content}</p>
 		</div>
 	</div>
</c:forEach>

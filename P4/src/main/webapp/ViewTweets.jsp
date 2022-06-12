<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="t" items="${tweets}">       
 	<div id="${t.id}" class="tweet">
		<div class="tweet-avatar-wrapper">
 			<img class="tweet-avatar" src="imgs/avatar2.png" alt="Avatar">
 		</div>
 		<div class="tweet-content-wrapper">
 			<div class="tweet-content-header">
 				<p class="tweet-user">${t.name}</p>
 				<p class="tweet-username">@${t.username}</p>
 				<p class="tweet-datetime-separator">·</p>
 				<p class="tweet-datetime">${t.timeSince}</p>
 			</div>
   			<p>${t.content}</p>
 		</div>
 	</div>
</c:forEach>

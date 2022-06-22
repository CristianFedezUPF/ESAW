<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="t" items="${tweets}">       
 	<div data-tweetid="${t.id}" data-posterid="${t.userId}" class="tweet">
 		<c:if test="${t.retweetUserId != null}">
	 		<div data-retweetuserid="${t.retweetUserId}" class="retweet-info-wrapper">
	 			<p class="retweet-info">${t.retweetUserName} reposted this ${t.timeSinceRetweet} ago</p>
	 		</div> 		
 		</c:if>
 		<div class="tweet-wrapper">
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
	 					<c:if test="${t.timeSinceEdit != null}">
	 						<p class="tweet-datetime-separator">·</p>
	 						<p class="tweet-edit-datetime">Edited ${t.timeSinceEdit} ago</p>
	 					</c:if>
	 				</div>
	 				<div class="tweet-buttons">
		 				<c:if test="${(t.userId == user.id) || user.isAdmin}">
							<i class="tweet-icon tweet-edit-button fa fa-edit"></i>					
		 					<i class="tweet-icon tweet-delete-button fa fa-trash"></i>					
			 			</c:if>
		 			</div>
	 			</div>
	   			<p class="tweet-content">${t.content}</p>
	   			<c:if test = "${user != null}">
	   			<div class="tweet-options">
	   				<c:if test="${!t.isRetweeted}">
			   			<div class="tweet-option-wrapper tweet-retweet">
			   				<i class="tweet-retweet-button tweet-option fa fa-retweet"></i>
			   				<p class="tweet-option-number">${t.retweetCount}</p>
			   			</div>
			   		</c:if>
			   		<c:if test="${t.isRetweeted}">
			   			<div class="tweet-option-wrapper tweet-remove-retweet">
			   				<i class="tweet-retweet-button tweet-option fa fa-retweet"></i>
			   				<p class="tweet-option-number">${t.retweetCount}</p>
			   			</div>
			   		</c:if>
		   			<c:if test="${!t.isLiked}">
			 			<div class="tweet-option-wrapper tweet-like">
			 				<i class="tweet-like-button tweet-option fa fa-heart"></i>
			 				<p class="tweet-option-number">${t.likeCount}</p>
			 			</div>
			 		</c:if>
			 		<c:if test="${t.isLiked}">
			 			<div class="tweet-option-wrapper tweet-dislike">
			 				<i class="tweet-like-button tweet-option fa fa-heart"></i>
			 				<p class="tweet-option-number">${t.likeCount}</p>
			 			</div>
			 		</c:if>
		 			
	 			</div>
	 			</c:if>
	 		</div>
 		</div>
 	</div>
</c:forEach>

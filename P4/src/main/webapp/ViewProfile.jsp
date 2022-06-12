<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="profile-wrapper">
	<div class="profile-avatar-wrapper">
		<img class="profile-avatar" src="imgs/avatar5.png">
	</div>
	<div class="profile-info">
		<p class="profile-name">${profile.name}</p>
		<p class="profile-username">@${profile.username}</p>
		<p class="profile-text" style="margin-top: 10px;">${profile.country}</p>
		<p class="profile-text">
			${profile.university} ·
			<c:if test="${profile.position == 'S'}">
			Student
			</c:if>
			<c:if test="${profile.position == 'T'}">
			Teacher
			</c:if>
		</p>
		<p class="profile-text">${profile.degree}</p>
		<p class="profile-text">${profile.birthday}</p>
	</div>
	<div class="profile-stats">
	
	</div>
</div>
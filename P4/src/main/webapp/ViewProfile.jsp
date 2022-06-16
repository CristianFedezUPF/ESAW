<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

 <script type="text/javascript">
 $(document).ready(function(){
	$('#tweet-list').load('GetUserTweets/'+'${profile.id}');
 });
</script>

<div data-profileid="${profile.id}" class="profile-wrapper">
	<div class="profile-avatar-wrapper">
		<img class="profile-avatar" src="imgs/avatar5.png">
		<c:if test="${profile.id != user.id}">
			<c:if test="${!is_user_following && !is_anonymous_user}">
				<button class="profile-follow-button">Follow</button>
			</c:if>
			<c:if test="${is_user_following && !is_anonymous_user}">
				<button class="profile-unfollow-button">Unfollow</button>
			</c:if>
		</c:if>
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
</div>
<div class="profile-stats">
		<p class="post-count"><span style="font-weight:bold; font-size: 16px;">${profile.postCount}</span> posts</p>
		<p class="follower-count"><span style="font-weight:bold; font-size: 16px;">${profile.followerCount}</span> followers</p>
		<p class="following-count"><span style="font-weight:bold; font-size: 16px;">${profile.followingCount}</span> following</p>
</div>
<div id="tweet-list">
</div>

<script>

</script>
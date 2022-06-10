<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

 <script type="text/javascript">
 $(document).ready(function(){
	$('#navigation').load('MenuController');
	$('#tweet-list').load('GetGlobalTweets');
 });
</script>

<div id="grid-layout">
	<div id="lcolumn">
		<div id="lcolumn-menu">
			<p id="logo">Unitter</p>
			<p id="GetCustomTimeline" class="menu lcolumn-menu-item" style="margin-top: 50px;">Home</p>
			<p id="GetGlobalTimeline" class="menu lcolumn-menu-item">Explore</p>
			<p class="lcolumn-menu-item">Following</p>
			<p class="lcolumn-menu-item">Profile</p>
		</div>
		<div id="lcolumn-profile">
			<div id="profile-wrapper">
				<img class="user-profile-avatar" src="imgs/avatar2.png">
				<div id="user-profile-info">
					<p id="user-profile-name">${user.name}</p>
					<p id="user-profile-username">@${user.username}</p>
				</div>
			</div>
		</div>
	</div>
	<div id="mcolumn">
		<div id="input-wrapper">
			<textarea id="typing-input" placeholder="What's happening?"></textarea>
			<button id="post-button">Post</button>
		</div>
		<div id="tweet-list">
		</div>
	</div>
	<div id="rcolumn">
		<p>test3</p>
	</div>
</div>
 


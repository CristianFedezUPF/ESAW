<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

 <script type="text/javascript">
 $(document).ready(function(){
	$('#navigation').load('MenuController');
	$('#tweet-list').load('GetTweets');
 });
</script>

<div id="grid-layout">
	<div id="lcolumn">
		<p id="logo">Unitter</p>
		<p class="lcolumn-menu" style="margin-top: 50px;">Home</p>
		<p class="lcolumn-menu">Explore</p>
		<p class="lcolumn-menu">Following</p>
		<p class="lcolumn-menu">Profile</p>
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
 


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

 <script type="text/javascript">
 $(document).ready(function(){
	$('#tweet-list').load('GetCustomTweets');
 });
</script>
<div id="input-wrapper">
	<textarea id="typing-input" placeholder="What's happening?" maxlength = "200"></textarea>
	<div id="input-bottom">
		<p id="input-info">These are posts from the people you follow.</p>
		<button id="post-button" data-controller="GetCustomTweets">Post</button>
	</div>			
</div>
<div id="tweet-list">
</div>

 


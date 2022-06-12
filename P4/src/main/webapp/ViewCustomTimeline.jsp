<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

 <script type="text/javascript">
 $(document).ready(function(){
	$('#tweet-list').load('GetCustomTweets');
 });
 document.getElementById("input-info").innerText = "These are posts from the users you follow.";
</script>


 


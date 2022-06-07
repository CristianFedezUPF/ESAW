// TODO update this as in P3
$(document).ready(function(){
	
			$.ajaxSetup({ cache: false }); //Avoids Internet Explorer caching!	
			$(document).on("click",".menu",function(event) {
				$('#content').load($(this).attr('id'));
				event.preventDefault();
			});
			$(document).on("submit","form", function(event) {
				$('#content').load($(this).attr('action'),$(this).serialize());
			    event.preventDefault();
			});
			/* Add tweet */
			$(document).on("click","#addTweet",function(event){
				$.post( "AddTweet", { content: $("#tweetContent").text()}, function(event) {
					$("#content").load("GetOwnTimeline");		
				});
				event.preventDefault();
			});
			/* Delete tweet */
			$(document).on("click",".delTweet",function(event){
				var tweet = $(this).parent();
				$.post( "DelTweet", { id: $(this).parent().attr("id") } , function(event) {
					$("#content").load("GetOwnTimeline");				
				});
				event.preventDefault();
			});
			/* Follow user */
			$(document).on("click",".followUser",function(event){
				var user = $(this).parent();
				$.post( "FollowUser", { id: $(this).parent().attr("id") }, function(event) { 
					$("#content").load("GetFollowedUsers");
					$("#lcolumn").load("GetNotFollowedUsers");
				});
				event.preventDefault();
			});
			/* UnFollow user */
			$(document).on("click",".unfollowUser",function(event) {
				var user = $(this).parent();
				$.post( "UnFollowUser", { id: $(this).parent().attr("id") }, function(event) {
					$("#content").load("GetFollowedUsers");
					$("#lcolumn").load("GetNotFollowedUsers");
				});
				event.preventDefault();
			});
		});
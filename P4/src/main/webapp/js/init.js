window.addEventListener('DOMContentLoaded', () => {
			$.ajaxSetup({ cache: false }); //Avoids Internet Explorer caching!	
			
			$(document).on("click",".menu",function(event) {
				$('#content').load($(this).attr('id'));
				event.preventDefault();
			});
			$(document).on("click",".timeline-menu",function(event) {
				$('#mcolumn').load($(this).attr('id'));
				event.preventDefault();
			});
			$(document).on("submit","form", function(event) {
				//$('#content').load($(this).attr('action'),$(this).serialize());
			    event.preventDefault();
			});
			/* Add tweet */
			$(document).on("click","#post-button",function(event){
				$.post( "AddTweet", { content: $("#typing-input").val()}, function(event) {
					$('#tweet-list').load("GetCustomTweets");
				});
				event.preventDefault();
			});
			/* Delete tweet */
			$(document).on("click",".delTweet",function(event){
				var tweet = $(this).parent();
				$.post( "DelTweet", { id: $(this).parent().attr("id") } , function(event) {
					$("#content").load("GetCustomTimeline");				
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
			/* Load profile */
			$(document).on("click",".who-to-follow-user", function(event){
				$("#mcolumn").load("GetProfileInfo/"+$(this).attr("data-userid"));
				event.preventDefault();
			});
			/* Load profile on tweet avatar click */
			$(document).on("click",".tweet-avatar", (event) => {
				$("#mcolumn").load("GetProfileInfo/"+event.target.parentElement.parentElement.getAttribute("data-posterid"));
				event.preventDefault();
			});
			/* Load profile on tweet content header click */
			$(document).on("click",".tweet-content-header", (event) => {
				$("#mcolumn").load("GetProfileInfo/"+event.target.closest(".tweet").getAttribute("data-posterid"));
				event.preventDefault();
			});
			// Follow user from who-to-follow
			$(document).on("click",".follow-button", (event) => {
				$.post( "FollowUser/" + event.target.parentElement.getAttribute("data-userid"), {}, () => {
					let who_to_follow_tab = document.getElementById("who-to-follow");
					let children = who_to_follow_tab.getElementsByClassName("who-to-follow-user");
					if(children.length > 1){
						who_to_follow_tab.removeChild(children[children.length -1]);
						setBottomWhoToFollowUserToRoundBorders();
					}
					else{
						$("#who-to-follow").load("GetWhoToFollow");
					}
				});
				event.stopPropagation();
				event.preventDefault();
			});
			// Follow user from profile
			$(document).on("click",".profile-follow-button", (event) => {
				$.post( "FollowUser/" + event.target.closest(".profile-wrapper").getAttribute("data-profileid"), {}, () => {
					// delete follow button and make unfollow button
					let new_button = document.createElement('button');
					new_button.classList.add("profile-unfollow-button");
					new_button.innerText = "Unfollow";
					$(event.target).fadeOut();
					event.target.parentElement.appendChild(new_button);
					event.target.parentElement.removeChild(event.target);
					$(new_button).fadeIn();
					event.preventDefault();
					
					//fake increase in follower count
					let profile_stats = document.getElementsByClassName("profile-stats")[0];
					let follower_count = profile_stats.querySelector(".follower-count span").innerText;
					profile_stats.querySelector(".follower-count span").innerText = ++follower_count
					
				});
			});
			// Unfollow user from profile
			$(document).on("click",".profile-unfollow-button", (event) => {
				$.post( "UnfollowUser/" + event.target.closest(".profile-wrapper").getAttribute("data-profileid"), {}, () => {
					// delete unfollow button and make follow button
					let new_button = document.createElement('button');
					new_button.classList.add("profile-follow-button");
					new_button.innerText = "Follow";
					$(event.target).fadeOut();
					event.target.parentElement.appendChild(new_button);
					event.target.parentElement.removeChild(event.target);
					$(new_button).fadeIn();
					event.preventDefault();
					
					//fake decrease in follower count
					let profile_stats = document.getElementsByClassName("profile-stats")[0];
					let follower_count = profile_stats.querySelector(".follower-count span").innerText;
					profile_stats.querySelector(".follower-count span").innerText = --follower_count
				});
			});
});

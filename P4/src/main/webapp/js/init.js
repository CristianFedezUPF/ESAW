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
				let that = event;
				$.post( "AddTweet", { content: $("#typing-input").val()}, (e) => {
					$('#tweet-list').load(that.target.getAttribute("data-controller"));
					document.getElementById("typing-input").value = "";
				});
				event.preventDefault();
			});
			/* Delete tweet */
			$(document).on("click",".tweet-delete-button",function(event){
				let tweet = event.target.closest(".tweet")
				$.post( "DelTweet", { id: tweet.getAttribute("data-tweetid") } , function(e) {
					tweet.parentElement.removeChild(tweet);
				});
				event.preventDefault();
			});
			// Edit tweet
			$(document).on("click",".tweet-edit-button", function(event){
				let tweet_content_wrapper = event.target.closest(".tweet-content-wrapper");				
				// replace <p> with <textarea> and make it resizable with content
				let p_element = tweet_content_wrapper.querySelector(".tweet-content");
				p_element.style.display = "none";
				let text_area = document.createElement('textarea');
				text_area.value = p_element.innerText;
				p_element.parentElement.appendChild(text_area);
				p_element.parentElement.removeChild(p_element)
				text_area.classList.add("tweet-edit-textarea");
				text_area.setAttribute("rows", "1");
				text_area.setAttribute("style", "height:" + (text_area.scrollHeight) + "px;overflow-y:hidden;");
					text_area.addEventListener("input", function(){
						this.style.height = "0px";
  						this.style.height = (this.scrollHeight) + "px";
					}, false);	
				// replace edit button with confirm button
				let tweet_buttons = tweet_content_wrapper.
					querySelector(".tweet-content-header-wrapper").
					querySelector(".tweet-buttons");
				let edit_button = tweet_buttons.querySelector(".fa-edit");
				edit_button.parentElement.removeChild(edit_button);
				let confirm_button = document.createElement('i');
				confirm_button.classList.add("tweet-confirm-edit-button", "tweet-icon", "fa", "fa-check");	
				tweet_buttons.querySelector(".fa-trash").before(confirm_button);
				event.preventDefault();
			});
			// Confirm edit tweet
			$(document).on("click",".tweet-confirm-edit-button", function(event){
				let tweet = event.target.closest(".tweet");
				let tweet_content_wrapper = event.target.closest(".tweet-content-wrapper");
				let text_area = tweet_content_wrapper.querySelector("textarea");
				let content = text_area.value;
				$.post("EditTweet", 
					{ 
						id: tweet.getAttribute("data-tweetid"),
						userId: tweet.getAttribute("data-posterid"),
						content: content
					},
					(e) => {
						// replace textarea by p
						tweet_content_wrapper.removeChild(text_area);
						let p_element = document.createElement('p');
						p_element.classList.add("tweet-content");
						p_element.innerText = content;
						tweet_content_wrapper.appendChild(p_element)
						// replace confirm button with edit button
						let tweet_buttons = tweet_content_wrapper.
							querySelector(".tweet-content-header-wrapper").
							querySelector(".tweet-buttons");
						let confirm_button = tweet_buttons.querySelector(".fa-check");
						confirm_button.parentElement.removeChild(confirm_button);
						let edit_button = document.createElement('i');
						edit_button.classList.add("tweet-edit-button", "tweet-icon", "fa", "fa-edit");	
						tweet_buttons.querySelector(".fa-trash").before(edit_button);
						// fake 'edited now'
						let tweet_content_header = tweet_content_wrapper.
							querySelector(".tweet-content-header-wrapper").
							querySelector(".tweet-content-header");
						if (tweet_content_header.querySelector(".tweet-edit-datetime") != null){	
							tweet_content_header.removeChild(tweet_content_header.querySelector(".tweet-edit-datetime"));
						}
						else{
							let separator = document.createElement('p');
							separator.classList.add("tweet-edit-datetime-separator");
							separator.innerText = "·";
							tweet_content_header.appendChild(separator);
						}
						let time_since = document.createElement('p');
						time_since.classList.add("tweet-edit-datetime");
						time_since.innerText = "Edited now";	
						tweet_content_header.appendChild(time_since);
					}
				);
				event.preventDefault();
			});
			/* Load profile */
			$(document).on("click",".who-to-follow-user", function(event){
				$("#mcolumn").load("GetProfileInfo/"+$(this).attr("data-userid"));
				event.preventDefault();
			});
			/* Load profile on following page */
			$(document).on("click",".followed-user", function(event){
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
						who_to_follow_tab.removeChild(event.target.parentElement);
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

window.addEventListener('DOMContentLoaded', () => {
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
					let current_column = document.getElementById("mcolumn").firstElementChild;
					// if we are in followed users, reload to reflect changes
					if(current_column.id == "followed-users-title"){
						$("#mcolumn").load("GetFollowedUsers");
					}
					// if we are in own profile, fake +1 to following
					else if(current_column.classList.contains("profile-wrapper")){
						let profile_id = current_column.getAttribute('data-profile-id');
						let user_id = document.getElementsByClassName("user-profile-wrapper")[0].getAttribute('data-user-id');
						if (user_id === profile_id){
							let following_count = document.getElementsByClassName("following-count")[0].querySelector("span");
							following_count.innerText = parseInt(following_count.innerText) + 1;
						}
					}
				});
				event.stopPropagation();
				event.preventDefault();
			});
			// Unfollow user from followers
			$(document).on("click",".unfollow-button", (event) => {
				let followed_user = event.target.closest(".followed-user")
				$.post( "UnfollowUser/" + followed_user.getAttribute("data-userid"), {}, () => {
					followed_user.parentElement.removeChild(followed_user);
					setLeftColumnRightBorder();
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
				event.preventDefault();
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
				event.preventDefault();
			});
});
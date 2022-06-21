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
				text_area.setAttribute("data-previouscontent", text_area.value)
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
				let previous_content = text_area.getAttribute("data-previouscontent")
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
			// Edit profile
			$(document).on("click","#profile-edit",function(){
				replaceProfileContentByTextArea();	
				let edit_button = document.getElementById("profile-edit");
				let parent = edit_button.parentElement;
				parent.removeChild(edit_button);
				let confirm_button = document.createElement('i');
				confirm_button.id = "profile-edit-confirm"
				confirm_button.classList.add("profile-button", "fa", "fa-check");
				confirm_button.style.color = "#888";	
				parent.insertBefore(confirm_button, parent.firstChild);
				event.preventDefault();
			});
			// Confirm edit profile
			$(document).on("click","#profile-edit-confirm",function(event){
				let profile_info = document.getElementsByClassName("profile-info")[0];
				let profile_text_wrapper = profile_info.querySelector(".profile-text-wrapper");
				let text_areas = profile_info.querySelectorAll("textarea");
				let selects = profile_info.querySelectorAll("select");
  				// front validation
  				let name, username, country, university, position, degree; 
  				for(let text_area of text_areas){
					let value = text_area.value;
					switch(text_area.id){
						case "profile-edit-name":
							if(value === "") return;
							name = value;
							break;
						case "profile-edit-username":
							if(value === "" || value.length < 4 || value.length > 15 || !validateUsername(value)) return;
							username = value
							break;
						case "profile-edit-degree":
							if(value === ""){
								value = null;
							}
							else if(!validateDegree(value)){
								return;
							}
							degree = value;
							break;
					}
				}
				for(let select of selects){
					let value = select.value;
					switch(select.id){
						case "profile-country":
							country = value;
							break;
						case "profile-university":
							university = value;
							break;
						case "profile-position":
							position = value;		
					}
				}
				let profile_id = parseInt(event.target.closest(".profile-wrapper").getAttribute('data-profileid'));
				$.post("EditProfile", 
					{ 
						id: profile_id,
						name: name,
						username: username,
						country: country,
						university: university,
						position: position,
						degree: degree
					},
					() => {
						$("#mcolumn").load("GetProfileInfo/" + profile_id);
					}
				);
				event.preventDefault();
			});
});

function replaceProfileContentByTextArea(){
	let profile_info = document.getElementsByClassName("profile-info")[0];
	
	let p_element = profile_info.querySelector(".profile-name")
	let font_size = window.getComputedStyle(p_element).fontSize;
	p_element.style.display = "none";
	let text_area = document.createElement('textarea');
	text_area.value = p_element.innerText.trim();
	p_element.before(text_area);
	text_area.style.fontSize = font_size;
	p_element.parentElement.removeChild(p_element)
	text_area.id = "profile-edit-name"
	text_area.classList.add("profile-edit-textarea");
	text_area.setAttribute("rows", "1");
	text_area.setAttribute("style", "border-top-left-radius: 6px; border-top-right-radius: 6px;" + 
	"font-size: " + font_size + "; height:" + (text_area.scrollHeight) + "px;overflow-y:hidden;");
	text_area.addEventListener("input", function(){
		this.style.height = "0px";
  		this.style.height = (this.scrollHeight) + "px";
	}, false);	
	
	p_element = profile_info.querySelector(".profile-username")
	font_size = window.getComputedStyle(p_element).fontSize;
	p_element.style.display = "none";
	text_area = document.createElement('textarea');
	text_area.value = p_element.innerText.trim().substring(1);
	p_element.before(text_area);
	text_area.style.fontSize = font_size;
	p_element.parentElement.removeChild(p_element)
	text_area.id = "profile-edit-username"
	text_area.classList.add("profile-edit-textarea");
	text_area.setAttribute("rows", "1");
	text_area.setAttribute("style", "font-weight: bold; line-height: 1;font-size: " + font_size + "; height:" + (text_area.scrollHeight) + "px;overflow-y:hidden;");
	
	let profile_text = document.getElementsByClassName("profile-text");
	
	p_element = profile_text[3];
	font_size = window.getComputedStyle(p_element).fontSize;
	p_element.style.display = "none";
	text_area = document.createElement('textarea');
	text_area.value = p_element.innerText.trim();
	p_element.before(text_area);
	text_area.style.fontSize = font_size;
	p_element.parentElement.removeChild(p_element);
	text_area.id = "profile-edit-degree"
	text_area.classList.add("profile-edit-textarea");
	text_area.setAttribute("rows", "1");
	text_area.setAttribute("style", "font-size: " + font_size + "; height:" + (text_area.scrollHeight) + "px;overflow-y:hidden;");
	text_area.addEventListener("input", function(){
		this.style.height = "0px";
  		this.style.height = (this.scrollHeight) + "px";
	}, false);	
	
	let profile_text_wrapper = profile_info.querySelector(".profile-text-wrapper");
	p_element = profile_text[2];
	let content = p_element.innerText;
	p_element.parentElement.removeChild(p_element);
	let select_element = document.createElement("select");
	select_element.setAttribute('name', 'profile-position');
	select_element.setAttribute('id', 'profile-position');
	select_element.classList.add('profile-edit-select')
	let student_option = document.createElement("option");
	student_option.setAttribute('value', 'S');
	student_option.innerText = "Student";
	let teacher_option = document.createElement("option");
	teacher_option.setAttribute('value', 'T');
	teacher_option.innerText = "Teacher";
	select_element.appendChild(student_option);
	select_element.appendChild(teacher_option);
	profile_text_wrapper.appendChild(select_element)
	
	p_element = profile_text[1];
	content = p_element.innerText;
	p_element.parentElement.removeChild(p_element);
	select_element = document.createElement("select");
	select_element.setAttribute('name', 'profile-university');
	select_element.setAttribute('id', 'profile-university');
	select_element.classList.add('profile-edit-select')
	profile_text_wrapper.insertBefore(select_element, profile_text_wrapper.firstElementChild);
	$(select_element).load('GetUniversities');

	p_element = profile_text[0];
	content = p_element.innerText;
	p_element.parentElement.removeChild(p_element);
	select_element = document.createElement("select");
	select_element.setAttribute('name', 'profile-country');
	select_element.setAttribute('id', 'profile-country');
	select_element.classList.add('profile-edit-select')
	profile_info.insertBefore(select_element, profile_info.querySelector(".profile-text-wrapper"));
	$(select_element).load('GetCountries');
	
	profile_info.style.backgroundColor = "#131c2a";

}



window.addEventListener('DOMContentLoaded', () => {
			/* Add tweet */
			$(document).on("click","#post-button",function(event){
				let that = event;
				$.post( "AddTweet", { content: $("#typing-input").val()}, () => {
					$('#tweet-list').load(that.target.getAttribute("data-controller"));
					document.getElementById("typing-input").value = "";
				});
				event.preventDefault();
			});
			/* Delete tweet */
			$(document).on("click",".tweet-delete-button",function(event){
				let tweet = event.target.closest(".tweet")
				$.post( "DelTweet", 
					{ 
						id: tweet.getAttribute("data-tweetid"),
						userId: tweet.getAttribute("data-posterid")
					},
					() => {
						tweet.parentElement.removeChild(tweet);
					});
				event.preventDefault();
			});
			// Edit tweet
			$(document).on("click",".tweet-edit-button", function(event){
				replaceTweetByTextarea(event);
			});
			// Confirm edit tweet
			$(document).on("click",".tweet-confirm-edit-button", function(event){
				confirmTweetEdit(event);
			});
						// Add like tweet
			$(document).on("click",".tweet-like", function(event){
				let tweet_option_wrapper = event.currentTarget;
				let tweet = tweet_option_wrapper.closest(".tweet");
				$.post("AddLike", 
					{ 
						id: tweet.getAttribute("data-tweetid"),
					},
					() => {
						let p = tweet_option_wrapper.querySelector("p");
						let like_number = parseInt(p.innerText);
						p.innerText = ++like_number;
						tweet_option_wrapper.classList.remove("tweet-like");
						tweet_option_wrapper.classList.add("tweet-dislike");
					} 
				);
			});
			// Remove like tweet
			$(document).on("click",".tweet-dislike", function(event){
				let tweet_option_wrapper = event.currentTarget;
				let tweet = tweet_option_wrapper.closest(".tweet");
				$.post("RemoveLike", 
					{ 
						id: tweet.getAttribute("data-tweetid"),
					},
					() => {
						let p = tweet_option_wrapper.querySelector("p");
						let like_number = parseInt(p.innerText);
						p.innerText = --like_number;
						tweet_option_wrapper.classList.remove("tweet-dislike");
						tweet_option_wrapper.classList.add("tweet-like");
					} 
				);
			});
			// Add retweet
			$(document).on("click",".tweet-retweet", function(event){
				let tweet_option_wrapper = event.currentTarget;
				let tweet = tweet_option_wrapper.closest(".tweet");
				$.post("AddRetweet", 
					{ 
						id: tweet.getAttribute("data-tweetid"),
					},
					() => {
						let p = tweet_option_wrapper.querySelector("p");
						let retweet_number = parseInt(p.innerText);
						p.innerText = ++retweet_number;
						tweet_option_wrapper.classList.remove("tweet-retweet");
						tweet_option_wrapper.classList.add("tweet-remove-retweet");
					} 
				);
			});
			// Remove retweet
			$(document).on("click",".tweet-remove-retweet", function(event){
				let tweet_option_wrapper = event.currentTarget;
				let tweet = tweet_option_wrapper.closest(".tweet");
				$.post("RemoveRetweet", 
					{ 
						id: tweet.getAttribute("data-tweetid"),
					},
					() => {
						let p = tweet_option_wrapper.querySelector("p");
						let retweet_number = parseInt(p.innerText);
						p.innerText = --retweet_number;
						tweet_option_wrapper.classList.remove("tweet-remove-retweet");
						tweet_option_wrapper.classList.add("tweet-retweet");
					} 
				);
			});
});

function replaceTweetByTextarea(event){
	let tweet_content_wrapper = event.target.closest(".tweet-content-wrapper");				
	// replace <p> with <textarea> and make it resizable with content
	let p_element = tweet_content_wrapper.querySelector(".tweet-content");
	p_element.style.display = "none";
	let text_area = document.createElement('textarea');
	text_area.value = p_element.innerText;
	p_element.parentElement.querySelector(".tweet-options").before(text_area);
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
}

function confirmTweetEdit(event){
	let tweet = event.target.closest(".tweet");
	let tweet_content_wrapper = event.target.closest(".tweet-content-wrapper");
	let text_area = tweet_content_wrapper.querySelector("textarea");
	let content = text_area.value;
	if(content.trim() === "") return;
	$.post("EditTweet", 
		{ 
			id: tweet.getAttribute("data-tweetid"),
			userId: tweet.getAttribute("data-posterid"),
			content: content
		},
		() => {
			// replace textarea by p
			tweet_content_wrapper.removeChild(text_area);
			let p_element = document.createElement('p');
			p_element.classList.add("tweet-content");
			p_element.innerText = content;
			tweet_content_wrapper.querySelector(".tweet-options").before(p_element)
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
}
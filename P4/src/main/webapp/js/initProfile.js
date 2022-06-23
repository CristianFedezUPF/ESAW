window.addEventListener('DOMContentLoaded', () => {
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
				$("#mcolumn").load("GetProfileInfo/"+event.target.closest(".tweet").getAttribute("data-posterid"));
				event.preventDefault();
			});
			// Load profile on retweet info click
			$(document).on("click",".retweet-info", (event) => {
				$("#mcolumn").load("GetProfileInfo/"+event.target.closest(".retweet-info-wrapper").getAttribute("data-retweetuserid"));
				event.preventDefault();
			});
			/* Load profile on tweet content header click */
			$(document).on("click",".tweet-content-header", (event) => {
				$("#mcolumn").load("GetProfileInfo/"+event.target.closest(".tweet").getAttribute("data-posterid"));
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
				let text_areas = profile_info.querySelectorAll("textarea");
				let selects = profile_info.querySelectorAll("select");
  				// front validation
  				let validation = validateProfileEdit(text_areas, selects);
				let profile_id = parseInt(event.target.closest(".profile-wrapper").getAttribute('data-profileid'));
				$.post("EditProfile", 
					{ 
						id: profile_id,
						name: validation.name,
						username: validation.username,
						country: validation.country,
						university: validation.university,
						position: validation.position,
						degree: validation.degree
					},
					() => {
						$("#mcolumn").load("GetProfileInfo/" + profile_id);
						document.getElementById("user-profile-name").innerText = validation.name;
						document.getElementById("user-profile-username").innerText = validation.username;
					}
				).fail( (error) => {
					let message;
					switch(error.status){
						case 400:
							message = "Invalid request";
							break;
						case 409:
							message = "Username already in use";
							break;
						case 500:
							message = "There was an unexpected error with your request";
							break;
					}
					showProfileEditError(message);
				});
				event.preventDefault();
			});
			// Delete user
			$(document).on("click","#profile-ban", function(event){
				let profile_id = parseInt(event.target.closest(".profile-wrapper").getAttribute('data-profileid'));
				$.post("DelProfile", 
					{ 
						id: profile_id,
					},
					() => {
						$('#mcolumn').load('GetCustomTimeline');
					}
				);
				event.preventDefault();
			});
});

// Replaces profile info by text_areas so that the user can modify it.
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
	text_area.setAttribute("maxlength", "60");
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
	text_area.setAttribute("maxlength", "15");
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
	text_area.id = "profile-edit-degree";
	text_area.setAttribute('placeholder', "Enter your degree here...")
	text_area.classList.add("profile-edit-textarea");
	text_area.setAttribute("maxlength", "255");
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
	if(content == "Student"){
		student_option.setAttribute('selected','selected')
	} else {
		teacher_option.setAttribute('selected','selected')
	}
	select_element.appendChild(student_option);
	select_element.appendChild(teacher_option);
	profile_text_wrapper.appendChild(select_element)
	
	p_element_university = profile_text[1];
	university = p_element_university.innerText;
	p_element_university.parentElement.removeChild(p_element_university);
	select_element_university = document.createElement("select");
	select_element_university.setAttribute('name', 'profile-university');
	select_element_university.setAttribute('id', 'profile-university');
	select_element_university.classList.add('profile-edit-select')
	profile_text_wrapper.insertBefore(select_element_university, profile_text_wrapper.firstElementChild);
	$(select_element_university).load('GetUniversities', () => {
		for(var i, j = 0; i = select_element_university.options[j]; j++) {
		    if(i.value == university) {
		        select_element_university.selectedIndex = j;
		        break;
		    }
		}
	});

	p_element = profile_text[0];
	content = p_element.innerText;
	p_element.parentElement.removeChild(p_element);
	select_element = document.createElement("select");
	select_element.setAttribute('name', 'profile-country');
	select_element.setAttribute('id', 'profile-country');
	select_element.classList.add('profile-edit-select')
	profile_info.insertBefore(select_element, profile_info.querySelector(".profile-text-wrapper"));
	$(select_element).load('GetCountries', () => {
		for(var i, j = 0; i = select_element.options[j]; j++) {
		    if(i.value == content) {
		        select_element.selectedIndex = j;
		        break;
		    }
		}
	});
	profile_info.style.backgroundColor = "#131c2a";
}

function validateProfileEdit(text_areas, selects){
	output = {}
	for(let text_area of text_areas){
		let value = text_area.value;
		switch(text_area.id){
			case "profile-edit-name":
				if(value === ""){
					showProfileEditError("Please input a name.");
					throw "Error";
				};
				output.name = value;
				break;
			case "profile-edit-username":
				if(value === "" || value.length < 4){
					showProfileEditError("Username too short.");
					throw "Error";
				}
				if(value.length > 15){
					showProfileEditError("Username too long.");
					throw "Error";
				}
				if(!validateUsername(value)){
					showProfileEditError("Username format invalid.");
					throw "Error";	
				}
				output.username = value
				break;
			case "profile-edit-degree":
				if(value === ""){
					value = null;
				}
				else if(!validateDegree(value)){
					showProfileEditError("Degree format invalid.");
					throw "Error";	
				}
				output.degree = value;
				break;
		}
	}
	for(let select of selects){
		let value = select.value;
		switch(select.id){
			case "profile-country":
				output.country = value;
				break;
			case "profile-university":
				output.university = value;
				break;
			case "profile-position":
				output.position = value;		
		}
	}
	return output;
}

function showProfileEditError(message){
	let profile_info = document.getElementsByClassName("profile-info")[0];
	let error = profile_info.querySelector('.profile-edit-error');
	if (error != null){
		error.innerText = message;
		return;
	};
	error = document.createElement("p");
	error.innerText = message;
	error.classList.add("profile-edit-error");
	profile_info.appendChild(error);
}



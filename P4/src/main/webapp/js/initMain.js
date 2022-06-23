window.addEventListener('DOMContentLoaded', () => {
			$.ajaxSetup({ cache: false }); //Avoids Internet Explorer caching!	
			
			$(document).on("click",".menu",function(event) {
				$('#content').load($(this).attr('id'));
				event.preventDefault();
			});
			$(document).on("click",".logout",function(event) {
				$('#content').load($(this).attr('id'), () => {
					$('#navigation').load('MenuController')	
				});				
				event.preventDefault();
			});
			$(document).on("click",".timeline-menu",function(event) {
				$('#mcolumn').load($(this).attr('id'));
				let menu_items = document.getElementsByClassName("lcolumn-menu-item");
				// reset previous bold element
				for(let element of menu_items){
					element.style.fontWeight = "";
				}
				if(event.currentTarget.classList.contains("user-profile-wrapper")){
					menu_items[3].style.fontWeight = "900";
					return;
				}
				event.currentTarget.style.fontWeight = "900";
				event.preventDefault();
			});
			$(document).on("submit","form", function(event) {
				//$('#content').load($(this).attr('action'),$(this).serialize());
			    event.preventDefault();
			});
});
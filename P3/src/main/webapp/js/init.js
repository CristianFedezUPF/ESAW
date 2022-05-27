window.addEventListener('DOMContentLoaded', () => {
	$.ajaxSetup({ cache: false }); //Avoids Internet Explorer caching!	
	var menuItems = document.getElementsByClassName("menu");
	var content = document.getElementById("content");
	for(const item of menuItems){
		item.addEventListener("click", async (event) => {
			const response = await fetch(item.id);
			content.innerHTML = await response.text();
			event.preventDefault();
		});
	}
});
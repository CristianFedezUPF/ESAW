<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

 <script type="text/javascript">
 $(document).ready(function(){
	$('#navigation').load('MenuController');
	$('#tweet-list').load('GetGlobalTweets');
 });
</script>

<div id="grid-layout">
	<div id="lcolumn">
		<div id="lcolumn-menu">
			<p id="logo">Unitter</p>
			<p id="GetAnonymousTimeline" class="menu lcolumn-menu-item">Explore</p>
		</div>
		
	</div>
	<div id="mcolumn">
		<div id="tweet-list">
		</div>
	</div>
	<div id="rcolumn">
		
	</div>
</div>
 


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

 <script type="text/javascript">
 $(document).ready(function(){
	$('#navigation').load('MenuController');

 });
</script>

<div id="grid-layout">
	<div id="lcolumn">
		<p>test1</p>
	</div>
	<div id="mcolumn">
		<div id="input-wrapper">
			<textarea id="typing-input" placeholder="What's happening?"></textarea>
			<button>Post</button>
		</div>
	</div>
	<div id="rcolumn">
		<p>test3</p>
	</div>
</div>
 



<!DOCTYPE html>
<html>

<head>
<title>Horse Race</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="http://use.edgefonts.net/alexa-std.js"></script>
<script language="javascript">

function messageHandler(msg) {

	if(msg.type == "subscribe" && msg.code == -1) {
		alert("I'm sorry, but that name is taken.");
	}

	if(msg.type == "response" && msg.reqType == "subscribe") {
		$("#stepone").hide();
		$("#steptwo").show();

	}

	if(msg.type == "data") {
			console.dir(msg);

		if(msg.data.type === "game" && msg.data.code === 1) {
			$("#steptwo").html("<p>Race Started!!!!<br/><button id='kick'>Hit Me!</button>");

			$("#kick").on("touchstart click", function() {
				console.log("fire");
				myWS.publish("player","gallup");
			});

			$(window).keypress(function(e) {
				e.preventDefault();
				if(e.which === 32) {
					console.log("fire");
					myWS.publish("player","gallup");
				}
			});

		}
		if(msg.data.type === "game" && msg.data.code === 2 && msg.data.winner) {
			$("#steptwo").html("<p>Race Ended!<br/>THE WINNER IS "+msg.data.winner+"!</p>");
			$(window).unbind("keypress");
			$("#kick").die("touchstart click");
		}


	}


}

$(document).ready(function() {

	//Handle message send test
	$("#signinButton").on("click", function() {
		var name =$("#name").val();
		if(name.length) {
			myWS.subscribe("player", 
						{
								username:name
						})
		}
	});

});

</script>
<style>
h1 {
	font-family: alexa-std, serif;
	font-size: 3em;	
}
p {
	font-family: alexa-std, serif;
	font-size: 2em;
}
button,input {
	padding: 10px;
}
</style>
</head>

<body >

<h1>Horse Race Demo</h1>

<div id="stepone">
	<input type="text" id="name" placeholder="Your Name:">
	<button id="signinButton">Join Race!</button>

</div>

<div id="steptwo" style="display:none">
	<p>
		Stand By - the race is about to start!
	</p>
</div>

</body>
</html>

<cfwebsocket name="myWS" onMessage="messageHandler">
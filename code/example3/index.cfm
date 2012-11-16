<!DOCTYPE html>
<html>

<head>
<title>Example Three</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script language="javascript">
function messageHandler(msg) {
	console.log("messageHandler Run");
	console.dir(msg);


	if(msg.type == "subscribe" && msg.code == -1) {
		alert("I'm sorry, but you were not able to subscribe.");
	}

	if(msg.type == "response" && msg.reqType == "subscribe") {
		$("#stepone").hide();
		$("#chattest").show();
		$("#messageButton").on("click", function () {
			var msg = $("#message").val();
			if(msg == '') return;
			myWS.publish("news",msg);
		})
	}

	if(msg.type == "data") {
		$("#messageResponseArea").append(msg.data + "<br/>");	
	}
}

$(document).ready(function() {

	//Handle message send test
	$("#signinButton").on("click", function() {
		var name =$("#name").val();
		if(name.length) {
			myWS.subscribe("news", 
						{
								username:name
						})
		}
	});

});

</script>
</head>

<body >

<h1>Example Three</h1>

<div id="stepone">
	Tell us your name please: 
	<input type="text" id="name"> <button id="signinButton">Sign In</button>

</div>

<div id="chattest" style="display:none">
	<p>
	<input type="text" id="message"> <button id="messageButton">Send Message</button>
	<div id="messageResponseArea"></div>
	</p>
</div>

<cfwebsocket name="myWS" onMessage="messageHandler">
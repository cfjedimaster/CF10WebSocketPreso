<!DOCTYPE html>
<html>

<head>
<title>Example Two</title>
<script language="javascript">

function errorHandler(e) {
	console.log("Error");
	console.dir(e);
	alert(e.msg);
}

function messageHandler(msg) {
	console.log("messageHandler Run");
	console.dir(msg);

	if(msg.reqType == "getSubscriberCount") {
		document.querySelector("#subscriberCount").innerHTML = "There are "+msg.subscriberCount + " subscriber(s).";
	}

	if(msg.type == "data") {
		document.querySelector("#messageResponseArea").innerHTML += msg.data + "<br/>";	
	}
}

function init() {

	//Handle the request to get subscriber count
	document.querySelector("#subscriberButton").addEventListener("click", function() {
		myWS.getSubscriberCount("news");
	},false);

	//Handle message send test
	document.querySelector("#messageButton").addEventListener("click", function() {
		var text = document.querySelector("#message").value;
		myWS.publish("news", text);
	},false);

}

</script>
</head>

<body onload="init()">

<h1>Example Two</h1>

<p>
<input type="text" id="message"> <button id="messageButton">Send Message</button>
<div id="messageResponseArea"></div>
</p>

<p>
<button id="subscriberButton">Get Subscriber Count</button>
<div id="subscriberCount"></div>
</p>

</body>
</html>

<cfwebsocket name="myWS" onMessage="messageHandler" subscribeTo="news" onError="errorHandler">
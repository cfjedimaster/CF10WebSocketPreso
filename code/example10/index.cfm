<!DOCTYPE html>
<html>
<head>
<title>Example 10</title>
<script>
var respDiv;

function messageHandler(msg) {
	console.dir(msg);

	if(msg.reqType == "invoke" && msg.type == "response") {
		respDiv.innerHTML += msg.data + "<br/>";
	}

	if(msg.type == "data") {
		respDiv.innerHTML += "The computer said: <b>" + msg.data + "</b><br/>";
	}
}

function init() {
	respDiv = document.querySelector("#response");

	document.querySelector("#testButton").addEventListener("click", function(e) {
		var input = document.querySelector("#input").value;

		myWS.invoke("root.responder", "testResponse", [input]);

		return false;
	});

}

</script>
<style>
#response {
	font-size: 12px;
	background-color: yellow;
	width: 50%;
	padding: 10px;
}
</style>
</head>

<body onload="init()">

	<input type="text" id="input" placeholder="Enter Something">
	<button id="testButton">Test</button>

	<p/>

	<div id="response"></div>

</body>
</html>

<cfwebsocket name="myWS" onMessage="messageHandler">
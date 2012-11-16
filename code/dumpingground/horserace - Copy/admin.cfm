<!--- Admin --->
<!DOCTYPE html>
<html>

<head>
<title>Horse Race</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="http://use.edgefonts.net/alexa-std.js"></script>
<script language="javascript">
var names = [];
var gameSize = 0;
var gameOn = false;

function messageHandler(msg) {
	console.log("messageHandler Run");
	console.dir(msg);

	if(msg.type == "data") {
		//console.log(msg.data);
		if(msg.data.type === "newplayer") {
			console.log("NEW PLAYER:",msg.data.name);
			addPlayer(msg.data.name);
		}
		if(msg.data.type === "removeplayer") {
			console.log("REM PLAYER:",msg.data.name);
			removePlayer(msg.data.name);
		}
		if(msg.data.type === "gallup") {
			console.log("MOV PLAYER:",msg.data.name);
			movePlayer(msg.data.name);
		}
	}
}

function addPlayer(n) {
	names.push(n);
	var s = '<div class="playerSlot" data-name="'+n+'">'+n+'</div>';
	$("#playerList").append(s);
}

function removePlayer(n) {
	name=names.splice(names.indexOf(n),1);
	$(".playerSlot[data-name='"+n+"']").remove();
}

function movePlayer(n) {
	if(!gameOn) return;
	var dom = $(".playerSlot[data-name='"+n+"']");
	var pos = $(dom).position();
	var amountMoved = 5 + Math.floor(Math.random() * 12);
	console.log("Adding "+amountMoved);
	var current = parseInt($(dom).css("left"));
	var newAmount = current+amountMoved;
	$(dom).css("left", newAmount+"px");
	console.log("left",newAmount,gameSize);
	if(newAmount >= gameSize) {
		winner(n);
	}
}

function winner(n) {
	if(!gameOn) return;
	gameOn = false;
	$("#startBtn").removeAttr("disabled");
	wsPublish("admin",{type:"winner",winner:n});
}

$(document).ready(function() {

	gameSize = $("#playerList").width();
	$("#startBtn").on("click", function() {
		gameOn = true;
		myWS.publish("admin", {type:"startRace"});
		$(this).attr("disabled","disabled");
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

#playerList {
	width:100%;
	background-color: lightgreen;
	min-height: 500px;
}

.playerSlot {
	position:relative;
	left:0px;
	background-image: url("horse.png");
	background-repeat: no-repeat;
	max-height: 100px;
	padding-top:45px;
	margin-bottom: 10px;
	width: 100px;
}

</style>
</head>

<body >

<h1>Horse Race Admin</h1>

<button id="startBtn">Start Race!</button>

<div id="playerList">
</div>

</body>
</html>

<cfwebsocket name="myWS" subscribeTo="admin" onMessage="messageHandler">
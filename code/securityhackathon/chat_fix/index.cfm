<cfwebsocket name="chatWS" subscribeTo="chat" 
			 onMessage="msgHandler">

<!DOCTYPE html>
<html>
<head>
    <title>Chat</title>
	<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />	
	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
	<script type="text/javascript" src="http://twitter.github.com/bootstrap/1.4.0/bootstrap-modal.js"></script>
	<script type="text/javascript">
	var username="";

	function msgHandler(message){
		//Only care about messages
		if (message.type == "data") {
			console.log("chat received: "+message.data.chat);
			if(message.data.type == "chat") $("#chatlog").append(message.data.username + " says: " + message.data.chat + "<br/>");
			else $("#chatlog").append(message.data.chat + "<br/>");
			$('#chatlog').scrollTop($('#chatlog')[0].scrollHeight);
		}
		
		if(message.type == "response" && message.reqType == "getSubscriberCount") {
			$("#userCount").text(message.subscriberCount);
		}
	}


	$(function() {
		
		$("#usernamemodal").modal({
			backdrop:"static",
			show:true
		});

		$("#usernamebutton").click(function() {
			var u = $.trim($("#username").val());
			if (u == "") {
				return;
			}
			username=u;
			msg = {
				type: status,
				username: username,
				chat: username+" joins the chat."
			};
			chatWS.publish("chat",msg);

			$("#usernamemodal").modal("hide");
			
			window.setInterval(function(){
				chatWS.getSubscriberCount("chat")
			},2000);

		});
		
		$("#sendmessagebutton").click(function() {
			var txt = $.trim($("#newmessage").val());
			if(txt == "") return;
			txt = txt.replace(/<.*?>/,"");
			msg = {
				type: "chat",
				username: username,
				chat: txt
			};
			chatWS.publish("chat",msg);
			$("#newmessage").val("");
		});

		$(document).keypress(function(e) {
		    if(e.keyCode == 13) {
				//if not logged in, fire that,else chat
				if(username=="") $("#usernamebutton").trigger("click"); 
				else $("#sendmessagebutton").trigger("click")
		    }
		});
		
	});	
	</script>
	<style>
	#chatlog {
		width: 100%;
		height: 300px;	
		border: solid black thin;
		overflow:auto;
	}
	#newmessage {
		width: 78%;
	}
	#sendmessage {
		width: 20%;
	}
	</style>
</head>
<body>

	<div class="container">

	<h2>Obligatory Chat Demo</h2>
	
	<!---<textarea id="chatlog"></textarea>--->
	<div id="chatlog"></div>
	<input type="text" id="newmessage">
	<input type="button" id="sendmessagebutton" value="Chat" class="btn primary">
	<p>Users Present: <span id="userCount"></span></p>
	</div>

	<div id="usernamemodal" class="modal hide fade">

		<div class="modal-header">
		<h3>Pick a Username</h3>
		</div>
		<div class="modal-body">
		<p>
		Enter a username:
		<input type="text" id="username" value="">
		</p>
		</div>
		<div class="modal-footer">
		<a href="#" id="usernamebutton" class="btn primary">Enter</a>
		</div>
			
	</div>
	
</body>
</html>
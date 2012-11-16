component extends="CFIDE.websocket.ChannelListener" {

   public boolean function allowSubscribe(struct subscriberInfo) {
   	   if(!structKeyExists(arguments.subscriberInfo, "userinfo")) return false;
   	   var attemptuser = arguments.subscriberInfo.userinfo.username;
   	   
   	   //lock me baby
   	   lock type="exclusive" scope="application" timeout=30 {

			var users = getUserList();
			if(arrayFind(users,attemptuser) != 0) return false;
			arrayAppend(users, attemptuser);
			
			var msg = {"type":"list","userlist":users};
			wspublish("chat",msg);

			return true;
	   }
   }

	public any function beforePublish(any message, Struct publisherInfo) {

		if(structKeyExists(message, "type") && message.type == "chat") {
	  		//gets the user list
	  	  	var users = getUserList();
	  	  	var myclientid = publisherInfo.connectioninfo.clientid;
		  	  	
	  	  	var me = users[arrayFind(wsGetSubscribers('chat'), function(i) {
	  	  		return (i.clientid == myclientid);
	  	  	})];
	  	  	
			message.chat=rereplace(message.chat, "<.*?>","","all");
	  	  	
	  	  	message["username"]=me;
	  	}
	  	
		return message;
	}

	public function afterUnsubscribe(Struct subscriberInfo) {
		var users = getUserList();			
		var msg = {"type":"list","userlist":users};
		wspublish("chat",msg);
	}
	
	public function getUserList() {
		var users = [];
		arrayEach(wsGetSubscribers('chat'), function(item) {
			arrayAppend(users, item.subscriberinfo.userinfo.username);
		});
		return users;
	}

}
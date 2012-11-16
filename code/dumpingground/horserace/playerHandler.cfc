component extends="CFIDE.websocket.ChannelListener" {

   public boolean function allowSubscribe(struct subscriberInfo) {
   	   writeLog(file="application", text="allowSubscribe: #serializeJSON(arguments.subscriberinfo)#");
   	   if(!structKeyExists(arguments.subscriberInfo,"username")) return false;

         var attemptuser = arguments.subscriberInfo.username;
         //lock me baby
         lock type="exclusive" timeout=30 {
	         //get all users 
	         var users = wsGetSubscribers('player');
	         res = arrayfind(users, function(item) {
	            return item.subscriberinfo.username eq attemptuser;
	         });
	         if(res) return false;
	         //broadcast to admin
	         wsPublish("admin", {"type":"newplayer", "name":attemptuser});
	         //store username
	         subscriberInfo.connectionInfo.username = arguments.subscriberInfo.username;
	         return true;
	      }
	}

	
	public any function beforePublish(any message, struct publisherInfo) {
		writeLog("beforePublish: #serializeJSON(arguments)#");
		if(isSimpleValue(message)) {
			//had weird scoping issue, so copied it out
			//Note - all of this crap is because publisherInfo doesnt return the original custom connection info
			//Note - I was wrong about the above - keeping code in for history sake
			if(message == "gallup") {
				wsPublish("admin", {"type":"gallup","name":publisherInfo.connectionInfo.username});
			}
			/*
			var myid = arguments.publisherInfo.connectioninfo.clientid;
			message = rereplace(message, "<.*?>","","all");
			if(message == "gallup") {
				var p = wsGetSubscribers("player");
				arrayEach(p, function(c) {
					writelog(c.subscriberinfo.connectioninfo.clientid & " versus " & myid);
					if(c.subscriberinfo.connectioninfo.clientid == myid) {
						wsPublish("admin", {"type":"gallup", "name":c.subscriberInfo.username});
						//leave right now
						return message;
					}
				});
			}
			*/

		}
		return message;
	}

/*
	public any function canSendMessage(any message, struct subscriberInfo, struct publisherInfo) {
   	   writeLog(file="application", text="canSendMessage: #serializeJSON(arguments)#");
   	   //optional filter
	   return true;
	}
*/
	public any function afterUnsubscribe(struct subscriberInfo) {
  	   writeLog("afterUnsubscribe: #serializeJSON(arguments)#");
  	   wsPublish("admin",{"type":"removeplayer","name":arguments.subscriberInfo.username});
		return true;
	}

}
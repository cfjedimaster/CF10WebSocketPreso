component extends="CFIDE.websocket.ChannelListener" {

   public boolean function allowSubscribe(struct subscriberInfo) {
   	   writeLog(file="application", text="allowSubscribe: #serializeJSON(arguments.subscriberinfo)#");
   	   if(!structKeyExists(arguments.subscriberInfo,"username")) return false;

   	   //Poor bob
   	   if(arguments.subscriberInfo.username == "bob") return false;
   	   return true;
   }

	public any function beforePublish(any message, struct subscriberInfo) {
   	   	writeLog(file="application", text="beforeSendMessage: #serializeJSON(arguments)#");
		message = rereplace(message, "<.*?>","","all");
		return message;
	}

	public any function canSendMessage(any message, struct subscriberInfo, struct publisherInfo) {
   	   	writeLog(file="application", text="canSendMessage: #serializeJSON(arguments)#");
		if(findNoCase("darn", arguments.message) && subscriberInfo.username == "mary") return false;   	   	
		return true;
	}

	public any function afterUnsubscribe(struct subscriberInfo) {
   	   writeLog(file="application", text="afterUnsubscribe: #serializeJSON(arguments)#");
   	    wsPublish("news", "#arguments.subscriberInfo.username# left the application.");
		return true;
	}

}
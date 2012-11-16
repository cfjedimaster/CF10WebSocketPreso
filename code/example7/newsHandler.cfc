component extends="CFIDE.websocket.ChannelListener" {

   public boolean function allowSubscribe(struct subscriberInfo) {
   	   
   	   //I am crucial. You must use me. Or else.
   	   if(!arguments.subscriberInfo.connectionInfo.authenticated) return false;

         //I'm an optional check just to be extra secure
   	   if(!structKeyExists(arguments.subscriberInfo,"username")) return false;

   	   return true;
   }

   public boolean function allowPublish(struct publisherInfo) {
      return arguments.publisherInfo.connectionInfo.authenticated;
   }

	public any function beforePublish(any message, struct subscriberInfo) {
  		message = rereplace(message, "<.*?>","","all");
  	  	return message;
	}

	public any function canSendMessage(any message, struct subscriberInfo, struct publisherInfo) {
  	   writeLog(file="application", text="canSendMessage: #serializeJSON(arguments)#");
		return true;
	}

	public any function afterUnsubscribe(struct subscriberInfo) {
   	   writeLog(file="application", text="afterUnsubscribe: #serializeJSON(arguments)#");
		return true;
	}

}
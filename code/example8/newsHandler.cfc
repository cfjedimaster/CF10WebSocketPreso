component extends="CFIDE.websocket.ChannelListener" {

   public boolean function allowSubscribe(struct subscriberInfo) {
   	   
   	   writeLog(file="application", text="allowSubscribe: #serializeJSON(arguments.subscriberinfo)#");
   	   
   	   //I am crucial. You must use me. Or else.
   	   if(!arguments.subscriberInfo.connectionInfo.authenticated) return false;

   	   return true;
   }

	public any function beforePublish(any message, struct subscriberInfo) {
  	   writeLog(file="application", text="beforeSendMessage: #serializeJSON(arguments)#");
		message = rereplace(message, "<.*?>","","all");
		return message;
	}

}
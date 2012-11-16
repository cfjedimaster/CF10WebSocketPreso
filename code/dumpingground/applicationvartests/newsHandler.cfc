component extends="CFIDE.websocket.ChannelListener" {

   public boolean function allowSubscribe(struct subscriberInfo) {
   	   writeLog(file="application", text="allowSubscribe: #serializeJSON(arguments.subscriberinfo)#");
   	   if(!structKeyExists(arguments.subscriberInfo,"username")) return false;

   	   //Poor bob
   	   if(arguments.subscriberInfo.username == "bob") return false;
   	   return true;
   }

	public any function beforePublish(any message, struct subscriberInfo) {
//   	   writeLog(file="application", text="beforeSendMessage: #serializeJSON(arguments)#");
		if(isSimpleValue(message)) {
            message = rereplace(message, "<.*?>","","all");
            message = "PRE(#application.applicationname#) " & message;
      }

		return message;
	}

	public any function canSendMessage(any message, struct subscriberInfo, struct publisherInfo) {
   	   writeLog(file="application", text="canSendMessage: #serializeJSON(arguments)#");
   	   //optional filter
   	   if(!isSimpleValue(message)) {
   	   		return (message.forclient == subscriberinfo.connectioninfo.clientid);
   	   		/*
   	   		if(message.forclient == subscriberinfo.connectioninfo.clientid) {
   	   			message = message.msg;
   	   			writelog(file="application", text="msg should be simple #serializejson(message)#");
   	   			return true;
   	   		} else return false;
   	   		*/
   	   }
	   return true;
	}

	public any function afterUnsubscribe(struct subscriberInfo) {
   	   writeLog(file="application", text="afterUnsubscribe: #serializeJSON(arguments)#");
		return true;
	}

}
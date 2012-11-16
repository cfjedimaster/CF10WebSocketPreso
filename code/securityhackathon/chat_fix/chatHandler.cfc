component extends="CFIDE.websocket.ChannelListener" {

	public any function beforePublish(any message, struct subscriberInfo) {
   	   	writeLog(file="application", text="beforeSendMessage: #serializeJSON(arguments)#");
		if(structKeyExists(message, "chat")) message.chat = rereplace(message.chat, "<.*?>","","all");
		return message;
	}
}
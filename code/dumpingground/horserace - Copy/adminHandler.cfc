component extends="CFIDE.websocket.ChannelListener" {

	public any function beforePublish(any message, struct subscriberInfo) {
		writeLog("ADMIN beforeSendMessage: #serializeJSON(arguments)#");

		if(message.type == "startRace") {
			wsPublish("player", {"type":"game","code":1});
		}

		if(message.type == "winner") {
			wsPublish("player", {"type":"game","winner":message.winner});
		}

		/*
		if(isSimpleValue(message)) message = rereplace(message, "<.*?>","","all");
		*/
		return message;

	}

}
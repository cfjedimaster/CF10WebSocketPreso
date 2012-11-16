component extends="CFIDE.websocket.ChannelListener" {


   public any function canSendMessage(any message, struct subscriberInfo, struct publisherInfo) {
         writeLog(file="application", text="canSendMessage: #serializeJSON(arguments)#");
      return true;
   }


}
component {
	this.name="websocket_chat_apps_are_dumb";

	this.wschannels = [
		{name="chat"}
	];
	
	public boolean function onApplicationStart() {
		return true;
	}

	public boolean function onRequestStart(string req) {
		if(structKeyExists(url,"init")) {
			applicationStop();
			location(url="index.cfm",addToken="false");
		}
		return true;
	}

}
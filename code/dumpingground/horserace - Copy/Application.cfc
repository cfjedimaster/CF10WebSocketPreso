component {
	this.name = "wspreso_horserace";
	this.wschannels = [
		{name="player",cfclistener:"playerHandler"},
		{name="admin",cfclistener:"adminHandler"}
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
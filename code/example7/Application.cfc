component {
	this.name = "wspreso_example7";
	this.wschannels = [{name="news",cfclistener:"newsHandler"}];

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

	public boolean function onWSAuthenticate(string username, string password, struct connectionInfo) {
		writelog(file="application", text="onWSAuth called. #serializeJSON(arguments)#");
		if(username == "admin" || username == "bob") {
			connectionInfo.authenticated=true;

			//random additional key
			connectionInfo.starwars = 1;

			if(username == "admin") connectionInfo.role = "admin";

			return true;
		} else {
			return false;
		}
		
	}
}
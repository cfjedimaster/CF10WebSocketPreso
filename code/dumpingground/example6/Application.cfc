component {
	this.name = "wspreso_example6ddd";
	this.wschannels = [{name="stocks"}, {name="stockchanges",cfclistener="handler"}];

	public boolean function onApplicationStart() {
		application.stocks = {};
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
component {
	this.name = "wspreso_example6";
	this.wschannels = [{name="stocks"}, {name="stockchanges"}];

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
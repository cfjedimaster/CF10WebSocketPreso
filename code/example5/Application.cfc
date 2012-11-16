component {
	this.name = "wspreso_example5";
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
}
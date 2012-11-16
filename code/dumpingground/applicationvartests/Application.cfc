component {
	this.name = "wspreso_exampleddd_appvartest";
	this.wschannels = [{name="news",cfclistener:"newsHandler"}];
	this.sessionManagement=true;
	
	public boolean function onApplicationStart() {
		application.startup = now();
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
component {
	this.name = "wspreso_example10";
	this.mappings = {"/root" = getDirectoryFromPath(getCurrentTemplatePath()) };
	
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
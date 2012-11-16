component {

	public function testResponse(string str) {
		if(str == "beer") {
			wsSendMessage("You like beer!");
		}
		return reverse(str);
	}

}
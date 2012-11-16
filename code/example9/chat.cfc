component {

	public function doChat(string input) {
		// Yes you can do this too... return {input:input, length:len(input)};
		return len(input) & " * " & input;
	}

}
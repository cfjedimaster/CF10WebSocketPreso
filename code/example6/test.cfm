<cfsetting requesttimeout="999">
<cfset x = 1>
<cfloop condition="x lt 100">

	<cfscript>
	stockList = ["APPL","ADBE","MSFT","GOOG","IBM","WOPR","CAT","DOG"];

	/* bug in cf10
	arrayEach(stockList, function(itm) {

		if(!structKeyExists(application.stocks, itm)) {
			application.stocks[itm] = { stock:itm, price:randRange(100,120)};
		} else {
			change = randRange(-20,20);
			application.stocks[itm].price += change;
			//broadcast the change
			wsPublish("stockchanges", {stock:itm, change:abs(change), netchange:change});
		}
	});
	*/

	for(itm in stockList) {
		if(!structKeyExists(application.stocks, itm)) {
			application.stocks[itm] = { stock:itm, price:randRange(100,120)};
		} else {
			change = randRange(-20,20);
			application.stocks[itm].price += change;
			//broadcast the change
			wsPublish("stockchanges", {stock:itm, change:abs(change), netchange:change});
		}
	}
	</cfscript>


	<cfset wsPublish("stocks", application.stocks)>
	<cfset sleep(4000)>
	<cfset x++>
</cfloop>

<p>Done generating demo content...</p>


<cfset stockList = ["APPL","ADBE","MSFT","GOOG","IBM","WOPR","CAT","DOG"]>

<!DOCTYPE html>
<html>

<head>
<title>Example Six</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script language="javascript">

function doSubscriptions() {
	myWS.subscribe("stocks", {}, stockHandler);
	myWS.subscribe("stockchanges", {selector:"change gt 10"}, alertHandler);
}

function stockHandler(msg) {
	console.log("stockHandler Run");

	if(msg.type == "data") {
		for(var s in msg.data) {
			$("#" + s + "Price").text(msg.data[s].PRICE);
		}
	}
}

function alertHandler(msg) {
	console.log("alertHandler Run");

	if(msg.type == "data") {
		var sp = $("#" + msg.data.STOCK + "PriceAlert");
		sp.text(msg.data.NETCHANGE);
		console.log('netchange = '+msg.data.NETCHANGE);
		if(msg.data.NETCHANGE > 0) { sp.removeClass("negative"); sp.addClass("positive"); }
		if(msg.data.NETCHANGE < 0) { sp.removeClass("positive"); sp.addClass("negative"); }
		sp.fadeOut(2000, function() {
			$(this).text('');
			$(this).show();
		});
	}

}


</script>
<style>
body {
	font-family: verdana,arial,sans-serif;
}

table#stockTable {
	width: 400px;
	font-size:20px;
	color:#333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}
table#stockTable th {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede;
}
table#stockTable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}

.priceAlert {
	font-size: 9px;
	font-style: italic;
}

.positive {
	color: green;
}

.negative {
	color: red;
}
</style>
</head>

<body>

<h1>Stock Listing</h1>

<table id="stockTable">
	<tr>
		<th>Stock</th>
		<th>Price</th>
	</tr>
	<cfloop index="s" array="#stockList#">
	<tr>
		<cfoutput>
		<td>#s#</td>
		<td><span id="#s#Price"></span> <span id="#s#PriceAlert" class="priceAlert"></span></td>
		</cfoutput>
	</tr>
</cfloop>
</table>


</body>
</html>

<cfwebsocket name="myWS" onMessage="stockHandler" onOpen="doSubscriptions">
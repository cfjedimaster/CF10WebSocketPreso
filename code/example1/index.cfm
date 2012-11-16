<!DOCTYPE html>
<html>

<head>
<title>Example One</title>
<script language="javascript">
function messageHandler(msg) {
	console.log("messageHandler Run");
	console.dir(msg);
}
</script>
</head>

<body>

<h1>Example One</h1>

</body>
</html>

<cfwebsocket name="myWS" onMessage="messageHandler" subscribeTo="news">
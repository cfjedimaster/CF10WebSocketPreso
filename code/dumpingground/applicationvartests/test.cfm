<!---
<cfdump var="#wsGetSubscribers('news')#" label="Subscribers">

<cfdump var="#wsGetSubscribers('news.sports')#" label="Subscribers/Sports">

<cfdump var="#wsGetSubscribers('news.sports.football')#" label="Subscribers/Sports/Football">

<cfdump var="#wsGetSubscribers('news.turd')#" label="Turd test">

<cfdump var="#wsGetAllChannels()#" label="All Channels">
--->
<cfscript>
clients = wsGetSubscribers('news');
clientids = [];
arrayEach(clients, function(itm) {
	arrayAppend(clientids,itm.clientid);
});
</cfscript>

<cfif structKeyExists(form, "newmsg") and len(trim(form.newmsg))>
	<cfset message = {msg:form.newmsg,forclient:form.clientid}>
	<cfset wsPublish("news", message)>
</cfif>

<form method="post">
	<select name="clientid">
		<cfloop index="x" array="#clientids#">
			<cfoutput><option>#x#</option></cfoutput>
		</cfloop>
	</select>
	<input type="text" name="newmsg"> <input type="submit" value="Send">
</form>
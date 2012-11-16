<!---
<cfdump var="#wsGetSubscribers('news')#" label="Subscribers">

<cfdump var="#wsGetSubscribers('news.sports')#" label="Subscribers/Sports">

<cfdump var="#wsGetSubscribers('news.sports.football')#" label="Subscribers/Sports/Football">

<cfdump var="#wsGetSubscribers('news.turd')#" label="Turd test">

<cfdump var="#wsGetAllChannels()#" label="All Channels">
--->

<!---
<cfif structKeyExists(form, "newmsg") and len(trim(form.newmsg))>
	<cfset message = {msg:form.newmsg,forclient:form.clientid}>
	<cfset wsPublish("news", form.message)>
</cfif>

<form method="post">
	<select name="clientid">
		<cfloop index="x" array="#clientids#">
			<cfoutput><option>#x#</option></cfoutput>
		</cfloop>
	</select>
	<input type="text" name="newmsg"> <input type="submit" value="Send">
</form>
--->
<cfloop index="x" from="1" to="7">
<cfthread name="count#x#">
	<cfset wsPublish("news", "I'm a thread dude!")>
	<cfset sleep(2000)>
</cfthread>
</cfloop>

<cfthread action="join" />
<cfdump var="#cfthread#">
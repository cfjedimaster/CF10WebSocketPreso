<cfdump var="#wsGetSubscribers('news')#" label="Subscribers">

<cfdump var="#wsGetSubscribers('news.sports')#" label="Subscribers/Sports">

<cfdump var="#wsGetSubscribers('news.sports.football')#" label="Subscribers/Sports/Football">

<cfdump var="#wsGetAllChannels()#" label="All Channels">

<cfif structKeyExists(form, "newmsg") and len(trim(form.newmsg))>
	<cfset wsPublish("news", form.newmsg)>
</cfif>

<form method="post">
	<input type="text" name="newmsg"> <input type="submit" value="Send">
</form>
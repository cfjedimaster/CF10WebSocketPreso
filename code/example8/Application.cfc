<cfcomponent>
	
	<cfset this.name = "wspreso_example8">
	<cfset this.wschannels = [{name="news",cfclistener:"newsHandler"}]>
	<cfset this.sessionManagement=true>
	<cfset this.loginStorage="session">

	<cffunction name="onApplicationStart" returnType="boolean">
		<cfreturn true>
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean">
		<cfargument name="req" type="string" required="true">
		<cfset var doLogin = true>

		<cfif not findNoCase("login.cfm", arguments.req)>
			<cflogin>

				<cfif isDefined("cflogin")>
					<cfif cflogin.name is "admin" or cflogin.name is "bob">
						<cfset var roles = "">
						<cfif cflogin.name is "admin">
							<cfset roles = "admin">
						</cfif>
						<cfloginuser name="#cflogin.name#" password="#cflogin.password#" roles="#roles#">
						<cfset doLogin = false>
					</cfif>
				</cfif>

				<cfif doLogin>
					<cflocation url="login.cfm" addToken="false">
				</cfif>

			</cflogin>
		</cfif>
		<cfreturn true>
	</cffunction>


</cfcomponent>

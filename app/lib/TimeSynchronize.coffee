if Meteor.isClient
	subServerAndClientTime = 0

	initServerTime = ->
		Meteor.call "getServerTimeStamp", (error, result) ->
			subServerAndClientTime = result - (new Date()).getTime()

	getSynchronizeTime = ->
		subServerAndClientTime + (new Date()).getTime()

	@initServerTime = initServerTime
	@getSynchronizeTime = getSynchronizeTime

if Meteor.isServer
	Meteor.methods getServerTimeStamp : () ->
		(new Date()).getTime()
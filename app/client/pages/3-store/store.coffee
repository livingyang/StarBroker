Template.store.events "click #inviteStar" : ->
	Meteor.call "inviteStar", (error, result) ->
		console.log "inviteStar !!"
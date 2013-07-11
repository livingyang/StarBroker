Stars = new Meteor.Collection "stars"

StarModels = new IndexRecord
	array: starModels
	key: "name"

if Meteor.isServer

	Meteor.methods
		inviteStar : () ->
			starName = StarModels.randomKey()
			console.log "user: #{Meteor.userId()} invite star #{starName}"
			Stars.insert
				"owner": Meteor.userId()
				"model": starName

@StarModels = StarModels
@Stars = Stars
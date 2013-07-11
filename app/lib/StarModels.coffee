Stars = new Meteor.Collection "stars"

StarModels = new IndexRecord
	array: starModels
	key: "name"

if Meteor.isClient
	addStarExp = (starId, exp) ->
		Meteor.call "addStarExp", starId, exp, (error, result) ->
			console.log "error addStarExp !!" if error?
	@addStarExp = addStarExp

if Meteor.isServer

	Meteor.methods
		inviteStar : () ->
			starName = StarModels.randomKey()
			console.log "user: #{Meteor.userId()} invite star #{starName}"
			Stars.insert
				owner: Meteor.userId()
				model: starName
				exp: 0

		addStarExp: (starId, exp) ->
			console.log "user: #{Meteor.userId()} star: #{starId} addExp: #{exp}"
			Stars.update {_id: starId}, {$inc:{exp: Number(exp)}}
	


@StarModels = StarModels
@Stars = Stars
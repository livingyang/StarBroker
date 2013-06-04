
getUserField = (field) ->
	Meteor.users.findOne({_id: Meteor.userId()})[field]

updateUserField = (field, value) ->
	if not getUserField field?
		console.log "set field"

Template.purchase.events "click .money1000" : ->
	console.log "money1000!!"

	console.log getUserField "_id"

	if not getUserField field?
		Meteor.users.update {_id: Meteor.userId()}, {$set: {money: 0}}

	console.log getUserField "money"


	# console.log Meteor.users.update({_id: Meteor.userId()})

Template.purchase.events "click .money10000" : ->
	console.log "money10000!!"

Template.purchase.events "click .gold100" : ->
	console.log "gold100!!"

Template.purchase.events "click .gold1000" : ->
	console.log "gold1000!!"

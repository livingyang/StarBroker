Template.purchase.events "click .money1000" : ->
	Meteor.call "addMoney", 1000, (error, result) ->
		console.log "addMoney1000 !!"

Template.purchase.events "click .money10000" : ->
	Meteor.call "addMoney", 10000, (error, result) ->
		console.log "addMoney10000 !!"

Template.purchase.events "click .gold100" : ->
	Meteor.call "addGold", 100, (error, result) ->
		console.log "addGold100 !!"

Template.purchase.events "click .gold1000" : ->
	Meteor.call "addGold", 1000, (error, result) ->
		console.log "addGold1000 !!"

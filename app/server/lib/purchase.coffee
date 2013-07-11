
Meteor.methods
	
	addMoney : (money) ->
		console.log "user: #{Meteor.userId()} addMoney: #{money}"
		Company.update {owner: Meteor.userId()}, {$inc:{money: Number(money)}}
	
	addGold : (gold) ->
		console.log "user: #{Meteor.userId()} addGold: #{gold}"
		Company.update {owner: Meteor.userId()}, {$inc:{gold: Number(gold)}}
	
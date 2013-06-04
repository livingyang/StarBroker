
insertDocumentsToCollection StarModels, "server/csv/starModels.csv"

Meteor.startup ->
	console.log "\nMeteor.startup: #{new Date()}"

Accounts.onCreateUser (options, user) ->
	Company.insert
		owner : user._id
		money : 0
		gold : 0
	user

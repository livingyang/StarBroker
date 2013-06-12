
insertDocumentsToCollection StarModels, "server/csv/starModels.csv"

Meteor.startup ->
	console.log "\nMeteor.startup: #{new Date()}"
	

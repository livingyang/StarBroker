
createCollectionsWithDir "server/csv/"

Meteor.startup ->
	console.log "\nMeteor.startup: #{new Date()}"

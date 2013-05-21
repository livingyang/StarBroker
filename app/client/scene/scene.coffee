showPage = (name) ->
	$("#container").html Meteor.render ->
		Template[name]()

@showPage = showPage

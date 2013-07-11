setPageNameToList "starModelList"

Template.starModelList.starModels = ->
	starModels

Template.starModelList.stars = ->
	starList = []
	(Stars.find owner: Meteor.userId()).forEach (star) ->
		starList.push StarModels.objectForKey(star.model)
	starList
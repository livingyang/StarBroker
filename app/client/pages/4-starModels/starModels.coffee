Template.starModelList.starModels = ->
	StarModels.find()

Template.starModelList.stars = ->
	starList = []
	(Stars.find owner: Meteor.userId()).forEach (star) ->
		starList.push StarModels.findOne _id: star.model
	starList
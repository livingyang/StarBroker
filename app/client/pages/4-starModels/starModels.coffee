setPageNameToList "starModelList"

Template.starModelList.starModels = ->
	starModels

Template.starModelList.stars = ->
	Stars.find (owner: Meteor.userId())

Template.star.acting = ->
	this.model

Template.star.events "click #addExp" : ->
	addStarExp @_id, 10
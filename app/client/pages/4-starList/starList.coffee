Stars = new Meteor.Collection "stars"

Template.starList.stars = ->
	Stars.find()